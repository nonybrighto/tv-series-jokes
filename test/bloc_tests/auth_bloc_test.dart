import 'package:tv_series_jokes/blocs/auth_bloc.dart';
import 'package:tv_series_jokes/blocs/auth_page_bloc.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_jokes/services/auth_service.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';



bool didLogin = false;
String errorMessage;


_authCallBack(bool didLogin, String message){

        if(didLogin){
           didLogin = true;
        }else{
            errorMessage = message;
        }
  }

void main(){

  AuthService authService = MockAuthService();
  test('set currentUser when login success', () async{

    User user = User((b) => b
      ..id=1
      ..username='john'
      ..profilePhoto='theurl'
    );

    when(authService.signInWithEmailAndPassword('john@email.com', 'password123')).thenAnswer((_) async =>  user);

    AuthBloc authBloc = AuthBloc(authService: authService);
    AuthPageBloc authPageBloc = AuthPageBloc(authBloc: authBloc);
    authPageBloc.login('john@email.com', 'password123', _authCallBack);
    
    expect(authPageBloc.loadState, emitsInOrder([loaded, loading, loaded]));

    await Future.delayed(Duration(seconds: 0));
    expect(authBloc.currentUser, emits(user));
    verify(authService.signInWithEmailAndPassword('john@email.com', 'password123'));
  });

  test('call error delegate when error in login process', () async{

    when(authService.signInWithEmailAndPassword('john@email.com', 'password123')).thenAnswer((_)  =>  Future.error('error occured'));

    AuthBloc authBloc = AuthBloc(authService: authService);
    AuthPageBloc authPageBloc = AuthPageBloc(authBloc: authBloc);
    authPageBloc.login('john@email.com', 'password123', _authCallBack);
    
    expect(authPageBloc.loadState, emitsInOrder([loaded, loading, loadError]));
    await Future.delayed(Duration(seconds: 0));
    expect(errorMessage, 'error occured');
    verify(authService.signInWithEmailAndPassword('john@email.com', 'password123'));

  });

  test('clear preference when logout', () async{

         AuthBloc authBloc = AuthBloc(authService: authService);
         authBloc.logout();
         await Future.delayed(Duration(seconds: 0));
         verify(authService.deleteUserPreference());

  });
}