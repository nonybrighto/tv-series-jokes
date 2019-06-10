import 'dart:convert' as json;

import 'package:tv_series_jokes/models/movie/tmdb_movie.dart';
import 'package:test/test.dart';

void main(){

test('can deserialize tmdb movie details', (){

    String tmdbJson = ''' 
        {
    "backdrop_path": "/27cshLy9anL9G0g6tBQjWkPACx5.jpg",
    "created_by": [
        {
            "id": 1218744,
            "credit_id": "5257414b760ee36aaa0a87e5",
            "name": "Lee Aronsohn",
            "gender": 2,
            "profile_path": "/l7g6xI6mIc29XwO0IpMSXBWxhH8.jpg"
        },
        {
            "id": 160172,
            "credit_id": "5257414b760ee36aaa0a87eb",
            "name": "Chuck Lorre",
            "gender": 2,
            "profile_path": "/btpYlMV71sjQXrV142I9kogEINI.jpg"
        }
    ],
    "episode_run_time": [
        30,
        21,
        17
    ],
    "first_air_date": "2003-09-21",
    "genres": [
        {
            "id": 35,
            "name": "Comedy"
        }
    ],
    "homepage": "http://www.cbs.com/shows/two_and_a_half_men/",
    "id": 2691,
    "in_production": false,
    "languages": [
        "en"
    ],
    "last_air_date": "2015-02-19",
    "last_episode_to_air": {
        "air_date": "2015-02-19",
        "episode_number": 16,
        "id": 1041648,
        "name": "Of Course He's Dead (2)",
        "overview": "Charlie Harper is alive. Or is he?",
        "production_code": "",
        "season_number": 12,
        "show_id": 2691,
        "still_path": "/g1M0GQaxP55RGPGZl76XzU1YJqk.jpg",
        "vote_average": 0,
        "vote_count": 0
    },
    "name": "Two and a Half Men",
    "next_episode_to_air": null,
    "networks": [
        {
            "name": "CBS",
            "id": 16,
            "logo_path": "/nm8d7P7MJNiBLdgIzUK0gkuEA4r.png",
            "origin_country": "US"
        }
    ],
    "number_of_episodes": 262,
    "number_of_seasons": 12,
    "origin_country": [
        "US"
    ],
    "original_language": "en",
    "original_name": "Two and a Half Men",
    "overview": "A hedonistic jingle writer's free-wheeling life comes to an abrupt halt when his brother and 10-year-old nephew move into his beach-front house.",
    "popularity": 79.326,
    "poster_path": "/jHshlZO3p1ljAq7xTsOVmXawdTK.jpg",
    "production_companies": [],
    "status": "Ended",
    "type": "Scripted",
    "vote_average": 6.3,
    "vote_count": 668,
    "credits": {
        "cast": [
            {
                "character": "Charlie Harper",
                "credit_id": "5257414a760ee36aaa0a83d1",
                "id": 6952,
                "name": "Charlie Sheen",
                "gender": 2,
                "profile_path": "/g4e1QpcNTpmq2uPr5GDNuMvjRuU.jpg",
                "order": 0
            },
            {
                "character": "Walden Schmidt",
                "credit_id": "5257414a760ee36aaa0a86f1",
                "id": 18976,
                "name": "Ashton Kutcher",
                "gender": 2,
                "profile_path": "/cGEvhWHlJmSrYfkpfCtfZVeRVsP.jpg",
                "order": 7
            }
        ],
        "crew": [
            {
                "credit_id": "56492906c3a36826080093a7",
                "department": "Production",
                "id": 1215345,
                "name": "Jim Patterson",
                "gender": 2,
                "job": "Executive Producer",
                "profile_path": null
            },
            {
                "credit_id": "564925e9c3a3682605008d7f",
                "department": "Production",
                "id": 1536766,
                "name": "Tim Kelleher",
                "gender": 2,
                "job": "Consulting Producer",
                "profile_path": null
            }
        ]
    }
}
    
     ''';

    TmdbMovie movieDetailsFromJson =TmdbMovie.fromJson(json.jsonDecode(tmdbJson));
    expect(movieDetailsFromJson.id, 2691);
    expect(movieDetailsFromJson.credits.cast.first.id, 6952);

  });

  test('can deserialize tmdb movie with empty date string', (){

    String tmdbJson = r''' 
        {
            "original_name": "How I'm Livin'",
            "id": 9616,
            "name": "How I'm Livin'",
            "vote_count": 0,
            "vote_average": 0,
            "poster_path": null,
            "first_air_date": "",
            "popularity": 0.6,
            "genre_ids": [],
            "original_language": "en",
            "backdrop_path": null,
            "overview": "How I'm Livin' is a reality television show on BET. Each week, the show profiled a couple of big names in the entertainment industry and followed them on their activities for a day. They have included those on Steve Harvey, Lisa Raye, Khia, Tweet, Rickey Smiley, A.J. and Free from 106 & Park, and Guy Torry to name a few.\n\nThe show was supposed to be a competitor to MTV's highly rated Cribs.",
            "origin_country": []
        }
    
     ''';

    TmdbMovie movieDetailsFromJson =TmdbMovie.fromJson(json.jsonDecode(tmdbJson));
    expect(movieDetailsFromJson.id, 9616);
  });


 
}