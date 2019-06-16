import 'package:built_collection/built_collection.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_jokes/blocs/joke_comment_add_bloc.dart';
import 'package:tv_series_jokes/blocs/joke_comment_list_bloc.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/models/bloc_delegate.dart';
import 'package:tv_series_jokes/models/comment.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/joke_list_response.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';


String errorMessage;
class DelegateMock extends BlocDelegate<Joke>{
  @override
  error(String message) {
    errorMessage = message;
  }

  @override
  success(Joke joke) {
    //successUser = user;
  }
 

}

void main(){

   JokeService jokeService;
  setUp(() {
    jokeService = MockJokeService();
  });



  test('expect comment to be added to comment list', ()async{

    Joke joke =  Joke((b) => b
        ..id = 1
        ..text = 'user Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..createdAt = DateTime(2003)
        ..movie.update((b) => b
      ..id = 1
      ..name = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = true
      ..overview = 'desc'
      ..jokeCount = 10
      ..firstAirDate = DateTime(2000,10,10)
      ..followerCount = 10
      )
         ..owner.update((u) => u
          ..id = 1
          ..username = 'John $num'
          ..profilePhoto = 'the_url'
          ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22));


           when(jokeService.fetchLatestJokes(page: anyNamed('page'))).thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results = BuiltList<Joke>([joke]).toBuilder()));

            when(jokeService.getComments(joke: anyNamed('joke'), page: anyNamed('page')))
          .thenAnswer((_) async => Future.error(Exception('error'))); //dont add any content by default

    when(jokeService.addComment(joke: anyNamed('joke'), content: anyNamed('content'), anonymousName: anyNamed('anonymousName'))).thenAnswer((_) async => Comment((b) => 
                                    b..id = 1
                                    ..content = 'content'
                                    ..anonymousName = null
                                    ..owner = null
                                    ..createdAt = DateTime(2019)
                                  ));
    JokeListBloc jokeListBloc = JokeListBloc(jokeService: jokeService, fetchType: JokeListFetchType.latestJokes);
    JokeCommentListBloc jokeCommentListBloc = JokeCommentListBloc(joke, jokeService: jokeService, jokeListBloc: jokeListBloc);
    JokeCommentAddBloc jokeCommentAddBloc = JokeCommentAddBloc(jokeCommentListBloc: jokeCommentListBloc, jokeService: jokeService);

    jokeCommentAddBloc.addComment('hello', null, (added, message){

        print(added);
    });
    await Future.delayed(Duration(seconds: 2));
    print(jokeCommentListBloc.itemsCache.length);
    expect(jokeCommentListBloc.itemsCache.length, 1);

  });

  test('expect list loadstate to not be error or empty after adding comment', ()async{
          
          Joke joke =  Joke((b) => b
        ..id = 1
        ..text = 'user Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..createdAt = DateTime(2003)
        ..movie.update((b) => b
      ..id = 1
      ..name = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = true
      ..overview = 'desc'
      ..jokeCount = 10
      ..firstAirDate = DateTime(2000,10,10)
      ..followerCount = 10
      )
         ..owner.update((u) => u
          ..id = 1
          ..username = 'John $num'
          ..profilePhoto = 'the_url'
          ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22));

          
          when(jokeService.getComments(joke: anyNamed('joke'), page: anyNamed('page')))
          .thenAnswer((_) async => Future.error(Exception('error')));
          when(jokeService.addComment(joke: anyNamed('joke'), content: anyNamed('content'), anonymousName: anyNamed('anonymousName'))).thenAnswer((_) async => Comment((b) => 
                                    b..id = 1
                                    ..content = 'content'
                                    ..anonymousName = null
                                    ..owner = null
                                    ..createdAt = DateTime(2019)
                                  ));



      when(jokeService.fetchLatestJokes(page: anyNamed('page'))).thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results = BuiltList<Joke>([joke]).toBuilder()));
    JokeListBloc jokeListBloc = JokeListBloc(jokeService: jokeService, fetchType: JokeListFetchType.latestJokes);
    
    JokeCommentListBloc jokeCommentListBloc = JokeCommentListBloc(joke, jokeService: jokeService, jokeListBloc: jokeListBloc);
    JokeCommentAddBloc jokeCommentAddBloc = JokeCommentAddBloc(jokeCommentListBloc: jokeCommentListBloc, jokeService: jokeService);
    jokeCommentAddBloc.addComment('hello', null, (added, message){
        print(added);
    });
    expect(jokeCommentListBloc.loadState, emitsInOrder([loading, loadError,loadEnd]));
    await Future.delayed(Duration(seconds: 2));
    print(jokeCommentListBloc.itemsCache.length);
    expect(jokeCommentListBloc.itemsCache.length, 1);
    
    
  });
}