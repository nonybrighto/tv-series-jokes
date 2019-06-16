import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/models/user.dart';

import 'serializers.dart';

part 'joke.g.dart'; 


abstract class Joke implements Built<Joke, JokeBuilder> {
  /// Example of how to make a built_value type serializable.
  ///
  /// Declare a static final [Serializer] field called `serializer`.
  /// The built_value code generator will provide the implementation. You need
  /// to do this for every type you want to serialize.
  static Serializer<Joke> get serializer => _$jokeSerializer;

  int get id;
  @nullable
  String get text;
  int get commentCount;
  //@BuiltValueField(wireName: 'joke_type')
  @nullable
  DateTime get createdAt;
  @nullable
  int get likeCount;
  bool get liked;
  bool get favorited;
  @nullable
  Movie get movie;
  @nullable 
  User get owner;
  @nullable
  String get imageUrl;

  factory Joke([updates(JokeBuilder b)]) = _$Joke;
  Joke._();


  bool hasImage(){
    return imageUrl != null;
  }

  String getImageExtension(){
    return imageUrl.substring(imageUrl.lastIndexOf('.'));
  }

  factory Joke.fromJson(Map<String, dynamic> json){

    Joke joke = standardSerializers.deserializeWith(Joke.serializer, json);
    return joke;
  }

}

abstract class JokeBuilder
    implements Builder<Joke, JokeBuilder> {

  int id;
  String title;
  @nullable
  String text;
  int commentCount;
  @nullable
  DateTime createdAt;
  @nullable
  int likeCount;
  bool liked = false;
  bool favorited = false;
  @nullable 
  String imageUrl;
  @nullable
  MovieBuilder movie;
  UserBuilder owner;

  factory JokeBuilder() = _$JokeBuilder;
  JokeBuilder._();
}