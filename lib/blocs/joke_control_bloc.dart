import 'dart:async';
import 'dart:ui' as ui;

import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:tv_series_jokes/utils/joke_save_util.dart';
import 'package:tv_series_jokes/utils/joke_share_util.dart';

class JokeControlBloc extends BlocBase {
  Joke jokeControlled;
  JokeListBloc jokeListBloc;
  JokeService jokeService;

  final _toggleJokeLikeController = StreamController<Null>();
  final _toggleJokeFavoriteController = StreamController<Null>();
  final _shareJokeController = StreamController<Null>();
  final _deleteJokeController = StreamController<Map<String, dynamic>>();

  void Function() get toggleJokeLike =>
      () => _toggleJokeLikeController.sink.add(null);
  void Function() get toggleJokeFavorite =>
      () => _toggleJokeFavoriteController.sink.add(null);
  final _jokeSaveLoadStateController = StreamController<LoadState>();
  final _jokeShareLoadStateController = StreamController<LoadState>();

  final _saveTextJokeController = StreamController<Map<String, dynamic>>();
  final _saveImageJokeController = StreamController<Map<String, dynamic>>();

  void Function(ui.Image, Function(String)) get saveTextJoke =>
      (jokeImage, saveCallback) => _saveTextJokeController.sink
          .add({'jokeImage': jokeImage, 'saveCallback': saveCallback});

  void Function(Function(String)) get saveImageJoke => (saveCallback) =>
      _saveImageJokeController.sink.add({'saveCallback': saveCallback});

  void Function(Function(String)) get deleteJoke => (deleteCallback) => _deleteJokeController.sink.add({'deleteCallback': deleteCallback});

  void Function() get shareJoke =>() => _shareJokeController.sink.add(null);

  //stream
  Stream<LoadState> get jokeSaveLoadState => _jokeSaveLoadStateController.stream;
  Stream<LoadState> get jokeShareLoadState => _jokeShareLoadStateController.stream;

  JokeControlBloc({this.jokeControlled, this.jokeListBloc, this.jokeService}) {
    _toggleJokeLikeController.stream.listen(_handleToggleJokeLike);
    _toggleJokeFavoriteController.stream.listen(_handleToggleJokeFavorite);
    _saveTextJokeController.stream.listen(_handleSaveTextJoke);
    _saveImageJokeController.stream.listen(_handleSaveImageJoke);
    _shareJokeController.stream.listen(_handleShareJoke);
    _deleteJokeController.stream.listen(_handleDeleteJoke);
  }

  _handleDeleteJoke(Map<String, dynamic> details) async{

        Function(String) deleteCallback = details['deleteCallback']; 

        try{
            await jokeService.deleteJoke(joke: jokeControlled);
            jokeListBloc.deleteItem(jokeControlled);
            deleteCallback('Joke has been deleted!');
        }catch(error){
            deleteCallback('Error: Failed to delete joke!!!');
        }
    
  }

  _handleShareJoke(_){
        _jokeShareLoadStateController.sink.add(Loading());
        JokeShareUtil jokeShareUtil = JokeShareUtil();
        if(jokeControlled.hasImage()){
          jokeShareUtil.shareImageJoke(jokeControlled);
        }else{
          jokeShareUtil.shareTextJoke(jokeControlled);
        }
        _jokeShareLoadStateController.sink.add(Loaded());
  }

  _handleSaveImageJoke(details) async {
    _jokeSaveLoadStateController.sink.add(Loading());

    Function(String) saveCallback = details['saveCallback'];
    try {
      await JokeSaveUtil().saveImage(jokeControlled.imageUrl, jokeControlled.title,
          jokeControlled.getImageExtension());
      saveCallback('Joke has been saved!!');
    } catch (err) {
      saveCallback('Failed to save joke!!');
    }

    _jokeSaveLoadStateController.sink.add(Loaded());
  }

  _handleSaveTextJoke(details) async {
    _jokeSaveLoadStateController.sink.add(Loading());
    ui.Image jokeImage = details['jokeImage'];

    Function(String) saveCallback = details['saveCallback'];
    try {
      await JokeSaveUtil().saveText(jokeImage, jokeControlled.title);
      saveCallback('Joke has been saved!!');
    } catch (err) {
      saveCallback('Failed to save joke!!');
    }

    _jokeSaveLoadStateController.sink.add(Loaded());
  }

  // _handleShareJoke(_){

  //      // JokeShareUtil jokeShareUtil = JokeShareUtil();
  //       if(jokeControlled.hasImage()){
  //        // jokeShareUtil.shareImageJoke(jokeControlled);
  //       }else{
  //        // jokeShareUtil.shareTextJoke(jokeControlled);
  //       }

  // }

  _handleToggleJokeLike(_) async {
    _toggleLike();
    jokeListBloc?.updateItem(jokeControlled);
    jokeListBloc?.changeCurrentJoke(jokeControlled);
    try {
      await jokeService.changeJokeLiking(
          joke: jokeControlled, like: jokeControlled.liked);
    } catch (err) {
      print(err);
      _toggleLike();
      jokeListBloc?.updateItem(jokeControlled);
      jokeListBloc?.changeCurrentJoke(jokeControlled);
    }
  }

  _handleToggleJokeFavorite(_) async {
    _toggleFavorite();
    jokeListBloc?.updateItem(jokeControlled);
    jokeListBloc?.changeCurrentJoke(jokeControlled);
    try {
      await jokeService.changeJokeFavoriting(
          joke: jokeControlled, favorite: jokeControlled.favorited);
    } catch (err) {
      _toggleFavorite();
      jokeListBloc?.updateItem(jokeControlled);
      jokeListBloc?.changeCurrentJoke(jokeControlled);
    }
  }

  _toggleLike() {
    jokeControlled = jokeControlled.rebuild((b) => b
      ..liked = !b.liked
      ..likeCount = (jokeControlled.liked) ? --b.likeCount : ++b.likeCount);
  }

  _toggleFavorite() {
    jokeControlled = jokeControlled.rebuild((b) => b.favorited = !b.favorited);
  }

  @override
  void dispose() {
    print('Joke control disposed for ${jokeControlled.title}');
    _toggleJokeLikeController.close();
    _toggleJokeFavoriteController.close();
    _shareJokeController.close();
    _jokeSaveLoadStateController.close();
    _saveTextJokeController.close();
    _saveImageJokeController.close();
    _jokeShareLoadStateController.close();
    _deleteJokeController.close();
  }
}
