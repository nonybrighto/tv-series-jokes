import 'dart:convert';

import 'package:test/test.dart';
import 'package:tv_series_jokes/models/user.dart';

void main() {
  test('Check if two users are equal', () {
    User user1 = User((u) => u
      ..id = 1
      ..username = 'John'
      ..profilePhoto = 'the_url'
      ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22);
    User user2 = User((u) => u
      ..id = 1
      ..username = 'John'
      ..profilePhoto = 'the_url'
      ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22);

    expect(user1, user2);
  });

  test('Convert json to user object', () {
    
        String userJsonString = """ {
          "id": 1, "username":"John", "profilePhoto":"the_url"
        } """;

        Map<String, dynamic> jsonMap =  json.decode(userJsonString);
        
        expect(User.fromJson(jsonMap).username, 'John');
  }); 
}
