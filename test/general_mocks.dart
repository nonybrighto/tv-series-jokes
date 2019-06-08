import 'package:mockito/mockito.dart';
import 'package:tv_series_jokes/services/auth_service.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:tv_series_jokes/services/movie_service.dart';
import 'package:tv_series_jokes/services/user_service.dart';


//API mock
class MockJokeService extends Mock implements JokeService{}
class MockMovieService extends Mock implements MovieService{}
class MockUserService extends Mock implements UserService{}
class MockAuthService extends Mock implements AuthService{}