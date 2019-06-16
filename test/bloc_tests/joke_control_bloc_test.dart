import 'package:built_collection/built_collection.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_jokes/blocs/joke_control_bloc.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/joke_list_response.dart';
import 'package:tv_series_jokes/services/joke_service.dart';

import '../general_mocks.dart';


void main(){

  JokeService jokeService;
  Joke joke;

    setUp((){

         jokeService = MockJokeService();
         joke = joke = Joke((b) => b
        ..id = 1
        ..text = 'user Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..createdAt = DateTime(2003)
        ..movie.id = 1
        ..movie.name = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.jokeCount = 5
        ..movie.followerCount = 5
        ..movie.followed = false
        ..movie.firstAirDate = DateTime(2019, 1, 1)
        ..movie.overview = 'description'
         ..owner.update((u) => u
          ..id = 1
          ..username = 'John $num'
          ..profilePhoto = 'the_url'
          ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22));


    });


    test('Execute callback when joke added to favorite and rollback on error', () async{


      bool favorited;
      String gottenMessage;
      JokeListBloc jokeListBloc = JokeListBloc(jokeService: jokeService, fetchType: JokeListFetchType.latestJokes);
      JokeControlBloc jokeControlBloc = JokeControlBloc(jokeService: jokeService, jokeControlled: joke, jokeListBloc: jokeListBloc);

      when(jokeService.fetchLatestJokes(page: anyNamed('page'))).thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 1 ..currentPage = 1 ..nextPage=2 ..perPage=25 ..results = BuiltList<Joke>([joke]).toBuilder()));
      when(jokeService.changeJokeFavoriting(joke: anyNamed('joke'), favorite: anyNamed('favorite'))).thenAnswer((_) async => Future.error(Exception('error')));
      jokeControlBloc.toggleJokeFavorite((favorite, message){
          favorited = favorite;
          gottenMessage = message;

      });
      await Future.delayed(Duration(seconds: 0));
      List<dynamic> jokez = await jokeListBloc.items.first;
      expect(jokez[0], joke); //should rollback to original joke since there was an error
      expect(favorited, false);
      expect(gottenMessage, 'error');
      
    });
    
    test('Execute callback when joke  liked and rollback on error', ()async{

       bool liked;
      String gottenMessage;
      JokeListBloc jokeListBloc = JokeListBloc(jokeService: jokeService, fetchType: JokeListFetchType.latestJokes);
      JokeControlBloc jokeControlBloc = JokeControlBloc(jokeService: jokeService, jokeControlled: joke, jokeListBloc: jokeListBloc);

      when(jokeService.fetchLatestJokes(page: anyNamed('page'))).thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 1 ..currentPage = 1 ..nextPage=2 ..perPage=25 ..results = BuiltList<Joke>([joke]).toBuilder()));
      when(jokeService.changeJokeLiking(joke: anyNamed('joke'), like: anyNamed('like'))).thenAnswer((_) async => Future.error(Exception('error')));
      jokeControlBloc.toggleJokeLike((like, message){
          liked = like;
          gottenMessage = message;

      });
      await Future.delayed(Duration(seconds: 0));
      List<dynamic> jokez = await jokeListBloc.items.first;
      expect(jokez[0], joke); //should rollback to original joke since there was an error
      expect(liked, false);
      expect(gottenMessage, 'error');

    });
    test('favorite State should change on success', ()async{

      JokeListBloc jokeListBloc = JokeListBloc(jokeService: jokeService, fetchType: JokeListFetchType.latestJokes);
      JokeControlBloc jokeControlBloc = JokeControlBloc(jokeService: jokeService, jokeControlled: joke, jokeListBloc: jokeListBloc);

      when(jokeService.fetchLatestJokes(page: anyNamed('page'))).thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 1 ..currentPage = 1 ..nextPage=2 ..perPage=25 ..results = BuiltList<Joke>([joke]).toBuilder()));
      when(jokeService.changeJokeFavoriting(joke: anyNamed('joke'), favorite: anyNamed('favorite'))).thenAnswer((_) async => true);
      jokeControlBloc.toggleJokeFavorite((like, message){});
      await Future.delayed(Duration(seconds: 0));
      List<Joke> jokez = await jokeListBloc.items.first;
      expect(jokez[0].favorited, !joke.favorited); //should rollback to original joke since there was an error

    });
    test('jokeLike State should change on success', ()async{

      JokeListBloc jokeListBloc = JokeListBloc(jokeService: jokeService, fetchType: JokeListFetchType.latestJokes);
      JokeControlBloc jokeControlBloc = JokeControlBloc(jokeService: jokeService, jokeControlled: joke, jokeListBloc: jokeListBloc);

      when(jokeService.fetchLatestJokes(page: anyNamed('page'))).thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 1 ..currentPage = 1 ..nextPage=2 ..perPage=25 ..results = BuiltList<Joke>([joke]).toBuilder()));
      when(jokeService.changeJokeLiking(joke: anyNamed('joke'), like: anyNamed('like'))).thenAnswer((_) async => true);
      jokeControlBloc.toggleJokeLike((like, message){});
      await Future.delayed(Duration(seconds: 0));
      List<Joke> jokez = await jokeListBloc.items.first;
      expect(jokez[0].liked, !joke.liked); //should rollback to original joke since there was an error

    });

    test('sends request to report joke and return a message in callback', ()async{

      String returnedMessage;
      JokeListBloc jokeListBloc = JokeListBloc(jokeService: jokeService);
      JokeControlBloc jokeControlBloc = JokeControlBloc(jokeService: jokeService, jokeControlled: joke, jokeListBloc: jokeListBloc);
      jokeControlBloc.reportJoke((message){
            returnedMessage = message;
      });
      await Future.delayed(Duration(seconds: 0));
      verify(jokeService.reportJoke(joke: anyNamed('joke')));
      expect(returnedMessage.length > 0, true);


    });



}