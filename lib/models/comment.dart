import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tv_series_jokes/models/user.dart';

import 'serializers.dart';

part 'comment.g.dart';

abstract class Comment implements Built<Comment, CommentBuilder> {
 
 
  static Serializer<Comment> get serializer => _$commentSerializer;

  String get id;
  String get content;
  @nullable 
  String get anonymousName;
  @nullable
  User get owner;
  DateTime get dateAdded;

  factory Comment([updates(CommentBuilder b)]) = _$Comment;
  Comment._();


  factory Comment.fromJson(Map<String, dynamic> json){

    Comment comment = standardSerializers.deserializeWith(Comment.serializer, json);
    return comment;
  }

}
