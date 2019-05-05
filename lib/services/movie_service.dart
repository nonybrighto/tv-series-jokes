import 'dart:async';

import 'package:dio/dio.dart';
import 'package:tv_series_jokes/constants/constants.dart';
import 'package:tv_series_jokes/constants/secrets.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/models/movie/movie_list_response.dart';
import 'package:tv_series_jokes/models/movie/tmdb_movie.dart';
import 'package:tv_series_jokes/models/movie/tmdb_movie_list_response.dart';
import 'package:tv_series_jokes/services/auth_header.dart';

class MovieService{


  Dio dio = Dio();

  final String moviesUrl = kAppApiUrl + '/movies/';
  final String tmdbmovieUrl =kTmdbApiUrl + '/tv/';
  final String tmdbSearchMovieUrl =kTmdbApiUrl + '/search/tv/';

  Future<MovieListResponse> getMovies({int page}) async{

    try {
      Options authHeaderOption = await getAuthHeaderOption();
      Response response = await dio.get(moviesUrl + '?page=$page', options: authHeaderOption);
        return MovieListResponse.fromJson(response.data);

    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }

  Future<Movie>  getMovie(Movie movie) async{

    String tmdbMovieUrl = tmdbmovieUrl+'${movie.tmdbMovieId}?api_key=$kTmdbApiKey&append_to_response=credits,images';

     try {

      Options authHeaderOption = await getAuthHeaderOption();
      List<Response> response = await Future.wait([dio.get(tmdbMovieUrl), dio.get(moviesUrl+'${movie.id}', options: authHeaderOption)]);
      TmdbMovie tmdbMovieDetails = TmdbMovie.fromJson(response[0].data);
      Movie gottenMovie =  Movie.fromJson(response[1].data);
      return gottenMovie.rebuild((b) => b.tmdbDetails = tmdbMovieDetails.toBuilder());

    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
   
  }

  Future<bool> changeMovieFollow({Movie movie, bool follow}) async{

        try {
          Options authHeaderOption = await getAuthHeaderOption();
          if(follow){
              await dio.put(moviesUrl + '${movie.id}/following', options: authHeaderOption);
          }else{
              await dio.delete(moviesUrl + '${movie.id}/following', options: authHeaderOption);
          }
          return true;
        } on DioError catch (error) {
          throw Exception((error.response != null)
              ? error.response.data['message']
              : 'Error Connectiing to server');
        }
  }
  
  Future<TmdbMovieListResponse> searchTmdbMovie({String searchString, int page = 1}) async{

    try {
      Options authHeaderOption = await getAuthHeaderOption();
      Response response = await dio.get(tmdbSearchMovieUrl + '?api_key=$kTmdbApiKey&query=$searchString&page=$page', options: authHeaderOption);
        return TmdbMovieListResponse.fromJson(response.data);

    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }

  Future<List<TmdbMovie>> searchTmdbMovieAsList({String searchString, int page = 1}) async{

    try{
        TmdbMovieListResponse searchedMovie = await searchTmdbMovie(searchString:searchString, page:page);
        return searchedMovie.results.toList();

    }catch(error){
     throw Exception('Error while getting movie');
    }

  }
}