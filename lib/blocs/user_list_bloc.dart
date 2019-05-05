import 'dart:async';

import 'package:tv_series_jokes/blocs/list_bloc.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/models/user_list_response.dart';
import 'package:tv_series_jokes/services/user_service.dart';

class UserListBloc extends ListBloc<User>{
 
 final UserService userService;

  Joke _jokeLiked;
  User _userForFollow;
  UserFollowType _followType;

  UserListFetchType _userListFetchType;


  StreamController _fetchjokeLikersController =StreamController<Joke>();
  StreamController<Map<String, dynamic>> _fetchUserFollowersController =StreamController<Map<String, dynamic>>();
  StreamController _fetchUserFollowingController =StreamController<User>();


  //stream


  //sink
  void Function(Joke) get fetchJokeLikers => (joke) => _fetchjokeLikersController.sink.add(joke);
  void Function(User, UserFollowType) get fetchUserFollow => (user, followType) => _fetchUserFollowersController.sink.add({'user': user, 'followType':followType});

 
 UserListBloc({this.userService}){


    _fetchjokeLikersController.stream.listen((joke){
          _userListFetchType =UserListFetchType.jokeLikers;
          _jokeLiked =joke;
          _getFirstPageUsers();
    });

    _fetchUserFollowersController.stream.listen((followDetails){
        _userForFollow =followDetails['user'];
        _followType = followDetails['followType'];
        _userListFetchType = UserListFetchType.userFollow;
        _getFirstPageUsers();
    });
 }
 
  @override
  void dispose() {

    _fetchjokeLikersController.close();
    _fetchUserFollowersController.close();
    _fetchUserFollowingController.close();

  }

  _getFirstPageUsers(){
     currentPage = 1;
     getItems();
  }

  @override
  Future<UserListResponse> fetchFromServer() async{

    switch (_userListFetchType) {
      case UserListFetchType.jokeLikers:
        return await userService.fetchJokeLikers(jokeLiked: _jokeLiked, page: currentPage);
        break;
      case UserListFetchType.userFollow:
        return await userService.fetchUserFollow(user: _userForFollow, userFollowType: _followType, page: currentPage);
      break;
      default:
          return null;
    }
  }

  @override
  bool itemIdentificationCondition(User currentUser, User updatedUser) {
    return currentUser.id == updatedUser.id;
  }

  @override
  String getEmptyResultMessage() {
    
    return 'No Users to display';
  }
}

enum UserListFetchType{jokeLikers, userFollow}

enum UserFollowType{followers, following}