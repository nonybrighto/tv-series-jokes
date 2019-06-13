import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/blocs/list_bloc.dart';
import 'package:tv_series_jokes/models/comment.dart';
import 'package:tv_series_jokes/models/comment_list_response.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/services/joke_service.dart';


class JokeCommentListBloc extends ListBloc<Comment>{
 
 final Joke commentJoke;
 final JokeService jokeService;
 final JokeListBloc jokeListBloc;

  final _jokeController = BehaviorSubject<Joke>();


  //stream
  Stream<Joke> get joke => _jokeController.stream;
 
 JokeCommentListBloc(this.commentJoke, {this.jokeService, this.jokeListBloc}){
    _jokeController.sink.add(commentJoke);
      super.getItems();
 }


 incrementJokeCommentsCount(){
    final incrementedJoke = commentJoke.rebuild((b) => b ..commentCount = b.commentCount + 1);
    jokeListBloc.updateItem(incrementedJoke);
    jokeListBloc.changeCurrentJoke(incrementedJoke);
 }

 appendComment(Comment comment)async{

    LoadState loadState = await this.loadState.first;
    appendItem(comment);
    if(loadState is LoadError || loadState is LoadEmpty){
      changeLoadState(LoadEnd());
    }
 }
 
  @override
  void dispose() {
        super.dispose();
      _jokeController.close();
  }

  @override
  Future<CommentListResponse> fetchFromServer() async{
    return  await jokeService.getComments(joke:commentJoke, page: super.currentPage);
  }

  @override
  bool itemIdentificationCondition(Comment currentComment , Comment updatedComment) {
    return currentComment.id ==updatedComment.id;
  }

  @override
  String getEmptyResultMessage() {
    
    return 'No Comments to display';
  }
}
