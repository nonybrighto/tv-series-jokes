import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_control_bloc.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/navigation/router.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:tv_series_jokes/ui/widgets/joke/controls/joke_favorite_action_button.dart';
import 'package:tv_series_jokes/ui/widgets/joke/controls/joke_like_action_button.dart';
import 'package:tv_series_jokes/ui/widgets/joke/controls/joke_save_action_buttons.dart';
import 'package:tv_series_jokes/ui/widgets/joke/controls/joke_share_action_button.dart';
import 'package:zoomable_image/zoomable_image.dart';

class JokeDisplayPage extends StatefulWidget {
  final int initialPage;
  final Joke currentJoke;
  JokeDisplayPage({Key key, this.initialPage, this.currentJoke})
      : super(key: key);

  @override
  _JokeDisplayPageState createState() => new _JokeDisplayPageState();
}

class _JokeDisplayPageState extends State<JokeDisplayPage> {
  JokeListBloc jokeListBloc;
  JokeControlBloc jokeControlBloc;
  PageController _pageController;

  bool canLoadMore = true;
  final textJokeBoundaryKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
    _pageController.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    jokeListBloc = BlocProvider.of<JokeListBloc>(context);
    jokeControlBloc = JokeControlBloc(
        jokeControlled: widget.currentJoke,
        jokeListBloc: jokeListBloc,
        jokeService: JokeService());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Joke>(
      stream: jokeListBloc.currentJoke,
      builder: (context, currentJokeSnapshot) {
        Joke currentJoke = currentJokeSnapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text('Joke'),
          ),
          backgroundColor: (currentJoke != null && currentJoke.hasImage())?Colors.black: Theme.of(context).scaffoldBackgroundColor,
          body: StreamBuilder<LoadState>(
              initialData: Loading(),
              stream: jokeListBloc.loadState,
              builder: (BuildContext context, AsyncSnapshot<LoadState> snapshot) {
                LoadState loadState = snapshot.data;
                if (loadState is LoadComplete && !(loadState is ErrorLoad)) {
                  canLoadMore = true;
                }

                return StreamBuilder<UnmodifiableListView<Joke>>(
                  stream: jokeListBloc.items,
                  builder: (BuildContext context,
                      AsyncSnapshot<UnmodifiableListView<Joke>> jokesSnapshot) {
                    
                        return Stack(
                          children: <Widget>[
                            _jokeSlide(jokesSnapshot.data),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: (currentJoke != null)
                                        ? _jokeOptions(currentJoke, context)
                                        : Container(),
                            ),
                          ],
                        );
                      },
                );
              }),
        );
      }
    );
  }

   void _scrollListener() {
    if (_pageController.position.extentAfter < 2000 && canLoadMore) {
      print("Load more stuffs");
      jokeListBloc.getItems();
      canLoadMore = false;
    }
  }

  _handlePageChanged(index, Joke joke) {
    // _currentPageIndex = index;
    jokeListBloc.changeCurrentJoke(joke);
    jokeControlBloc = JokeControlBloc(
        jokeControlled: joke,
        jokeListBloc: jokeListBloc,
        jokeService: JokeService());
  }

  _displayImageJoke(Joke joke) {
    return Stack(
      children: <Widget>[
        ZoomableImage(CachedNetworkImageProvider(joke.imageUrl),
            placeholder: const Center(child: const CircularProgressIndicator()),
            backgroundColor: Colors.black),
        (joke.text != null)
            ? _buildImageJokeTextContent(joke.text)
            : Container(),
      ],
    );
  }

  _displayTextJoke(Joke joke) {
    return ListView(
      
      children: <Widget>[
        RepaintBoundary(
          key: textJokeBoundaryKey,
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 200),
                                          child: Container(
                        padding: EdgeInsets.all(8.0),
                        
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Text(
              joke.text,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
          ),
                    ),
        )
      ],
    );
  }

  _buildImageJokeTextContent(String content) {
    return Positioned(
      child: (content.length > 50)
          ? ExpansionTile(
              title: Text(content.substring(0, 47) + '...'),
              children: <Widget>[Text(content)],
            )
          : Text(content, style: TextStyle(color: Colors.white),),
    );
  }

  _jokeSlide(UnmodifiableListView<Joke> jokes) {
    return (jokes != null && jokes.isNotEmpty)
        ? PageView.builder(
            itemCount: jokes.length,
            controller: _pageController,
            onPageChanged: (index) {
              _handlePageChanged(index, jokes[index]);
            },
            itemBuilder: (BuildContext context, int index) {
              Joke joke = jokes[index];

              return Padding(
                padding: EdgeInsets.only(bottom: 100, top: 10),
                child: joke.hasImage()?  _displayImageJoke(joke): _displayTextJoke(joke),
              );
            },
          )
        : CircularProgressIndicator();
  }

  _jokeOptions(Joke joke, BuildContext context) {
    Color iconColor =
        (joke.hasImage()) ? Colors.white : Theme.of(context).iconTheme.color;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Text('${joke.commentCount} comments', style: TextStyle(color: iconColor),),
                onTap: () {
                  gotoJokeCommentsPage(context, joke: joke, jokeListBloc: jokeListBloc);
                },
              ),
              GestureDetector(
                child: Text('${joke.likeCount} likes', style: TextStyle(color: iconColor)),
                onTap: () {
                  gotoJokeLikersPage(context, joke: joke);
                },
              ),
            ],
          ),
        ),

        BlocProvider<JokeControlBloc>(
            bloc: jokeControlBloc,
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
              
              JokeLikeActionButton(joke: joke, iconColor: iconColor,),
              JokeSaveActionButton(joke: joke, textJokeBoundaryKey: textJokeBoundaryKey, iconColor: iconColor, ),
              JokeFavoriteActionButton(joke: joke,iconColor: iconColor,),
              JokeShareActionButton(joke: joke, iconColor: iconColor,),
          ],
        ),
        ),
        
      ],
    );
  }
}
