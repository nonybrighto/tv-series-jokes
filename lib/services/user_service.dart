import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_series_jokes/blocs/user_list_bloc.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/models/user_list_response.dart';
import 'package:tv_series_jokes/services/auth_header.dart';
import 'package:tv_series_jokes/services/error_handler.dart';
import 'package:tv_series_jokes/utils/image_compressor.dart';
import '../constants/constants.dart';

class UserService {

  final String authUrl = kAppApiUrl+'/auth';
  final String userUrl = kAppApiUrl + '/user/';
  final String usersUrl = kAppApiUrl + '/users/';
  final String jokesUrl = kAppApiUrl + '/jokes/';
  final String moviesUrl = kAppApiUrl + '/movies/';

  Dio dio = new Dio();

  Map<String , String> headers = {'contentType':'application/json'};

  UserService();

Future<User> getUser(User user) async{


    try {
       Options authHeaderOption = await getAuthHeaderOption();
       Response response = await dio.get(usersUrl + '${user.id}', options: authHeaderOption);
      return User.fromJson(response.data);
    } catch(error){
        return handleError(error: error, message: 'getting user\'s details');  
    }
}


Future<UserListResponse> fetchJokeLikers({Joke jokeLiked, int page}) async{

     try {
       Options authHeaderOption = await getAuthHeaderOption();
       Response response = await dio.get(jokesUrl + '${jokeLiked.id}/likes?page=$page', options: authHeaderOption);
      return UserListResponse.fromJson(response.data);
    }catch(error){
        return handleError(error: error, message: 'fetching joke likers');  
    }
   
}

Future<bool> changeUserFollow({User user, bool follow}) async{
    try {
          Options authHeaderOption = await getAuthHeaderOption();
          if(follow){
              await dio.put(usersUrl + '${user.id}/followers', options: authHeaderOption);
          }else{
              await dio.delete(usersUrl + '${user.id}/followers', options: authHeaderOption);
          }
          return true;
        }catch(error){
          return handleError(error: error, message: 'toggling user follow');  
        }

}

Future<UserListResponse> fetchUserFollow({User user, int page, UserFollowType userFollowType}) async{

      String followTypeString;
     try {
       followTypeString = (userFollowType == UserFollowType.followers)?'followers':'following';
       Options authHeaderOption = await getAuthHeaderOption();
       Response response = await dio.get(usersUrl + '${user.id}/$followTypeString?page=$page', options: authHeaderOption);
      return UserListResponse.fromJson(response.data);
    }catch(error){
        return handleError(error: error, message: 'fetching $followTypeString');  
    }
  
}
Future<UserListResponse> fetchMovieFollowers({Movie movie, int page}) async{

     try {
       Options authHeaderOption = await getAuthHeaderOption();
       Response response = await dio.get(moviesUrl + '${movie.id}/followers?page=$page', options: authHeaderOption);
      return UserListResponse.fromJson(response.data);
    }catch(error){
        return handleError(error: error, message: 'fetching movie followers');  
    } 
  
}

Future<User> changeUserPhoto({File photo}) async{

  
    try{
          String fileName = basename(photo.path);
          File compressedFile = await compressImage(imageFile:photo, width:130, imageTemporaryPath: await generateImageTempPath()); 
    Map<String, dynamic> responseData = FormData.from({'image': UploadFileInfo(compressedFile, fileName)});
     Options authHeaderOption = await getAuthHeaderOption();
    Response response = await dio.put(userUrl+'photo',
          data: responseData, options: authHeaderOption);
          updateUserPhotoPreference(response.data['profilePhoto']);
          return User.fromJson(response.data);
    }catch(error){
        return handleError(error: error, message: 'changing photo');  
    } 
}

updateUserPhotoPreference(String photoUrl) async{
     SharedPreferences pref = await SharedPreferences.getInstance();
     pref.setString(kUserProfilePhotoPrefKey, photoUrl);
}

}
