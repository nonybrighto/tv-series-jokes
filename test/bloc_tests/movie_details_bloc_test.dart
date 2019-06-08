import 'package:mockito/mockito.dart';
import 'package:tv_series_jokes/blocs/movie_details_bloc.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/services/movie_service.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';

void main() {
 

  setUp(() {
  });

  test('Load movie if it is incomplete', () async{
    MovieService movieService = MockMovieService();

    Movie movieToGet = Movie((b) => b
          ..id = 1
          ..name = 'name ssnum'
          ..tmdbMovieId = 1
          ..followed = true
          ..followerCount= 5
          ..overview = 'desc'
          ..jokeCount = 5
          ..firstAirDate = DateTime(2000,5,5)
        );
    Movie fullMovieDetails = Movie((b) => b
      ..id = 1
      ..name = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = true
      ..followerCount= 5
      ..overview = 'desc'
      ..jokeCount = 5
      ..firstAirDate = DateTime(2000,5,5)
      ..tmdbDetails.id = 1
      ..tmdbDetails.name = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.firstAirDate = DateTime(2000,10,10)
      ..tmdbDetails.lastAirDate = DateTime(2000,10,10)
      ..tmdbDetails.numberOfSeasons = 5
      ..tmdbDetails.voteAverage = 8.9
      );

    when(movieService.getMovie(movieToGet))
        .thenAnswer((_) async => fullMovieDetails);

    MovieDetailsBloc movieDetialsBloc =
        MovieDetailsBloc(movieService: movieService, viewedMovie: movieToGet);
    expect(movieDetialsBloc.loadState, emitsInOrder([loading, loaded]));
    expect(
        movieDetialsBloc.movie, emitsInOrder([movieToGet, fullMovieDetails]));
  });

  test('Dont load movie if it is complete', () async {
    MovieService movieService = MockMovieService();

    Movie movieToGet = Movie((b) => b
      ..id = 1
      ..name = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = true
      ..followerCount= 5
      ..overview = 'desc'
      ..jokeCount = 5
      ..firstAirDate = DateTime(2000,5,5)
      ..tmdbDetails.id = 1
      ..tmdbDetails.name = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.firstAirDate = DateTime(2000,10,10)
      ..tmdbDetails.lastAirDate = DateTime(2000,10,10)
      ..tmdbDetails.numberOfSeasons = 5
      ..tmdbDetails.numberOfSeasons = 5
      ..tmdbDetails.voteAverage = 8.9
      );

    when(movieService.getMovie(movieToGet)).thenAnswer((_) async => movieToGet);

    MovieDetailsBloc movieDetialsBloc =
        MovieDetailsBloc(movieService: movieService, viewedMovie: movieToGet);
    expect(movieDetialsBloc.loadState, emits(loaded));
    expect(movieDetialsBloc.movie, emits(movieToGet));

    verifyNever(movieService.getMovie(movieToGet));
  });

}
