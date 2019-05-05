import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tv_series_jokes/models/list_response.dart';
import 'package:tv_series_jokes/models/movie/tmdb_movie.dart';

import '../serializers.dart';

part 'tmdb_movie_list_response.g.dart'; 


abstract class TmdbMovieListResponse  implements Built<TmdbMovieListResponse, TmdbMovieListResponseBuilder>, ListResponse<TmdbMovie> {
  /// Example of how to make a built_value type serializable.
  ///
  /// Declare a static final [Serializer] field called `serializer`.
  /// The built_value code generator will provide the implementation. You need
  /// to do this for every type you want to serialize.
  static Serializer<TmdbMovieListResponse> get serializer => _$tmdbMovieListResponseSerializer;

  @BuiltValueField(wireName: 'total_pages')
  int get totalPages;
  @nullable
  int get perPage;
  @BuiltValueField(wireName: 'page')
  int get currentPage;
  @nullable
  int get nextPage;
  @nullable
  int get previousPage;
  BuiltList<TmdbMovie> get results;

  factory TmdbMovieListResponse([updates(TmdbMovieListResponseBuilder b)]) = _$TmdbMovieListResponse;
  TmdbMovieListResponse._();


   factory TmdbMovieListResponse.fromJson(Map<String, dynamic> json){

    TmdbMovieListResponse movieListResponse = standardSerializers.deserializeWith(TmdbMovieListResponse.serializer, json);
    return movieListResponse;
  }

}