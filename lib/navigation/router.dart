import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_comment_list_bloc.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/blocs/movie_details_bloc.dart';
import 'package:tv_series_jokes/blocs/movie_list_bloc.dart';
import 'package:tv_series_jokes/blocs/user_details_bloc.dart';
import 'package:tv_series_jokes/blocs/user_list_bloc.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:tv_series_jokes/services/movie_service.dart';
import 'package:tv_series_jokes/services/user_service.dart';
import 'package:tv_series_jokes/ui/pages/about_page.dart';
import 'package:tv_series_jokes/ui/pages/auth_page.dart';
import 'package:tv_series_jokes/ui/pages/home_page.dart';
import 'package:tv_series_jokes/ui/pages/joke/joke_add_page.dart';
import 'package:tv_series_jokes/ui/pages/joke/joke_comments_page.dart';
import 'package:tv_series_jokes/ui/pages/joke/joke_display_page.dart';
import 'package:tv_series_jokes/ui/pages/joke/joke_list_page.dart';
import 'package:tv_series_jokes/ui/pages/movie/movie_details.page.dart';
import 'package:tv_series_jokes/ui/pages/movie/movie_list_page.dart';
import 'package:tv_series_jokes/ui/pages/settings_page.dart';
import 'package:tv_series_jokes/ui/pages/user/user_details_page.dart';
import 'package:tv_series_jokes/ui/pages/user/user_list_page.dart';

class Router{



  static gotoHomePage(BuildContext context){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
  }

  static gotoUserDetailsPage(BuildContext context, User user, {UserListBloc userListBloc}){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<UserDetailsBloc>(
          bloc: UserDetailsBloc(userService: UserService(), viewedUser: user),
          child: UserDetailsPage(user: user, userListBloc: userListBloc,),
    )));

  }


  static gotoMoviePage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<MovieListBloc>(
          bloc: MovieListBloc(movieService:  MovieService()),
          child: MovieListPage(),
        )));
  }
  static gotoMovieDetialsPage(BuildContext context, {Movie movie, MovieListBloc movieListBloc}){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<MovieDetailsBloc>(
          bloc: MovieDetailsBloc(viewedMovie: movie, movieService:  MovieService(), movieListBloc: movieListBloc),
          child: MovieDetailsPage(movie: movie),
        )));
  }
  static gotoAuthPage(BuildContext context, AuthType authType){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthPage(authType)));
  }
  static gotoAddJokePage(BuildContext context, {Movie selectedMovie}){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => JokeAddPage(selectedMovie: selectedMovie,)));
  }
  static gotoSettingsPage(BuildContext context){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
  }
  static gotoAboutPage(BuildContext context){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutPage()));
  }

  static gotoJokeDisplayPage(BuildContext context, {int initialPage, JokeListBloc jokeListBloc, Joke joke}){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<JokeListBloc>(
      bloc: jokeListBloc,
      child: JokeDisplayPage(initialPage: initialPage, currentJoke: joke,),)));
  }

  static gotoJokeCommentsPage(BuildContext context, {Joke joke, JokeListBloc jokeListBloc}){

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<JokeCommentListBloc>(
          bloc: JokeCommentListBloc(joke, jokeService: JokeService(), jokeListBloc:  jokeListBloc),
          child: JokeCommentPage(),
        )));
  }
  static gotoJokeLikersPage(BuildContext context, {Joke joke}){

        UserListBloc userListBloc = UserListBloc(userService: UserService());
        userListBloc.fetchJokeLikers(joke);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<UserListBloc>(
          bloc: userListBloc,
          child: UserListPage(showFollowDetails: false,),
        )));
  }

  static gotoUserFollowPage(BuildContext context, {User user, UserFollowType followType}){

      UserListBloc userListBloc = UserListBloc(userService: UserService());
        userListBloc.fetchUserFollow(user, followType);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<UserListBloc>(
          bloc: userListBloc,
          child: UserListPage(showFollowDetails: true,),
        )));

  }
  static gotoJokeListPage(BuildContext context, {User user, Movie movie, JokeListFetchType fetchType, String pageTitle}){

        JokeListBloc jokeListBloc = JokeListBloc(user: user, movie: movie, fetchType: fetchType, jokeService: JokeService());
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<JokeListBloc>(
          bloc: jokeListBloc,
          child: JokeListPage(pageTitle: pageTitle, movie: movie,),
        )));

  }

}