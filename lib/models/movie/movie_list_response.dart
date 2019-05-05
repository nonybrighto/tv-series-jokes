import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tv_series_jokes/models/list_response.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';

import '../serializers.dart';

part 'movie_list_response.g.dart'; 


abstract class MovieListResponse  implements Built<MovieListResponse, MovieListResponseBuilder>, ListResponse<Movie> {
  /// Example of how to make a built_value type serializable.
  ///
  /// Declare a static final [Serializer] field called `serializer`.
  /// The built_value code generator will provide the implementation. You need
  /// to do this for every type you want to serialize.
  static Serializer<MovieListResponse> get serializer => _$movieListResponseSerializer;

  int get totalPages;
  int get perPage;
  int get currentPage;
  @nullable
  int get nextPage;
  @nullable
  int get previousPage;
  BuiltList<Movie> get results;

  factory MovieListResponse([updates(MovieListResponseBuilder b)]) = _$MovieListResponse;
  MovieListResponse._();


   factory MovieListResponse.fromJson(Map<String, dynamic> json){

    MovieListResponse movieListResponse = standardSerializers.deserializeWith(MovieListResponse.serializer, json);
    return movieListResponse;
  }

}