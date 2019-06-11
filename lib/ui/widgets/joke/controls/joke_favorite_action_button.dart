import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/auth_bloc.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_control_bloc.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/navigation/router.dart';
import 'package:tv_series_jokes/ui/pages/auth_page.dart';
import 'package:tv_series_jokes/ui/widgets/joke/joke_action_button.dart';

class JokeFavoriteActionButton extends StatelessWidget {

  final Joke joke;
  final Color iconColor;
  final double size;
  JokeFavoriteActionButton({this.joke, this.iconColor, this.size});
  @override
  Widget build(BuildContext context) {
    JokeControlBloc jokeControlBloc = BlocProvider.of<JokeControlBloc>(context);
    return  StreamBuilder<bool>(
                  stream: BlocProvider.of<AuthBloc>(context).isAuthenticated,
                  builder: (context, isAuthenticatedSnapshot) {
                    return JokeActionButton(
                        title: 'Favorite',
                        icon: Icons.favorite,
                        selected: joke.favorited,
                        size: size,
                        onTap: () {
                          if(isAuthenticatedSnapshot.data){
                            jokeControlBloc.toggleJokeFavorite((addedToFavorite, message){

                                if(!addedToFavorite){
                                  Scaffold.of(context).showSnackBar(SnackBar(content: Text(message),));
                                }
                            });
                          }else{
                            Router.gotoAuthPage(context, AuthType.login);
                          }
                        });
                  }
                );
  }
}