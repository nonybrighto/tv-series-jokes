import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tv_series_jokes/models/joke.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';


class JokeShareUtil{

  shareTextJoke(Joke joke){
    Share.text('(TvSeriesJokes, ${joke.movie.name}) - ${joke.title}', 
    '${joke.text} - (TvSeriesJokes, ${joke.movie.name})', 'text/plain');
  }

  shareImageJoke(Joke joke) async{
    final cacheManager = DefaultCacheManager();
    File file = await cacheManager.getSingleFile(joke.imageUrl);
    final fileBytes = await file.readAsBytes();
    await Share.file('(TvSeriesJokes, ${joke.movie.name})', 'TvSeriesJokes.jpg', fileBytes, 'image/jpg');
  }
}