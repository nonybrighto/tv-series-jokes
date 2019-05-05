import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tmdb_movie_genre.g.dart';


abstract class TmdbMovieGenre implements Built<TmdbMovieGenre, TmdbMovieGenreBuilder> {


  static Serializer<TmdbMovieGenre> get serializer => _$tmdbMovieGenreSerializer;


  int get id;
  String get name;


  factory TmdbMovieGenre([updates(TmdbMovieGenreBuilder b)]) = _$TmdbMovieGenre;

  TmdbMovieGenre._();

}