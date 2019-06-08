import 'package:built_collection/built_collection.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_jokes/blocs/user_list_bloc.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/models/user_list_response.dart';
import 'package:tv_series_jokes/services/user_service.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';



void main(){

   UserService userService;
  BuiltList<User> sampleUsers;
  setUp(() {

    userService = MockUserService();
    sampleUsers = BuiltList([
      User((b) => b
      ..id=1
      ..username='peter $num'
      ..photoUrl='url $num'
      ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22
    )
    ]);

    when(userService.fetchJokeLikers(jokeLiked: anyNamed('jokeLiked')))
        .thenAnswer((_) async => UserListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleUsers.toBuilder()));
  });


  test('expect to fetch joke likers', ()async{

        UserListBloc userListBloc =
    UserListBloc(userService: userService);

    userListBloc.fetchJokeLikers(null);

     await Future.delayed(Duration(seconds: 2));

    verify(userService.fetchJokeLikers(jokeLiked: anyNamed('jokeLiked'), page: anyNamed('page')));
  });
}