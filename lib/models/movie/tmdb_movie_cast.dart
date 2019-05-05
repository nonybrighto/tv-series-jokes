import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tv_series_jokes/constants/constants.dart';


part 'tmdb_movie_cast.g.dart';


abstract class TmdbMovieCast implements Built<TmdbMovieCast, TmdbMovieCastBuilder> {


  static Serializer<TmdbMovieCast> get serializer => _$tmdbMovieCastSerializer;


  int get id;
  @nullable
  String get character;
  String get name;
  @nullable
  @BuiltValueField(wireName: 'profile_path')
  String get profilePath;


  factory TmdbMovieCast([updates(TmdbMovieCastBuilder b)]) = _$TmdbMovieCast;

  TmdbMovieCast._();


  getProfileUrl(){
    return (profilePath != null)?kTmdbImageUrl+'w780'+profilePath: null;
  }

}