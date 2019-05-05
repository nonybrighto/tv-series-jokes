import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_control_bloc.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/ui/widgets/joke/joke_action_button.dart';

class JokeShareActionButton extends StatelessWidget {

  final Joke joke;
  final double size;
  final Color iconColor;

  JokeShareActionButton({this.joke, this.size, this.iconColor});

  @override
  Widget build(BuildContext context) {
    JokeControlBloc jokeControlBloc = BlocProvider.of<JokeControlBloc>(context);
    return  StreamBuilder<LoadState>(
                    initialData: Loaded(),
                    stream: jokeControlBloc.jokeShareLoadState,
                    builder: (context, jokeShareLoadStateSnapshot) {
                      String extraShareText =
                          (jokeShareLoadStateSnapshot.data is Loading)
                              ? '...'
                              : '';
                      return JokeActionButton(
                          title: 'Share' + extraShareText,
                          icon: Icons.share,
                          selected: false,
                          size: size,
                          onTap: () {
                            jokeControlBloc.shareJoke();
                          });
                    });
  }
}