import 'dart:async';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:tv_series_jokes/blocs/auth_bloc.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/user_details_bloc.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/services/user_service.dart';

class UserSettingsBloc extends BlocBase{
 
 
  UserService userService;

  final _changeUserPhotoController = StreamController<File>();
  final _loadStateController = BehaviorSubject<LoadState>();

  void Function(File) get changeUserPhoto => (photo) => _changeUserPhotoController.sink.add(photo);

  Stream<LoadState> get loadState => _loadStateController.stream;

  UserSettingsBloc({this.userService, AuthBloc authBloc, UserDetailsBloc userDetailsBloc}){

      _loadStateController.sink.add(Loaded());

      _changeUserPhotoController.stream.listen((photo) async{

            try{
              _loadStateController.sink.add(Loading());
              User updatedUser = await userService.changeUserPhoto(photo: photo);
              authBloc.changeCurrentUser(updatedUser);
              userDetailsBloc?.updateUser(updatedUser);
              _loadStateController.sink.add(LoadEnd());
            }catch(error){
              _loadStateController.sink.add(LoadError(error.message));
            }
      });
  }
 
  @override
  void dispose() {
    _changeUserPhotoController.close();
    _loadStateController.close();
  }


}