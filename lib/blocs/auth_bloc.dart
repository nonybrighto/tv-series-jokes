import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/services/auth_service.dart';

class AuthBloc extends BlocBase {
  AuthService authService;
  bool updatedDetails;

  final _currentUserController = BehaviorSubject<User>();
  final _isAuthenticatedController =BehaviorSubject<bool>(seedValue: false);
  final _logoutController = StreamController<Null>();
 

 

  Function(User) get changeCurrentUser => (user) => _currentUserController.sink.add(user);
  Function() get logout => () => _logoutController.sink.add(null);

  Stream<User> get currentUser => _currentUserController.stream;
  Stream<bool> get isAuthenticated => _isAuthenticatedController.stream;


  AuthBloc({this.authService}) {
     
      _processAuthUser();

     

      _currentUserController.stream.listen((user){
            _isAuthenticatedController.sink.add((user != null)? true : false);
      });

      _logoutController.stream.listen((_) async{
            _currentUserController.sink.add(null);
            await authService.deleteUserPreference();
      });
  }

  _processAuthUser() async{

    User authUser = await authService.getUserFromPreference();
    if(authUser != null){
          _currentUserController.sink.add(authUser);
          if(await authService.shouldRefreshToken()){
             try{
                User user = await authService.refreshToken();
              if(user != null){
                _currentUserController.sink.add(user);
              }
             }catch(error){
               updatedDetails = false; 
             }
          }else{
            //fetch fresh user details
            try{
                User user = await  authService.fetchAuthenticatedUser();
                 _currentUserController.sink.add(user);
            }catch(err){
                updatedDetails = false;
            }
          }
    }
  }


  

  @override
  void dispose() {
    _currentUserController.close();
    _logoutController.close();
    _isAuthenticatedController.close();
  }
}
