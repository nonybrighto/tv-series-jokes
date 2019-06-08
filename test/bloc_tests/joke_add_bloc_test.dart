import 'package:mockito/mockito.dart';
import 'package:tv_series_jokes/blocs/joke_add_bloc.dart';
import 'package:tv_series_jokes/models/bloc_delegate.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';


String errorMessage;
class DelegateMock extends BlocDelegate<Joke>{
  @override
  error(String message) {
    errorMessage = message;
  }

  @override
  success(Joke joke) {
    //successUser = user;
  }
 

}

void main(){

   JokeService jokeService;
  Map<String, dynamic> sampleJokeDetails;
  setUp(() {

    jokeService = MockJokeService();
    sampleJokeDetails = {
              'imageToUpload': '_imageToUpload',
              'tmdbMovieId': 1,
              'title': '_titleController.text',
              'text': '_textController.text',
          };

    // when(jokeService.addJoke(jokeUploadDetails:anyNamed('jokeUploadDetails')))
    //     .thenAnswer((_) async => sampleJokeDetails);
  });



  test('expect to save joke successfully', ()async{

    DelegateMock delegateMock = new DelegateMock();
    JokeAddBloc jokeAddBloc = JokeAddBloc(jokeService: jokeService, delegate: delegateMock);

    jokeAddBloc.addJoke(sampleJokeDetails);
    expect(jokeAddBloc.loadState, emitsInOrder([loaded, loading, loaded]));
    await Future.delayed(Duration(seconds: 3));
    verify(jokeService.addJoke(jokeUploadDetails:anyNamed('jokeUploadDetails')));
  });

  test('expect to return error when joke add fails', ()async{

    when(jokeService.addJoke(jokeUploadDetails:anyNamed('jokeUploadDetails')))
        .thenAnswer((_) async =>  Future.error('error occured'));

    DelegateMock delegateMock = new DelegateMock();
    JokeAddBloc jokeAddBloc = JokeAddBloc(jokeService: jokeService, delegate: delegateMock);

    jokeAddBloc.addJoke(sampleJokeDetails);
    expect(jokeAddBloc.loadState, emitsInOrder([loaded, loading, loadError]));
    await Future.delayed(Duration(seconds: 3));
    expect(errorMessage, 'error occured');
    verify(jokeService.addJoke(jokeUploadDetails:anyNamed('jokeUploadDetails')));
  });
}