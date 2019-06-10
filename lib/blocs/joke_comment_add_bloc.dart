import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_comment_list_bloc.dart';
import 'package:tv_series_jokes/models/comment.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/services/joke_service.dart';

class JokeCommentAddBloc extends BlocBase{
  
  JokeCommentListBloc jokeCommentListBloc;
  JokeService  jokeService;
  final _addCommentController = StreamController<Map<String, dynamic>>();
  final _loadStateContoller = BehaviorSubject<LoadState>();

  //sinks
  void Function(String, String, Function(bool, String)) get addComment => (content, anonymousName, commentAddCallback) => _addCommentController.sink.add({'content':content, 'anonymousName': anonymousName, 'commentAddCallback': commentAddCallback});

  //streams
  Stream get loadState => _loadStateContoller.stream;

  JokeCommentAddBloc({this.jokeCommentListBloc, this.jokeService}){

      _loadStateContoller.sink.add(Loaded());
      _addCommentController.stream.listen((details) async{

                Function(bool, String) commentAddCallback = details['commentAddCallback'];
           try{
                _loadStateContoller.sink.add(Loading());
                Comment addedComment = await jokeService.addComment(joke: jokeCommentListBloc.commentJoke, content: details['content'], anonymousName: details['anonymousName'] );
                jokeCommentListBloc.appendComment(addedComment);
                jokeCommentListBloc.incrementJokeCommentsCount();
                _loadStateContoller.sink.add(Loaded());
                commentAddCallback(true, 'Comment Added'); 
           }catch(error){
                commentAddCallback(false, 'Failed to add Comment');
                _loadStateContoller.sink.add(LoadError('Failed to add Comment'));
           }
      });

  }
  
  @override
  void dispose() {
      _addCommentController.close();
      _loadStateContoller.close();
  }



}