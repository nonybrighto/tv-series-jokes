import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/services/user_service.dart';

class  UserDetailsBloc extends BlocBase {
 
 User viewedUser;
 UserService userService;

  final _userController = BehaviorSubject<User>();
  final _loadStateController = BehaviorSubject<LoadState>();
  final _getUserDetailsController = StreamController<Null>();


  //stream
  Stream<LoadState> get loadState => _loadStateController.stream;
  Stream<User> get user => _userController.stream;

  //sink
  void Function() get getUserDetails => () => _getUserDetailsController.sink.add(null);

 UserDetailsBloc({this.viewedUser, this.userService}){

    _userController.sink.add(viewedUser);
           getUserDetails();
        

         _getUserDetailsController.stream.listen((_){
            _getUserFromSource();
      });



 }
 
 _getUserFromSource() async{
    _loadStateController.sink.add(Loading());
        try{
            User userGotten = await userService.getUser(viewedUser);
             viewedUser  = userGotten;
            _userController.sink.add(userGotten);
            _loadStateController.sink.add(Loaded());
        }catch(err){
            _loadStateController.sink.add(LoadError('Could not get user Details'));
        }
  }

  //user control bloc calls this to change the user details in this bloc eg When follow button is clicked 
  updateUser(User updatedUser){
        viewedUser  = updatedUser;
        _userController.sink.add(updatedUser);
  }
 
 
  @override
  void dispose() {
    _userController.close();
    _loadStateController.close();
    _getUserDetailsController.close();
  }
  
}