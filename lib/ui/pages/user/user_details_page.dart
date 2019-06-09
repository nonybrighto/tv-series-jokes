import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tv_series_jokes/blocs/auth_bloc.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/blocs/user_control_bloc.dart';
import 'package:tv_series_jokes/blocs/user_details_bloc.dart';
import 'package:tv_series_jokes/blocs/user_list_bloc.dart';
import 'package:tv_series_jokes/blocs/user_settings_bloc.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/navigation/router.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:tv_series_jokes/services/user_service.dart';
import 'package:tv_series_jokes/ui/pages/auth_page.dart';
import 'package:tv_series_jokes/ui/widgets/buttons/general_buttons.dart';
import 'package:tv_series_jokes/ui/widgets/joke/joke_list.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  final UserListBloc userListBloc;
  UserDetailsPage({Key key, this.user, this.userListBloc}) : super(key: key);

  @override
  _UserDetailsPageState createState() => new _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage>
    with SingleTickerProviderStateMixin {
  UserDetailsBloc userDetailsBloc;
  JokeListBloc jokeListBloc;
  UserControlBloc userControlBloc;
  UserSettingsBloc userSettingsBloc;
  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    print('user details page disposed');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UserService userService = UserService();
    jokeListBloc = JokeListBloc(
        jokeService: JokeService(),
        fetchType: JokeListFetchType.userJokes,
        user: widget.user);
    userDetailsBloc = BlocProvider.of<UserDetailsBloc>(context);
    userControlBloc = UserControlBloc(
        userControlled: widget.user,
        userDetailsBloc: userDetailsBloc,
        userListBloc: widget.userListBloc,
        userService: userService);
    userSettingsBloc = UserSettingsBloc(userService: userService, userDetailsBloc: userDetailsBloc, authBloc: BlocProvider.of<AuthBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userDetailsBloc.user,
      builder: (context, userSnapshot) {
        User user = userSnapshot.data;
        return Scaffold(
          body: (userSnapshot.hasData)
              ? CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                        title: Text(user.username),
                        expandedHeight: 250.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Container(
                                color: Colors.pink,
                                child: (user.profilePhoto != null)
                                    ? Image.network(
                                        user.profilePhoto,
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: _buildProfileHeader(user),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SliverToBoxAdapter(
                      child: BlocProvider<JokeListBloc>(
                        bloc: jokeListBloc,
                        child: JokeList(),
                      ),
                    )
                  ],
                )
              : Container(),
        );
      },
    );
  }

  _buildProfileHeader(User user) {

    return StreamBuilder<User>(
      stream: BlocProvider.of<AuthBloc>(context).currentUser,
      builder: (context, currentUserSnapshot) {
        User currentUser = currentUserSnapshot.data;
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildProfileIcon(user, currentUser),
              _buildDetailsRow(user),
              (currentUser != null && currentUser.id == user.id)? Container():_buildFollowButton(user),
            ],
          ),
        );
      }
    );
  }

  _buildProfileIcon(User user, User currentUser) {
    return Stack(
      
      children: <Widget>[
        
        CircleAvatar(
          radius: 60,
          backgroundImage:
              (user.profilePhoto != null) ? NetworkImage(user.profilePhoto) : null,
          child: (user.profilePhoto == null)
              ? Text(
                  user.username.substring(0, 1),
                  style: TextStyle(fontSize: 33),
                )
              : null,
        ),
        (currentUser != null && currentUser.id == user.id)?_buildEditIcon():Container(width: 0),
      ],
    );
  }

  _buildEditIcon(){
    return BlocProvider<UserSettingsBloc>(
      bloc: userSettingsBloc,
      child: StreamBuilder<LoadState>(
        stream: userSettingsBloc.loadState,
        builder: (context, loadStateSnapshot) {
          LoadState editLoadState = loadStateSnapshot.data;
          Widget editIcon = Icon(Icons.edit);
          if(editLoadState is Loading){
            editIcon = CircularProgressIndicator();
          }else if(editLoadState is LoadEnd){
            editIcon = Icon(Icons.done);
          }else if(editLoadState is LoadError){
            editIcon = Icon(Icons.cancel);
          }
          return CircleAvatar(
                      child: IconButton(
              icon: editIcon,
              onPressed: ()async{
                     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                     userSettingsBloc.changeUserPhoto(image);
              },
            ),
          );
        }
      ),
    );
  }

  _buildDetailsRow(User user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildUserDetail(
            title: 'Jokes', count: user.jokeCount, onPressed: () {}),
        SizedBox(
          width: 20,
        ),
        _buildUserDetail(
            title: 'Followers',
            count: user.followerCount,
            onPressed: () {
              Router.gotoUserFollowPage(context,
                  user: user, followType: UserFollowType.followers);
            }),
        SizedBox(
          width: 20,
        ),
        _buildUserDetail(
            title: 'Following',
            count: user.followingCount,
            onPressed: () {
              Router.gotoUserFollowPage(context,
                  user: user, followType: UserFollowType.following);
            }),
      ],
    );
  }

  _buildUserDetail({String title, int count, Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              count.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  _buildFollowButton(User user) {
    return BlocProvider(
      bloc: userControlBloc,
      child: StreamBuilder<LoadState>(
          initialData: Loading(),
          stream: userDetailsBloc.loadState,
          builder:
              (BuildContext context, AsyncSnapshot<LoadState> loadSnapshot) {
            return StreamBuilder<bool>(
                initialData: false,
                stream: BlocProvider.of<AuthBloc>(context).isAuthenticated,
                builder: (BuildContext context,
                    AsyncSnapshot<bool> isAuthenticatedSnapshot) {
                  return RoundedButton(
                    child: (loadSnapshot.data is Loading)
                        ? CircularProgressIndicator()
                        : Text(
                            (user.followed) ? 'FOLLOWING' : 'FOLLOW',
                            style: TextStyle(fontSize: 14),
                          ),
                    onPressed: (loadSnapshot.data is Loaded)
                        ? () {
                            if (isAuthenticatedSnapshot.data) {
                              userControlBloc.toggleUserFollow();
                            } else {
                              Router.gotoAuthPage(context, AuthType.login);
                            }
                          }
                        : null,
                  );
                });
          }),
    );
  }
}
