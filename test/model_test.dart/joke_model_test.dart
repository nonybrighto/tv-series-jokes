import 'dart:convert';

import 'package:tv_series_jokes/models/joke.dart';
import 'package:test/test.dart';

main() {

  test('Convert json to joke object', () {

   
   String jokeJson = '''{
            "likeCount": 0,
            "id": 1,
            "content": "3 Lorem ipsum is a joke about the joke of all craps and i dont know Lorem ipsum is a joke about the joke of all craps and i dont know Lorem ipsum is a joke about the joke of all craps and i dont know 2",
            "dateAdded": "2019-04-05 17:00:57",
            "commentCount": 0,
            "liked": false,
            "favorited": false,
            "owner": {
                "photoUrl": "https://lh3.googleusercontent.com/-7pX2KjlP-14/AAAAAAAAAAI/AAAAAAAAABQ/oylyelUx3Nw/s96-c/photo.jpg",
                "id": 1,
                "username": "nony",
                "jokeCount": 55,
                "following": true,
                "followed": true,
                "followerCount":10,
                "followingCount":20
            },
            "movie": {
                "description": "the movie description",
                "tmdbMovieId": 1,
                "id": 1,
                "jokeCount": 2,
                "name": "movie name",
                "followed": false,
                 "followerCount": 0,
                "firstAirDate": "2003-09-21T00:00:00.000Z"
            }
        }''';

Joke convertedJoke =Joke.fromJson(json.decode(jokeJson));
    expect(convertedJoke.id, 1);
  });
}
