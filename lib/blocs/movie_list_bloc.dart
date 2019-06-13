import 'dart:async';
import 'package:tv_series_jokes/blocs/list_bloc.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/models/movie/movie_list_response.dart';
import 'package:tv_series_jokes/services/movie_service.dart';


class MovieListBloc extends ListBloc<Movie>{
 
 final MovieService movieService;


  //stream


  //sink



 
 MovieListBloc({this.movieService}){
      super.getItems(); 
 }
 

  @override
  Future<MovieListResponse> fetchFromServer() async{
    return  await movieService.getMovies(page: super.currentPage);
  }

  @override
  bool itemIdentificationCondition(Movie currentMovie, Movie updatedMovie) {
    return currentMovie.id == updatedMovie.id;
  }

  @override
  String getEmptyResultMessage() {
    
    return 'No Movies to display';
  }
}
