import 'package:flutter/material.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/navigation/router.dart';
import 'package:tv_series_jokes/ui/widgets/app_drawer.dart';
import 'package:tv_series_jokes/ui/widgets/joke/joke_add_button.dart';
import 'package:tv_series_jokes/ui/widgets/joke/joke_list.dart';

class JokeListPage extends StatefulWidget {
  final String pageTitle;
  final Movie movie;
  JokeListPage({Key key, this.pageTitle, this.movie}) : super(key: key);

  @override
  _JokeListPageState createState() => new _JokeListPageState();
}

class _JokeListPageState extends State<JokeListPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pageTitle), actions: <Widget>[
        if(widget.movie != null)IconButton(icon: Icon(Icons.info), onPressed: (){
          gotoMovieDetialsPage(context, movie:widget.movie);
        },)
      ],),
      drawer: AppDrawer(),
      body: JokeList(),
      floatingActionButton: JokeAddButton(selectedMovie: widget.movie),
    );
  }
}