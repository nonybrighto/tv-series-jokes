// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TmdbMovie> _$tmdbMovieSerializer = new _$TmdbMovieSerializer();

class _$TmdbMovieSerializer implements StructuredSerializer<TmdbMovie> {
  @override
  final Iterable<Type> types = const [TmdbMovie, _$TmdbMovie];
  @override
  final String wireName = 'TmdbMovie';

  @override
  Iterable serialize(Serializers serializers, TmdbMovie object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'overview',
      serializers.serialize(object.overview,
          specifiedType: const FullType(String)),
      'first_air_date',
      serializers.serialize(object.firstAirDate,
          specifiedType: const FullType(DateTime)),
      'vote_average',
      serializers.serialize(object.voteAverage,
          specifiedType: const FullType(double)),
    ];
    if (object.backdropPath != null) {
      result
        ..add('backdrop_path')
        ..add(serializers.serialize(object.backdropPath,
            specifiedType: const FullType(String)));
    }
    if (object.lastAirDate != null) {
      result
        ..add('last_air_date')
        ..add(serializers.serialize(object.lastAirDate,
            specifiedType: const FullType(DateTime)));
    }
    if (object.numberOfSeasons != null) {
      result
        ..add('number_of_seasons')
        ..add(serializers.serialize(object.numberOfSeasons,
            specifiedType: const FullType(int)));
    }
    if (object.genres != null) {
      result
        ..add('genres')
        ..add(serializers.serialize(object.genres,
            specifiedType: const FullType(
                BuiltList, const [const FullType(TmdbMovieGenre)])));
    }
    if (object.credits != null) {
      result
        ..add('credits')
        ..add(serializers.serialize(object.credits,
            specifiedType: const FullType(TmdbMovieCredit)));
    }

    return result;
  }

  @override
  TmdbMovie deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TmdbMovieBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'backdrop_path':
          result.backdropPath = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'overview':
          result.overview = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'first_air_date':
          result.firstAirDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'last_air_date':
          result.lastAirDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'vote_average':
          result.voteAverage = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'number_of_seasons':
          result.numberOfSeasons = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'genres':
          result.genres.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TmdbMovieGenre)]))
              as BuiltList);
          break;
        case 'credits':
          result.credits.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TmdbMovieCredit))
              as TmdbMovieCredit);
          break;
      }
    }

    return result.build();
  }
}

class _$TmdbMovie extends TmdbMovie {
  @override
  final int id;
  @override
  final String name;
  @override
  final String backdropPath;
  @override
  final String overview;
  @override
  final DateTime firstAirDate;
  @override
  final DateTime lastAirDate;
  @override
  final double voteAverage;
  @override
  final int numberOfSeasons;
  @override
  final BuiltList<TmdbMovieGenre> genres;
  @override
  final TmdbMovieCredit credits;

  factory _$TmdbMovie([void Function(TmdbMovieBuilder) updates]) =>
      (new TmdbMovieBuilder()..update(updates)).build();

  _$TmdbMovie._(
      {this.id,
      this.name,
      this.backdropPath,
      this.overview,
      this.firstAirDate,
      this.lastAirDate,
      this.voteAverage,
      this.numberOfSeasons,
      this.genres,
      this.credits})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('TmdbMovie', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('TmdbMovie', 'name');
    }
    if (overview == null) {
      throw new BuiltValueNullFieldError('TmdbMovie', 'overview');
    }
    if (firstAirDate == null) {
      throw new BuiltValueNullFieldError('TmdbMovie', 'firstAirDate');
    }
    if (voteAverage == null) {
      throw new BuiltValueNullFieldError('TmdbMovie', 'voteAverage');
    }
  }

  @override
  TmdbMovie rebuild(void Function(TmdbMovieBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TmdbMovieBuilder toBuilder() => new TmdbMovieBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TmdbMovie &&
        id == other.id &&
        name == other.name &&
        backdropPath == other.backdropPath &&
        overview == other.overview &&
        firstAirDate == other.firstAirDate &&
        lastAirDate == other.lastAirDate &&
        voteAverage == other.voteAverage &&
        numberOfSeasons == other.numberOfSeasons &&
        genres == other.genres &&
        credits == other.credits;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc($jc(0, id.hashCode), name.hashCode),
                                    backdropPath.hashCode),
                                overview.hashCode),
                            firstAirDate.hashCode),
                        lastAirDate.hashCode),
                    voteAverage.hashCode),
                numberOfSeasons.hashCode),
            genres.hashCode),
        credits.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TmdbMovie')
          ..add('id', id)
          ..add('name', name)
          ..add('backdropPath', backdropPath)
          ..add('overview', overview)
          ..add('firstAirDate', firstAirDate)
          ..add('lastAirDate', lastAirDate)
          ..add('voteAverage', voteAverage)
          ..add('numberOfSeasons', numberOfSeasons)
          ..add('genres', genres)
          ..add('credits', credits))
        .toString();
  }
}

class TmdbMovieBuilder implements Builder<TmdbMovie, TmdbMovieBuilder> {
  _$TmdbMovie _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _backdropPath;
  String get backdropPath => _$this._backdropPath;
  set backdropPath(String backdropPath) => _$this._backdropPath = backdropPath;

  String _overview;
  String get overview => _$this._overview;
  set overview(String overview) => _$this._overview = overview;

  DateTime _firstAirDate;
  DateTime get firstAirDate => _$this._firstAirDate;
  set firstAirDate(DateTime firstAirDate) =>
      _$this._firstAirDate = firstAirDate;

  DateTime _lastAirDate;
  DateTime get lastAirDate => _$this._lastAirDate;
  set lastAirDate(DateTime lastAirDate) => _$this._lastAirDate = lastAirDate;

  double _voteAverage;
  double get voteAverage => _$this._voteAverage;
  set voteAverage(double voteAverage) => _$this._voteAverage = voteAverage;

  int _numberOfSeasons;
  int get numberOfSeasons => _$this._numberOfSeasons;
  set numberOfSeasons(int numberOfSeasons) =>
      _$this._numberOfSeasons = numberOfSeasons;

  ListBuilder<TmdbMovieGenre> _genres;
  ListBuilder<TmdbMovieGenre> get genres =>
      _$this._genres ??= new ListBuilder<TmdbMovieGenre>();
  set genres(ListBuilder<TmdbMovieGenre> genres) => _$this._genres = genres;

  TmdbMovieCreditBuilder _credits;
  TmdbMovieCreditBuilder get credits =>
      _$this._credits ??= new TmdbMovieCreditBuilder();
  set credits(TmdbMovieCreditBuilder credits) => _$this._credits = credits;

  TmdbMovieBuilder();

  TmdbMovieBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _backdropPath = _$v.backdropPath;
      _overview = _$v.overview;
      _firstAirDate = _$v.firstAirDate;
      _lastAirDate = _$v.lastAirDate;
      _voteAverage = _$v.voteAverage;
      _numberOfSeasons = _$v.numberOfSeasons;
      _genres = _$v.genres?.toBuilder();
      _credits = _$v.credits?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TmdbMovie other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TmdbMovie;
  }

  @override
  void update(void Function(TmdbMovieBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TmdbMovie build() {
    _$TmdbMovie _$result;
    try {
      _$result = _$v ??
          new _$TmdbMovie._(
              id: id,
              name: name,
              backdropPath: backdropPath,
              overview: overview,
              firstAirDate: firstAirDate,
              lastAirDate: lastAirDate,
              voteAverage: voteAverage,
              numberOfSeasons: numberOfSeasons,
              genres: _genres?.build(),
              credits: _credits?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'genres';
        _genres?.build();
        _$failedField = 'credits';
        _credits?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TmdbMovie', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
