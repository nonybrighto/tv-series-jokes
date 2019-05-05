import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:tv_series_jokes/models/movie/tmdb_movie_cast.dart';

part 'tmdb_movie_credit.g.dart';


abstract class TmdbMovieCredit implements Built<TmdbMovieCredit, TmdbMovieCreditBuilder> {


  static Serializer<TmdbMovieCredit> get serializer => _$tmdbMovieCreditSerializer;


  BuiltList<TmdbMovieCast> get cast;


  factory TmdbMovieCredit([updates(TmdbMovieCreditBuilder b)]) = _$TmdbMovieCredit;

  TmdbMovieCredit._();

}