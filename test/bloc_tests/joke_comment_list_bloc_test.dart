import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:tv_series_jokes/blocs/joke_comment_list_bloc.dart';
import 'package:tv_series_jokes/models/comment_list_response.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:test/test.dart';
import 'package:tv_series_jokes/models/comment.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:mockito/mockito.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';


void main() {
  JokeService jokeService;
  Joke joke;
  BuiltList<Comment> sampleComments;
  setUp(() {

    jokeService = MockJokeService();

    joke = Joke((b) => b
        ..id = 1
        ..title = 'user joke $num'
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

    sampleComments = BuiltList([
      
      Comment((u) => u
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
      )

    ]);
    when(jokeService.getComments(joke: anyNamed('joke'), page: anyNamed('page')))
        .thenAnswer((_) async => CommentListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleComments.toBuilder()));
  });

  
  test('Expect joke  to be present in joke stream', () {
  
    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);

    expect(commentListBloc.joke, emits(joke));
  });

  test('Expect comments to be gotten once started', () {
  
    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);

    expect(commentListBloc.loadState, emitsAnyOf([loading, loadingMore]));
  });

  test('Expected order when joke loading joke for first time', () {
     JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);
    expect(commentListBloc.loadState, emitsInOrder([loading, loaded]));
    expect(commentListBloc.items, emits(BuiltList<Comment>([sampleComments[0]])));
  });

  test('when loading the second time, expect state to be loading more and list should contain two items',() async{

    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);

    commentListBloc.getItems();

    expect(commentListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loaded]));
    expect(commentListBloc.items, emits(BuiltList<Comment>([sampleComments[0], sampleComments[0] ])));
  });

  test('When no item to load and first trial, send load empty', (){
    JokeService jokeService = MockJokeService();
    when(jokeService.getComments(joke: anyNamed('joke'), page: anyNamed('page')))
        .thenAnswer((_) async =>  CommentListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results = BuiltList<Comment>([]).toBuilder()));

   JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);

    expect(commentListBloc.loadState, emitsInOrder([loading, loadEmpty]));

  });

  test('Expect to load error when issue from server', (){


     JokeService jokeService = MockJokeService();
    when(jokeService.getComments(joke: anyNamed('joke'), page: anyNamed('page')))
        .thenAnswer((_) async => Future.error(Error()));

    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);
    expect(commentListBloc.loadState, emitsInOrder([loading, loadError]));
  });

  test('when current page gets to total pages, emit loadend', (){

    JokeService jokeService = MockJokeService();

         when(jokeService.getComments(joke: anyNamed('joke'), page: 1))
        .thenAnswer((_) async =>  CommentListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleComments.toBuilder()));
         when(jokeService.getComments(joke: anyNamed('joke'), page: 2))
        .thenAnswer((_) async =>  CommentListResponse((b) => b..totalPages = 2..currentPage = 2 ..perPage = 10 ..results =  BuiltList<Comment>([]).toBuilder()));

    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);
    commentListBloc.getItems();

    expect(commentListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loadEnd]));
    expect(commentListBloc.items, emits([sampleComments[0]]));
  });
}
