import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_control_bloc.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/ui/widgets/joke/joke_action_button.dart';
import 'package:tv_series_jokes/utils/joke_save_util.dart';
import 'package:permission_handler/permission_handler.dart';

class JokeSaveActionButton extends StatelessWidget {

  final GlobalKey textJokeBoundaryKey;
  final Joke joke;
  final double size;
  final Color iconColor;
  JokeSaveActionButton({this.textJokeBoundaryKey, this.joke, this.size, this.iconColor});
  @override
  Widget build(BuildContext context) {
    JokeControlBloc jokeControlBloc = BlocProvider.of<JokeControlBloc>(context);
    return StreamBuilder<LoadState>(
                    initialData: Loaded(),
                    stream: jokeControlBloc.jokeSaveLoadState,
                    builder: (context, jokeSaveLoadStateSnapshot) {
                      String extraSaveText =
                          (jokeSaveLoadStateSnapshot.data is Loading)
                              ? '...'
                              : '';
                      return JokeActionButton(
                          title: 'Save' + extraSaveText,
                          icon: Icons.arrow_downward,
                          selected: false,
                          size: size,
                          onTap: () async {
                            
                            PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
                            
                            if(permission !=  PermissionStatus.granted){
                                  Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);

                                  if(permissions[PermissionGroup.storage] == PermissionStatus.granted){
                                        await saveJoke(context, jokeControlBloc);
                                  }else{
                                     Scaffold.of(context).showSnackBar(SnackBar(content:Text('Enable permission to save file'), action: SnackBarAction(label: 'OPEN', onPressed: () async{
                                    await PermissionHandler().openAppSettings();
                                  },),));
                                  }
                            }else{
                              await saveJoke(context, jokeControlBloc);
                            }
                          });
                    });
  }

  saveJoke(BuildContext context, JokeControlBloc jokeControlBloc) async{

      if (joke.hasImage()) {
        jokeControlBloc.saveImageJoke((message) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
        });
      } else {
        jokeControlBloc.saveTextJoke(
          await JokeSaveUtil()
              .textToImage(textJokeBoundaryKey),
          (message) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
        });
      }
  }
}