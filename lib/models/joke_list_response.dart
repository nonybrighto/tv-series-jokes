import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/list_response.dart';

import 'serializers.dart';

part 'joke_list_response.g.dart'; 


abstract class JokeListResponse  implements Built<JokeListResponse, JokeListResponseBuilder>, ListResponse<Joke> {
  /// Example of how to make a built_value type serializable.
  ///
  /// Declare a static final [Serializer] field called `serializer`.
  /// The built_value code generator will provide the implementation. You need
  /// to do this for every type you want to serialize.
  static Serializer<JokeListResponse> get serializer => _$jokeListResponseSerializer;

  int get totalPages;
  int get perPage;
  int get currentPage;
  @nullable
  int get nextPage;
  @nullable
  int get previousPage;
  BuiltList<Joke> get results;

  factory JokeListResponse([updates(JokeListResponseBuilder b)]) = _$JokeListResponse;
  JokeListResponse._();

  factory JokeListResponse.fromJson(Map<String, dynamic> json){

    JokeListResponse jokeListResponse = standardSerializers.deserializeWith(JokeListResponse.serializer, json);
    return jokeListResponse;
  }

}