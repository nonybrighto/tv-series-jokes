import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/user_list_bloc.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/navigation/router.dart';

class UsernameText extends StatelessWidget {

  final User user;
  final Function() onPressed;
  final TextStyle style;
  UsernameText({this.user, this.onPressed, this.style});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onPressed ?? (){
              gotoUserDetailsPage(context, user, userListBloc: BlocProvider.of<UserListBloc>(context));
          },
          child: Text(user.username, style: style ?? TextStyle(
             fontSize: 15,
             fontWeight: FontWeight.bold
          ),),
    );
  }
}