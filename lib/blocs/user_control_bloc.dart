import 'dart:async';

import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/user_details_bloc.dart';
import 'package:tv_series_jokes/blocs/user_list_bloc.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/services/user_service.dart';

class UserControlBloc extends BlocBase{
  
  User userControlled;
  UserListBloc userListBloc;
  UserDetailsBloc userDetailsBloc;
  UserService userService;

  final _toggleUserFollow = StreamController<Null>();

  void Function() get toggleUserFollow => () => _toggleUserFollow.sink.add(null);

  UserControlBloc({this.userControlled, this.userListBloc, this.userDetailsBloc, this.userService}){

    _toggleUserFollow.stream.listen(_handleToggleUserFollow);
  }

  _handleToggleUserFollow(_)  async{
      _updateUser();
      _toggleFollow();
      _updateUsersInControlledBlocs();
      try{
          await userService.changeUserFollow(user: userControlled, follow:userControlled.followed);
      }catch(err){
        _toggleFollow();
        _updateUsersInControlledBlocs();
      } 
  }

  _toggleFollow(){
        userControlled = userControlled.rebuild((b) => b..followed = !b.followed);
  }

  //Gets the latest details of the user that the user details bloc retrieves from the server so that it doesn't send stale data
  _updateUser(){
    userControlled = userDetailsBloc?.viewedUser ?? userControlled;
  }

  //notify list and detail blocs of changes that have taken place
  _updateUsersInControlledBlocs(){
      userListBloc?.updateItem(userControlled);
      userDetailsBloc?.updateUser(userControlled);
  }
  
  @override
  void dispose() {
    _toggleUserFollow.close();
  }


}