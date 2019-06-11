import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/auth_bloc.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/user_control_bloc.dart';
import 'package:tv_series_jokes/blocs/user_list_bloc.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/navigation/router.dart';
import 'package:tv_series_jokes/services/user_service.dart';
import 'package:tv_series_jokes/ui/pages/auth_page.dart';
import 'package:tv_series_jokes/ui/widgets/user/user_profile_icon.dart';
import 'package:tv_series_jokes/ui/widgets/user/username_text.dart';

class UserCard extends StatelessWidget {
  final User user;
  final bool showFollowDetails;
  UserCard({this.user, this.showFollowDetails});

  @override
  Widget build(BuildContext context) {
    String jokeCountWord = (user.jokeCount > 0) ? ' Jokes' : ' Joke';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
            leading: UserProfileIcon(
              user: user,
            ),
            title: UsernameText(user: user),
            subtitle: Row(
              children: <Widget>[
                Text(user.jokeCount.toString() + jokeCountWord),
                SizedBox(
                  width: 10,
                ),
                (user.following && showFollowDetails)
                    ? Chip(
                        label: Text(
                          'FOLLOWS YOU',
                          style: TextStyle(fontSize: 10),
                        ),
                      )
                    : Container()
              ],
            ),
            trailing: (showFollowDetails)
                ? _buildFollowButton(context)
                : Container(
                    width: 0,
                  )),
        Divider(
          indent: 59,
        )
      ],
    );
  }

  _buildFollowButton(BuildContext context) {
    UserControlBloc userControlBloc = UserControlBloc(
        userControlled: user,
        userListBloc: BlocProvider.of<UserListBloc>(context),
        userService: UserService());
    return BlocProvider<UserControlBloc>(
        bloc: userControlBloc,
        child: StreamBuilder<bool>(
          stream: BlocProvider.of<AuthBloc>(context).isAuthenticated,
          builder: (context, isAuthenticatedSnapshot) {
            return (user.followed)
                ? FlatButton(
                    child: Text(
                      'FOLLOWING',
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      userControlBloc.toggleUserFollow();
                    },
                  )
                : RaisedButton(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'FOLLOW',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    onPressed: () {
                      if(isAuthenticatedSnapshot.data){
                        userControlBloc.toggleUserFollow();
                      }else{
                        Router.gotoAuthPage(context, AuthType.login);
                      }
                    },
                  );
          }
        ));
  }
}
