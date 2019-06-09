import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/user_list_bloc.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/navigation/router.dart';

class UserProfileIcon extends StatelessWidget {

  final User user;
  final Function() onPressed;
  UserProfileIcon({this.user, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onPressed ?? (){
              Router.gotoUserDetailsPage(context, user, userListBloc: BlocProvider.of<UserListBloc>(context));
          },
          child: CircleAvatar(
          child: (user.profilePhoto == null)? Text(user.username.substring(0,1)) : null,
          backgroundImage: (user.profilePhoto!=null)?NetworkImage(user.profilePhoto): null,
      ),
    );
  }
}