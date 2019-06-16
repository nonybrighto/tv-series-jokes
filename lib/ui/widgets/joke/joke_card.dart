import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/auth_bloc.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_control_bloc.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/navigation/router.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:tv_series_jokes/ui/widgets/joke/controls/joke_favorite_action_button.dart';
import 'package:tv_series_jokes/ui/widgets/joke/controls/joke_like_action_button.dart';
import 'package:tv_series_jokes/ui/widgets/joke/controls/joke_save_action_buttons.dart';
import 'package:tv_series_jokes/ui/widgets/joke/controls/joke_share_action_button.dart';
import 'package:tv_series_jokes/ui/widgets/user/user_profile_icon.dart';
import 'package:tv_series_jokes/ui/widgets/user/username_text.dart';
import 'package:tv_series_jokes/utils/date_formater.dart';
import 'package:cached_network_image/cached_network_image.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;
  final int index;
  final textJokeBoundaryKey = GlobalKey();
  JokeCard(this.index, {this.joke});
  @override
  Widget build(BuildContext context) {
    JokeListBloc jokeListBloc = BlocProvider.of<JokeListBloc>(context);
    JokeControlBloc jokeControlBloc = JokeControlBloc(
        jokeControlled: joke,
        jokeListBloc: jokeListBloc,
        jokeService: JokeService());
    return RepaintBoundary(
          key: textJokeBoundaryKey,
          child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildJokeHeader(context, jokeControlBloc, jokeListBloc),
            _buildJokeContent(
                context: context, joke: joke, jokeListBloc: jokeListBloc),
            _buildJokeFooter(context, jokeControlBloc, joke)
          ],
        ),
      ),
    );
  }

  _buildJokeHeader(context, JokeControlBloc jokeControlBloc, JokeListBloc jokeListBloc) {
    return ListTile(
      leading: UserProfileIcon(
        user: joke.owner,
      ),
      title: Wrap(
        children: <Widget>[
          UsernameText(user: joke.owner, style: TextStyle(fontWeight: FontWeight.bold),),
          (joke.title != null)
              ? Wrap(
                  children: <Widget>[
                    Icon(
                      Icons.play_arrow,
                      size: 20,
                    ),
                    Text(
                      joke.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : Container(),
        ],
      ),
      subtitle: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text(DateFormatter.dateToString(
            joke.createdAt, DateFormatPattern.timeAgo)),
            SizedBox(
      width: 5,
            ),
            ActionChip(label: Text(joke.movie.name, style: TextStyle(fontSize: 10),), padding:  EdgeInsets.all(0), onPressed: (){
          gotoJokeListPage(context, pageTitle: joke.movie.name, fetchType: JokeListFetchType.movieJokes, movie: joke.movie);
            },),
        ],),
      trailing: _buildJokeMenuButton(context, jokeControlBloc, jokeListBloc),
    );
  }

  _buildJokeMenuButton(BuildContext context, JokeControlBloc jokeControlBloc, JokeListBloc jokeListBloc) {

    
    return StreamBuilder<User>(
      stream: BlocProvider.of<AuthBloc>(context).currentUser,
      builder: (context, currentUserSnapshot) {
        User currentUser = currentUserSnapshot.data;
        List<String> menuChoices = ['View Likes', 'View Comments','Delete', 'Report Content'];
        if(currentUser!=null && currentUser.id != joke.owner.id){
              menuChoices.where((choice) => choice == 'Delete');
        }
        return PopupMenuButton<String>(
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => menuChoices.map((choice) => PopupMenuItem(
                  child: Text(choice),
                  value: choice,
                )).toList(),
          onSelected: (value) {
            switch (value) {
              case 'View Likes':
                gotoJokeLikersPage(context, joke: joke);
                break;
              case 'View Comments':
                gotoJokeCommentsPage(context, joke: joke, jokeListBloc: jokeListBloc);
                break;
              case 'Delete':
               _showDeleteDialog(context, jokeControlBloc);
                break;
              case 'Report Content':
                  jokeControlBloc.reportJoke((message){
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message),));
                  });
                break;
            }
          },
        );
      }
    );
  }

  _showDeleteDialog(BuildContext context, JokeControlBloc jokeControlBloc){

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete Joke'),
              content: Text('Are you sure you want to delete the joke (${joke.title})'), // get from server
              actions: <Widget>[
                FlatButton(
                  child: Text('DELETE'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    jokeControlBloc.deleteJoke((message){
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(message),));
                  });
                  },
                ),
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () async {
                    
                  },
                ),
              ],
            ),
      );
  }

  _buildJokeContent(
      {BuildContext context, Joke joke, JokeListBloc jokeListBloc}) {
    return GestureDetector(
      onTap: () {
        jokeListBloc.changeCurrentJoke(joke);
        gotoJokeDisplayPage(context,
            initialPage: index, jokeListBloc: jokeListBloc, joke: joke);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (joke.text != null) ? _buildTextDisplay(joke.text) : Container(),
          (joke.hasImage()) ? _buildImageDisplay(joke.imageUrl) : Container(),
        ],
      ),
    );
  }

  _buildJokeFooter(
      BuildContext context, JokeControlBloc jokeControlBloc, Joke joke) {
    return Container(
        child: BlocProvider<JokeControlBloc>(
            bloc: jokeControlBloc,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                JokeLikeActionButton(joke: joke,size: 12, showLikeCount: true,),
                JokeSaveActionButton(joke: joke, textJokeBoundaryKey: textJokeBoundaryKey, size: 12,),
                JokeFavoriteActionButton(joke: joke,size: 12,),
                JokeShareActionButton(joke: joke,size: 12,),
              ],
            )));
  }

  // _buildImageDisplay(String imageUrl) {
  //   return SizedBox(
  //       width: double.infinity,
  //       child: FadeInImage.assetNetwork(
  //         fit: BoxFit.fill,
  //         placeholder: 'assets/images/pl.png',
  //         image: imageUrl,
  //       ));
  // }
  _buildImageDisplay(String imageUrl) {
    return SizedBox(
        width: double.infinity,
        child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: imageUrl,
        placeholder: (context, url) => Image.asset('assets/images/pl.png'),
        errorWidget: (context, url, error) => Image.asset('assets/images/pl.png'),
     ));
  }

  _buildTextDisplay(String jokeContent) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Text(jokeContent),
    );
  }
}
