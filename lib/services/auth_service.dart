import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/services/auth_header.dart';

import '../constants/constants.dart';


class AuthService {
  static const usersUrl = kAppApiUrl + '/users/';
  static const userUrl = kAppApiUrl + '/user/';
  static const authUrl = kAppApiUrl + '/auth/';

  AuthService();

  Future<User> authenticateWithFaceBook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken.token);
        return _authenticateFacebookUserOnServer(result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        throw Exception('Facebook Login Cancelled!');
        break;
      case FacebookLoginStatus.error:
        throw Exception('Facebook Login Failed!');
        break;
      default:
        throw Exception('Facebook Login Failed!');
    }
  }

  Future<User> authenticateWithGoogle() async {
    GoogleSignInAuthentication googleAuth;
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      googleAuth = await googleUser.authentication;
    } catch (error) {
      throw Exception('Failed to connect to Google!');
    }
    return _authenticateGoogleUserOnServer(googleAuth.idToken);
  }

  Future<User> signUpWithEmailAndPassword(username, email, password) async {
    Response response;
    try {
      Dio dio = new Dio();
      response = await dio.post(usersUrl,
          data: {'username': username, 'email': email, 'password': password});
     return _handleAuthResponse(response);
    } on DioError catch (error) {
      if (error.response != null) {
        throw Exception(error.response.data['message']);
      } else {
        throw Exception('Error connecting to server!');
      }
    }
  }

  Future<User> signInWithEmailAndPassword(loginDetial, password) async {
    Response response;
    try {
      Dio dio = new Dio();
      response = await dio.post(authUrl + 'login',
          data: {'username': loginDetial, 'password': password});
      return _handleAuthResponse(response);
    } on DioError catch (error) {
      if (error.response != null) {
        throw Exception(error.response.data['message']);
      } else {
        throw Exception('Error connecting to server!');
      }
    }
  }
  Future<User> refreshToken() async {
    Response response;
    try {
      Dio dio = new Dio();
      Options authHeaderOption = await getAuthHeaderOption();
      response = await dio.get(authUrl + 'refresh', options: authHeaderOption);
      return _handleAuthResponse(response);
    } on DioError catch (error) {
      if (error.response != null) {
        throw Exception(error.response.data['message']);
      } else {
        throw Exception('Error connecting to server!');
      }
    }
  }
  Future<User> fetchAuthenticatedUser() async {
    Response response;
    try {
      Dio dio = new Dio();
      Options authHeaderOption = await getAuthHeaderOption();
      response = await dio.get(userUrl, options: authHeaderOption);
      return _handleAuthResponse(response);
    } on DioError catch (error) {
      if (error.response != null) {
        throw Exception(error.response.data['message']);
      } else {
        throw Exception('Error connecting to server!');
      }
    }
  }
  

  Future<User> _authenticateFacebookUserOnServer(String accessToken) async {
    Response response;
    try {
      Dio dio = new Dio();
      response = await dio.post(authUrl + 'facebook/token',
          data: {'access_token': accessToken});
     return _handleAuthResponse(response);
    } catch (error) {
      if (error.response != null) {
        throw Exception(error.response.data['message']);
      } else {
        throw Exception('Error connecting to server!');
      }
    }
  }

  Future<User> _authenticateGoogleUserOnServer(String idToken) async {
    Response response;
    try {
      Dio dio = new Dio();
      response =
          await dio.post(authUrl + 'google/token', data: {'id_token': idToken});
      return _handleAuthResponse(response);
    } catch (error) {
      if (error.response != null) {
        throw Exception(error.response.data['message']);
      } else {
        throw Exception('Error connecting to server');
      }
    }
  }

  _saveUserDetailsToPreference(User user, String userJwtToken, String tokenExpires) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(kUserJwtTokenPrefKey, userJwtToken);
    pref.setString(kUserJwtTokenExpiresPrefKey, tokenExpires);
    pref.setInt(kUserIdPrefKey, user.id);
    pref.setString(kUsernamePrefKey, user.username);
    pref.setString(kUserEmailPrefKey, user.email);
    pref.setString(kUserPhotoUrlPrefKey, user.photoUrl);
  }

  User _handleAuthResponse(Response response){
      User authenticatedUser = User.fromJson(response.data['user']);
      String userJwtToken = response.data['token'];
      String tokenExpires = response.data['tokenExpires'];
      _saveUserDetailsToPreference(authenticatedUser, userJwtToken, tokenExpires);
      return authenticatedUser;
  }

  Future<bool> shouldRefreshToken() async{
      SharedPreferences pref = await SharedPreferences.getInstance();
      DateTime tokenExpireDate =  DateTime.parse(pref.getString(kUserJwtTokenExpiresPrefKey));

      print(tokenExpireDate.difference(DateTime.now()).inDays);
      if(tokenExpireDate.difference(DateTime.now()).inDays < 10){
        return true;
      }else{
        return false;
      }

  }


  Future<User> getUserFromPreference() async{

        SharedPreferences pref = await SharedPreferences.getInstance();
        try{
            DateTime tokenExpireDate =  DateTime.parse(pref.getString(kUserJwtTokenExpiresPrefKey));
              if(tokenExpireDate.isAfter(DateTime.now())){
                  return User((b) => b
                  ..id = pref.getInt(kUserIdPrefKey)
                  ..username = pref.getString(kUsernamePrefKey)
                  ..email = pref.getString(kUserEmailPrefKey)
                  ..photoUrl = pref.getString(kUserPhotoUrlPrefKey)
              );
            }else{
              deleteUserPreference();
              return null;
            }

        }catch(err){
          return null;
        }
       
  }

  deleteUserPreference() async{
       SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove(kUserJwtTokenPrefKey);
        pref.remove(kUserJwtTokenExpiresPrefKey);
        pref.remove(kUserIdPrefKey);
        pref.remove(kUsernamePrefKey);
        pref.remove(kUserEmailPrefKey);
        pref.remove(kUserPhotoUrlPrefKey);

  }

}
