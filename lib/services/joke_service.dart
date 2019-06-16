import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tv_series_jokes/constants/constants.dart';
import 'package:tv_series_jokes/models/comment.dart';
import 'package:tv_series_jokes/models/comment_list_response.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/joke_list_response.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/services/auth_header.dart';
import 'package:path/path.dart';
import 'package:tv_series_jokes/services/error_handler.dart';
import 'package:tv_series_jokes/utils/image_compressor.dart';

class JokeService {
  final String jokesUrl = kAppApiUrl + '/jokes/';
  final String userUrl = kAppApiUrl + '/user/';
  final String usersUrl = kAppApiUrl + '/users/';
  final String moviesUrl = kAppApiUrl + '/movies/';
  Dio dio = new Dio();

  Future<JokeListResponse> fetchLatestJokes({int page}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      Response response =
          await dio.get(jokesUrl + '?page=$page', options: authHeaderOption);
      return JokeListResponse.fromJson(response.data);
    }catch(error){
        return handleError(error: error, message: 'getting latest jokes');  
    }
  }

  Future<JokeListResponse> fetchPopularJokes({int page}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      Response response = await dio.get(jokesUrl + 'popular?page=$page',
          options: authHeaderOption);
      return JokeListResponse.fromJson(response.data);
    } catch(error){
        return handleError(error: error, message: 'getting popular jokes');  
    }
  }

  Future<JokeListResponse> fetchUserFavJokes({int page}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      Response response = await dio.get(userUrl + 'favorites/jokes?page=$page',
          options: authHeaderOption);
      return JokeListResponse.fromJson(response.data);
    } catch(error){
        return handleError(error: error, message: 'getting favorite jokes');  
    }
  }

  Future<JokeListResponse> fetchMovieJokes({Movie movie, int page}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      Response response = await dio.get(
          moviesUrl + '${movie.id}/jokes?page=$page',
          options: authHeaderOption);
      return JokeListResponse.fromJson(response.data);
    } catch(error){
        return handleError(error: error, message: 'getting movie jokes');  
    }
  }

  Future<JokeListResponse> fetchUserJokes({User user, int page}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      Response response = await dio.get(
          usersUrl + '${user.id}/jokes?page=$page',
          options: authHeaderOption);
      return JokeListResponse.fromJson(response.data);
    } catch(error){
        return handleError(error: error, message: 'getting user jokes');  
    }
  }

  Future<Comment> addComment(
      {Joke joke, String content, String anonymousName}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      final data = {'content': content}..addAll(
          (anonymousName.isNotEmpty) ? {'anonymousName': anonymousName} : {});
      Response response = await dio.post(jokesUrl + '${joke.id}/comments',
          options: authHeaderOption, data: data);
      return Comment.fromJson(response.data);
    } catch(error){
        return handleError(error: error, message: 'adding comments');  
    }
  }

  Future<CommentListResponse> getComments({Joke joke, int page}) async {
    try {
      Response response =
          await dio.get(jokesUrl + '/${joke.id}/comments?page=$page');
      return CommentListResponse.fromJson(response.data);
    } catch(error){
        return handleError(error: error, message: 'getting comments');  
    }
  }

  Future<Joke> addJoke({Map<String, dynamic> jokeUploadDetails}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      File imageToUpload = jokeUploadDetails['imageToUpload'];
      File newFile;
      if (imageToUpload != null) {
        newFile = await compressImage(
            imageFile: imageToUpload,
            width: 500,
            imageTemporaryPath: await generateImageTempPath());
      }
      String fileName =
          (imageToUpload != null) ? basename(imageToUpload.path) : '';
      Map<String, dynamic> gottenData = {
        'title': jokeUploadDetails['title'],
        'tmdbMovieId': jokeUploadDetails['tmdbMovieId'],
      }
        ..addAll((imageToUpload != null)
            ? {'image': UploadFileInfo(newFile, fileName)}
            : {})
        ..addAll(((jokeUploadDetails['text'] as String).isNotEmpty)
            ? {'text': jokeUploadDetails['text']}
            : {});

      Map<String, dynamic> responseData =
          (imageToUpload == null) ? gottenData : FormData.from(gottenData);
      Response response = await dio.post(jokesUrl,
          data: responseData, options: authHeaderOption);
      return Joke.fromJson(response.data);
    } catch(error){
        return handleError(error: error, message: 'adding joke');  
    }
  }

  Future<bool> changeJokeLiking({Joke joke, bool like}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      if (like) {
        await dio.put(jokesUrl + '${joke.id}/likes', options: authHeaderOption);
      } else {
        await dio.delete(jokesUrl + '${joke.id}/likes',
            options: authHeaderOption);
      }
      return true;
    } catch(error){
        return handleError(error: error, message: 'toggling joke like');  
    }
  }

  Future<bool> changeJokeFavoriting({Joke joke, bool favorite}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      if (favorite) {
        await dio.put(userUrl + 'favorites/jokes/${joke.id}',
            options: authHeaderOption);
      } else {
        await dio.delete(userUrl + 'favorites/jokes/${joke.id}',
            options: authHeaderOption);
      }
      return true;
    } catch(error){
        return handleError(error: error, message: 'toggling joke favorite');  
    }
  }

  Future<bool> deleteJoke({Joke joke}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      await dio.delete(jokesUrl + '${joke.id}', options: authHeaderOption);
      return true;
    } catch(error){
        return handleError(error: error, message: 'deleting joke');  
    }
  }

  Future<bool> reportJoke({Joke joke}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      await dio.put(jokesUrl + '${joke.id}/reports', options: authHeaderOption);
      return true;
    }catch(error){
        return handleError(error: error, message: 'reporting jokes');  
    }
  }
}
