import 'dart:convert';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:test/test.dart';

 void main() {

    test('Convert json to movie object', () {
    
        String movieJsonString = """ {
                "description": "the movie description",
                "tmdbMovieId": 1,
                "id": 1,
                "jokeCount": 2,
                "name": "movie name",
                "followed": false,
                 "followerCount": 0,
                "firstAirDate": "2003-09-21T00:00:00.000Z"
            } """;

        Map<String, dynamic> jsonMap =  json.decode(movieJsonString);
        
        expect(Movie.fromJson(jsonMap).name, 'movie name');
  }); 
}
