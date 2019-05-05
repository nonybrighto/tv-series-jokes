import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/blocs/movie_list_bloc.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/models/movie/movie.dart';
import 'package:tv_series_jokes/services/movie_service.dart';

class MovieDetailsBloc extends BlocBase{
 
  Movie viewedMovie;
  final MovieService movieService;
  MovieListBloc movieListBloc;

  final _movieController = BehaviorSubject<Movie>();
  final _loadStateController = BehaviorSubject<LoadState>();
  final _getMovieDetailsController = StreamController<Null>();

  //stream
  Stream<LoadState> get loadState => _loadStateController.stream;
  Stream<Movie> get movie => _movieController.stream;

  //sink
  void Function() get getMovieDetails => () => _getMovieDetailsController.sink.add(null);
  
  MovieDetailsBloc({this.viewedMovie, this.movieListBloc, this.movieService}){
      
        _movieController.sink.add(viewedMovie);
        if(!viewedMovie.hasFullDetails()){
           getMovieDetails();
        }else{
           _loadStateController.sink.add(Loaded());
        }

      _getMovieDetailsController.stream.listen((_){
            _getMovieFromSource();
      });

  }

  _getMovieFromSource() async{
    _loadStateController.sink.add(Loading());
        try{
            Movie movieGotten = await movieService.getMovie(viewedMovie);
             viewedMovie  = movieGotten;
            _movieController.sink.add(movieGotten);
            _updateMovieInList(movieGotten);
            _loadStateController.sink.add(Loaded());
        }catch(err){
            _loadStateController.sink.add(LoadError('Could not get MovieDetails'));
        }
  }

  _updateMovieInList(Movie movieGotten){
    if(movieListBloc != null){
      movieListBloc.updateItem(movieGotten);
    }
  }

   updateMovie(Movie updatedMovie){
        viewedMovie  = updatedMovie;
        _movieController.sink.add(updatedMovie);
  }
  
  @override
  void dispose() {
    _movieController.close();
    _loadStateController.close();
    _getMovieDetailsController.close();
  }


}