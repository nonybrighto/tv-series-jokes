import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_series_jokes/constants/constants.dart';

Future<Options> getAuthHeaderOption() async{

  SharedPreferences pref  = await SharedPreferences.getInstance();

  String userJwtToken = await pref.get(kUserJwtTokenPrefKey);
  if(userJwtToken != null){
    return Options(
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $userJwtToken' , // set content-length
      },
    );
  }
  return null;
}

Future<bool> isAuthenticated() async{

      SharedPreferences pref  = await SharedPreferences.getInstance();
      String userJwtToken = await pref.get(kUserJwtTokenPrefKey);

      if(userJwtToken != null){
        return true;
      }else{
        return false;
      }
}