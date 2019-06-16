import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/auth_bloc.dart';
import 'package:tv_series_jokes/blocs/joke_add_bloc.dart';
import 'package:tv_series_jokes/blocs/joke_list_bloc.dart';
import 'package:tv_series_jokes/models/bloc_delegate.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/models/user.dart';
import 'package:tv_series_jokes/navigation/router.dart';
import 'package:tv_series_jokes/services/auth_service.dart';
import 'package:tv_series_jokes/services/joke_service.dart';
import 'package:tv_series_jokes/services/movie_service.dart';
import 'package:tv_series_jokes/ui/widgets/buttons/general_buttons.dart';

class JokeAddPage extends StatefulWidget {
  final Movie selectedMovie;
  JokeAddPage({Key key, this.selectedMovie}) : super(key: key);

  @override
  _JokeAddPageState createState() => new _JokeAddPageState();
}

class _JokeAddPageState extends State<JokeAddPage>
    implements BlocDelegate<Joke> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textController = TextEditingController();
  TextEditingController _movieController = TextEditingController();
  File _imageToUpload;
  BuildContext _context;
  int _selectedTmdbMovieId; // This is the Id used to save the movie
  User currentUser;

  MovieService movieService = MovieService();
  JokeAddBloc jokeAddBloc;
  AuthBloc authBloc;


  @override
  void initState() {
    super.initState();
    jokeAddBloc = JokeAddBloc(jokeService: JokeService(), delegate: this);
    _selectedTmdbMovieId = widget.selectedMovie?.tmdbMovieId;
    _movieController.text =
        (widget.selectedMovie != null) ? widget.selectedMovie.name : '';
    authBloc = AuthBloc(authService: AuthService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text('Add Joke'),
          ),
      body: Builder(builder: (context) {
        _context = context;
        return SingleChildScrollView(
          child: StreamBuilder<User>(
            stream: authBloc.currentUser,
            builder: (context, currentUsersnapshot) {
              currentUser = currentUsersnapshot.data;
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildMovieSelectionField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildTextJokeSpecificLayout(),
                      _buildImageJokeSpecificLayout(),
                      _buildJokeAddSubmitionButton()
                    ],
                  ),
                ),
              );
            }
          ),
        );
      }),
    );
  }

  _buildJokeAddSubmitionButton() {
    return StreamBuilder<LoadState>(
      initialData: Loaded(),
      stream: jokeAddBloc.loadState,
      builder: (context, loadStateSnapShot) {
        LoadState loadState = loadStateSnapShot.data;

        return Hero(
          tag: 'joke_add',
                  child: RoundedButton(
              child: (loadState is Loading)
                  ? CircularProgressIndicator()
                  : Text(
                      'ADD JOKE',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: (loadState is Loading)
                  ? null
                  : () {
                      _submitJoke();
                    },
            ),
        );
      },
    );
  }

  _submitJoke() {
    if (_formKey.currentState.validate()) {
      if (_selectedTmdbMovieId != null) {
          if(_textController.text.isNotEmpty || _imageToUpload != null ){

          Map<String, dynamic> jokeUploadDetails = {
              'imageToUpload': _imageToUpload,
              'tmdbMovieId': _selectedTmdbMovieId,
              'text': _textController.text,
          };

          jokeAddBloc.addJoke(jokeUploadDetails);
          }else{
             Scaffold.of(_context).showSnackBar(SnackBar(
                content: Text('Please add an image or a text'),
            ));
          }
      } else {
        Scaffold.of(_context).showSnackBar(SnackBar(
          content: Text('Please select a movie'),
        ));
      }
    }
  }

  _buildMovieSelectionField() {
    return TypeAheadFormField(
      debounceDuration: Duration(milliseconds: 500),
      textFieldConfiguration: TextFieldConfiguration(
        onChanged: (value) {
          print(value);
        },
        decoration: InputDecoration(
          hintText: 'Movie',
          labelText: 'Movie',
          helperText: 'Search and select movie from the options'
        ),
        controller: this._movieController,
      ),
      suggestionsCallback: (String pattern) async {
        if(pattern.isEmpty){
          // show cached names
        }
        return await movieService.searchTmdbMovieAsList(searchString:pattern);
      },
      itemBuilder: (context, tmdbMovieSuggestion) {
        return ListTile(
          title: Text(tmdbMovieSuggestion.name),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (tmdbMovieSuggestion) {
        this._movieController.text = tmdbMovieSuggestion.name;
        _selectedTmdbMovieId= tmdbMovieSuggestion.id;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please select a Movie';
        }
      },
    );
  }

  _buildTextJokeSpecificLayout() {
    return TextFormField(
      maxLines: null,
      controller: _textController,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          hintText: 'Joke Text(optional)\n\n\n',
          labelText: 'Joke Text(optional)',
          ),
          validator: (value){
            if(value.trim().isNotEmpty &&  value.trim().length < 10){
              return 'Joke Should be more than 10 characters';
            }
          },
    );
  }

  _buildImageJokeSpecificLayout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
           FlatButton(
             textColor: Theme.of(context).accentColor ,
            child: Row(
              children: <Widget>[
                Icon(Icons.image),
                Text('SELECT IMAGE',)
              ],
            ),
            onPressed: () {
              _getImageFromGallery();
            },
          ),
          SizedBox(
            width: 10,
          ),
          (_imageToUpload != null)?Container(
            height: 180.0,
            width: 180.0,
            decoration: BoxDecoration(
                image: DecorationImage(image: FileImage(_imageToUpload))),
          ): Container(),
         
        ],
      ),
    );
  }

  _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageToUpload = image;
    });
  }

  @override
  error(String errorMessage) {
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text('Error while adding joke $errorMessage'),
    ));
    return null;
  }

  @override
  success(Joke t) async {
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text('Joke successfully added!!'),
    ));
    await Future.delayed(Duration(seconds: 2));
    gotoJokeListPage(context, pageTitle: 'My Jokes', fetchType: JokeListFetchType.userJokes, user: currentUser);
    return null;
  }
}
