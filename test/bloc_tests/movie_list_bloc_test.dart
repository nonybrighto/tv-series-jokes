import 'package:built_collection/built_collection.dart';
import 'package:tv_series_jokes/blocs/movie_list_bloc.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/models/movie/movie_list_response.dart';
import 'package:tv_series_jokes/services/movie_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';


void main(){


  MovieService movieService;
  BuiltList<Movie> sampleMovies;

  setUp((){

     movieService = MockMovieService();

      sampleMovies = BuiltList([
        Movie((b) => b
      ..id = 1
      ..name = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = true
      ..overview = 'desc'
      ..jokeCount = 10
      ..firstAirDate = DateTime(2000,10,10)
      ..followerCount = 10
      ..tmdbDetails.id = 1
      ..tmdbDetails.name = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.firstAirDate = DateTime(2000,10,10)
      ..tmdbDetails.lastAirDate = DateTime(2000,10,10)
      ..tmdbDetails.numberOfSeasons = 5
      ..tmdbDetails.voteAverage = 8.9
      )
      ]);

      when(movieService.getMovies(page: anyNamed('page')))..thenAnswer((_) async =>MovieListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleMovies.toBuilder()));

  });

  // test('Expect jokes to be gotten once started', () {
  //   MovieListBloc movieListBloc =
  //     MovieListBloc(movieService: movieService);

  //   expect(movieListBloc.loadState, emitsAnyOf([loading, loadingMore]));
  // });

  
  test('when loading the second time, expect state to be loading more and list should contain two items',() async{

    MovieListBloc movieListBloc =
      MovieListBloc(movieService: movieService);

    movieListBloc.getItems();

    expect(movieListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loaded]));
    expect(movieListBloc.items, emits([sampleMovies[0], sampleMovies[0] ]));
  });



  test('Movie content can be updated', () async{

      MovieListBloc movieListBloc =MovieListBloc(movieService: movieService);

      await Future.delayed(Duration(seconds: 5));

      movieListBloc.updateItem(sampleMovies[0]);
      expect(movieListBloc.items, emits([sampleMovies[0]]));
    
  });
}