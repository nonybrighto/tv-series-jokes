import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

handleError({@required dynamic error, @required String message}){

    String exceptionMessage = 'Error occured';
    if(error is DioError){
        if(error.response != null && error.response.data['message'] != null){
          exceptionMessage = error.response.data['message'];
        }else if(error.response != null){
          exceptionMessage = 'Error occured in server while $message';
        }else{
          exceptionMessage = 'Error connecting to server';
        }
    }else{
      exceptionMessage = 'Unknown Client Error occured while $message';
    }
    throw Exception(exceptionMessage);
}