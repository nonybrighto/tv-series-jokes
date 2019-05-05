import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:tv_series_jokes/models/comment.dart';
import 'package:tv_series_jokes/models/comment_list_response.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/joke_list_response.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/models/movie/movie_list_response.dart';
import 'package:tv_series_jokes/models/movie/tmdb_movie_cast.dart';
import 'package:tv_series_jokes/models/movie/tmdb_movie.dart';
import 'package:tv_series_jokes/models/movie/tmdb_movie_credit.dart';
import 'package:tv_series_jokes/models/movie/tmdb_movie_genre.dart';
import 'package:tv_series_jokes/models/movie/tmdb_movie_list_response.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/models/user_list_response.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Movie,
  Joke,
  User,
  Comment,
  MovieListResponse,
  JokeListResponse,
  UserListResponse,
  CommentListResponse,
  TmdbMovieListResponse,
  TmdbMovie,
  TmdbMovieCredit,
  TmdbMovieCast,
  TmdbMovieGenre,
])

final Serializers serializers = _$serializers;
final Serializers standardSerializers = (serializers.toBuilder()..addPlugin(new StandardJsonPlugin())..add(Iso8601DateTimeSerializer())).build();