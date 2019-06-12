import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/auth_bloc.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/blocs/user_list_bloc.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/navigation/router.dart';
import 'package:tv_series_jokes/ui/pages/auth_page.dart';
import 'package:tv_series_jokes/ui/widgets/user/user_profile_icon.dart';

class AppDrawer extends StatelessWidget {


  AppDrawer();

  @override
  Widget build(BuildContext context) {
  AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    context = context;
    return Drawer(
      child: StreamBuilder<User>(
        stream: authBloc.currentUser,
        builder: (context, currentUserSnapshot) {
          User currentUser = currentUserSnapshot.data;
          bool isAuthenticated = currentUser != null; // used this instead of creating a seperate stream builder.
          return ListView(
            children: <Widget>[
                Divider(
                    height: 1,
                    color: Theme.of(context).accentColor,
                ),
                _drawerHeader(authBloc),
                _drawerItem(context, Icons.home, 'Home' , onTap: _handleHomeTap(context)),
                _drawerItem(context, Icons.movie, 'All Sitcoms' , onTap: _handleAllSitcomsTap(context)),
                _drawerItem(context, Icons.favorite, 'Favorites', onTap: _handleFavoritesTap(context, isAuthenticated)),
                (isAuthenticated)?_drawerItem(context, Icons.favorite, 'My Jokes', onTap: _handleCurrentUserJokesTap(context, currentUser)):Container(),
                _drawerItem(context, Icons.add_photo_alternate, 'Add Joke', onTap: _handleAddJokeTap(context)),
                Divider(),
                _drawerItem(context, Icons.settings, 'Settings', onTap: _handleSettingsTap(context)),
                _drawerItem(context, Icons.share, 'Share', onTap: _handleShareTap()),
                _drawerItem(context, Icons.info, 'About' , onTap: _handleAboutTap(context)),
                (isAuthenticated)?_drawerItem(context, Icons.favorite, 'Logout' , onTap: _handleLogoutTap(context, authBloc)): Container(),

            ],
          );
        }
      ),
    );
  }

  _drawerHeader(AuthBloc appBloc){

      
          return StreamBuilder<User>(
            stream: appBloc.currentUser,
            builder: (BuildContext context, AsyncSnapshot<User> currentUserSnapshot ){

                if(currentUserSnapshot.hasData && currentUserSnapshot.data != null){

                   return _buildUserProfile(currentUserSnapshot.data, context);
                }else{
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                       _buildAuthNavButton(context, authType: AuthType.login, buttonText: 'Login'),
                        _buildAuthNavButton(context, authType: AuthType.signup, buttonText: 'Sign Up'),

                    ],
                  );
                }
            }
          );

    

  }

  _buildUserProfile(User user, BuildContext context){

    return Container(
      height: 70,
      child: Stack(
        children: <Widget>[
          Row(
                children: <Widget>[
                   _buildProfileDetail(context, title:'Followers', count:user.followerCount, onPressed: (){
                      Router.gotoUserFollowPage(context,
                  user: user, followType: UserFollowType.followers);
                   }),
                   _buildProfileDetail(context, title:'Following', count:user.followingCount, onPressed: (){
                      Router.gotoUserFollowPage(context,
                             user: user, followType: UserFollowType.following);
                   }),
                ],
              ),

              Positioned(
                top: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                                  child: Container(
                    height: 70,
                    width: 70,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.all(5.0),
                    color: Theme.of(context).accentColor,
                    child: UserProfileIcon(user: user,),
                  ),
                ),
              )
        ],
      ),
    );
  }

  _buildProfileDetail(BuildContext context, {String title, int count, onPressed}){

        return InkWell(
                  onTap: onPressed,
                  splashColor: Theme.of(context).accentColor,
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12, top:10, bottom: 4),
                  child: Text(title, style: TextStyle(color: Theme.of(context).accentColor),),
                ),
                Text((count != null)?count.toString(): '', style: TextStyle(color: Colors.grey[500],)),
                //Text(count.toString()),
              ],
          ),
        );
  }

   _buildAuthNavButton(BuildContext context, {String buttonText, AuthType authType }){

    return FlatButton(
      textColor: Theme.of(context).accentColor,
      child: Text(buttonText), onPressed: (){
        Router.gotoAuthPage(context, authType);
    });
  }

  _handleHomeTap(BuildContext context){
    return (){
      Router.gotoHomePage(context);
    };
  }

  _handleAllSitcomsTap(BuildContext context){
    return (){
      Router.gotoMoviePage(context);
    };
  }

  _handleFavoritesTap(BuildContext context, bool isAuthenticated){
    return (){
      if(isAuthenticated){
        Router.gotoJokeListPage(context, pageTitle: 'Favorite Jokes', fetchType: JokeListFetchType.userFavJokes);
      }else{
          Router.gotoAuthPage(context, AuthType.login);
      }
    };
  }
  _handleCurrentUserJokesTap(BuildContext context, User currentUser){
    return (){
       Router.gotoJokeListPage(context, pageTitle: 'My Jokes', fetchType: JokeListFetchType.userJokes, user: currentUser);
    };
  }

  _handleAddJokeTap(BuildContext context){
    return (){
      Router.gotoAddJokePage(context);
    };
  }

  _handleSettingsTap(BuildContext context){
        return (){
      Router.gotoSettingsPage(context);
    };
  }

  _handleAboutTap(BuildContext context){
        return (){
      Router.gotoAboutPage(context);
    };
  }
  _handleLogoutTap(BuildContext context, AuthBloc authBloc){
        return (){
        authBloc.logout();
        Router.gotoHomePage(context);
    };
  }

  _handleShareTap(){ 

      return (){
         Share.text('(TvSeriesJokes App)', 'Hey! Checkout some funny TV series jokes in TvSeriesJokes '+
    ' Application!!! https://github.com/nonybrighto/tv-series-jokes', 'text/plain');

      };
  }


  _drawerItem(BuildContext context, IconData icon, String title, {CountDetails countDetails, @required onTap}){

    return  ListTile(
            leading: Icon(icon),
            title: Text(title),
            trailing: (countDetails != null)? CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('1'),
              radius: 10.0,
            ):null,
            onTap: (onTap != null) ? (){
              Navigator.pop(context);
               onTap();
            }: null,
          );
  }



}

class CountDetails{

  final int count;
  final Color color;

  CountDetails(this.count, this.color);
}