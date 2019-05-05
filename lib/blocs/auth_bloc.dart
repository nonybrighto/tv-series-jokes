import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/models/auth.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/services/auth_service.dart';

class AuthBloc extends BlocBase {
  AuthService authService;
  bool updatedDetails;

  final _currentUserController = BehaviorSubject<User>();
  final _isAuthenticatedController =BehaviorSubject<bool>(seedValue: false);
  final _loadStateController = BehaviorSubject<LoadState>();
  final _socialLoginController = StreamController<Map>();
  final _signUpController = StreamController<Map>();
  final _loginController = StreamController<Map>();
  final _logoutController = StreamController<Null>();

  Function(SocialLoginType , Function(bool, String)) get loginWithSocial =>
      (socialLoginType, authCallBack) => _socialLoginController.sink.add({'socialLoginType':socialLoginType, 'authCallBack':authCallBack});
  Function(String, String, String, Function(bool, String)) get signUp =>
      (username, email, password, authCallBack) => _signUpController.sink
          .add({'username': username, 'email': email, 'password': password, 'authCallBack':authCallBack});
  Function(String, String, Function(bool, String)) get login => (email, password, authCallBack) =>
      _loginController.sink.add({'email': email, 'password': password, 'authCallBack':authCallBack});

  Function(User) get changeCurrentUser => (user) => _currentUserController.sink.add(user);
  Function() get logout => () => _logoutController.sink.add(null);

  Stream<User> get currentUser => _currentUserController.stream;
  Stream<LoadState> get loadState => _loadStateController.stream;
  Stream<bool> get isAuthenticated => _isAuthenticatedController.stream;


  AuthBloc({this.authService}) {
     
      _processAuthUser();

      _loadStateController.sink.add(Loaded());
      _socialLoginController.stream.listen(_handleSocialLogin);
      _loginController.stream.listen(_handleLogin);
      _signUpController.stream.listen(_handleSignUp);

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


  _handleSignUp(Map signUpCredential) async {
    _startAuthProcess(() {
      return authService.signUpWithEmailAndPassword(
          signUpCredential['username'],
          signUpCredential['email'],
          signUpCredential['password']);
    }, callBackFunction: signUpCredential['authCallBack']);
  }

  _handleLogin(Map loginCredential) async {
    _startAuthProcess(() {
      return authService.signInWithEmailAndPassword(
          loginCredential['email'], loginCredential['password']);
    }, callBackFunction: loginCredential['authCallBack']);
  }

  _handleSocialLogin(Map loginCredentials) async {
    SocialLoginType socialLoginType = loginCredentials['socialLoginType'];
    Function(bool, String) callBackFunction = loginCredentials['authCallBack'];

    if (socialLoginType == SocialLoginType.facebook) {
      _startAuthProcess(() {
        return authService.authenticateWithFaceBook();
      }, callBackFunction: callBackFunction);
    } else if (socialLoginType == SocialLoginType.google) {
      _startAuthProcess(() {
        return authService.authenticateWithGoogle();
      }, callBackFunction: callBackFunction);
    }
  }

  _startAuthProcess(Future<User> Function() authResult, {Function(bool, String) callBackFunction}) async {
    _loadStateController.sink.add(Loading());
    try {
      User user = await authResult();
      _currentUserController.sink.add(user);
      _loadStateController.sink.add(Loaded());
      callBackFunction(true, '');
    } catch (appError) {
      String errorMessage = appError.toString();
      _loadStateController.sink.add(LoadError(errorMessage));
      callBackFunction(false, errorMessage);
    }
  }

  @override
  void dispose() {
    _currentUserController.close();
    _socialLoginController.close();
    _loadStateController.close();
    _signUpController.close();
    _loginController.close();
    _logoutController.close();
    _isAuthenticatedController.close();
  }
}
