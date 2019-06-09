import 'dart:convert';
import 'package:test/test.dart';
import 'package:tv_series_jokes/models/comment.dart';

void main() {
  test('Check if two comments are equal', () {
    Comment comment1 = Comment((u) => u
      ..id = 1
      ..content='content'
      ..createdAt =DateTime(2000, 11, 22)
      ..owner.update((u) => u
          ..id = 1
          ..username = 'John'
          ..profilePhoto = 'the_url'
          ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22)
      );
    
    Comment comment2 = Comment((u) => u
      ..id = 1
      ..content='content'
      ..createdAt =DateTime(2000, 11, 22)
      ..owner.update((u) => u
          ..id = 1
          ..username = 'John'
          ..profilePhoto = 'the_url'
          ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22)
      );
    

    expect(comment1, comment2);
  });

  test('Convert json to Comment object', () {
    
        String commentJsonString = """ {
          "id": 1, "content":"Content", "createdAt":"2000-11-22", "owner":{"id":1, "username":"John","profilePhoto":"the_url"}
        } """;

        Map<String, dynamic> jsonMap =  json.decode(commentJsonString);
        expect(Comment.fromJson(jsonMap).content, 'Content');
  }); 
}
