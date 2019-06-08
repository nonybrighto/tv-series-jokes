// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Movie> _$movieSerializer = new _$MovieSerializer();

class _$MovieSerializer implements StructuredSerializer<Movie> {
  @override
  final Iterable<Type> types = const [Movie, _$Movie];
  @override
  final String wireName = 'Movie';

  @override
  Iterable serialize(Serializers serializers, Movie object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'tmdbMovieId',
      serializers.serialize(object.tmdbMovieId,
          specifiedType: const FullType(int)),
      'jokeCount',
      serializers.serialize(object.jokeCount,
          specifiedType: const FullType(int)),
      'firstAirDate',
      serializers.serialize(object.firstAirDate,
          specifiedType: const FullType(DateTime)),
      'followerCount',
      serializers.serialize(object.followerCount,
          specifiedType: const FullType(int)),
    ];
    if (object.followed != null) {
      result
        ..add('followed')
        ..add(serializers.serialize(object.followed,
            specifiedType: const FullType(bool)));
    }
    if (object.overview != null) {
      result
        ..add('overview')
        ..add(serializers.serialize(object.overview,
            specifiedType: const FullType(String)));
    }
    if (object.posterPath != null) {
      result
        ..add('posterPath')
        ..add(serializers.serialize(object.posterPath,
            specifiedType: const FullType(String)));
    }
    if (object.tmdbDetails != null) {
      result
        ..add('tmdbDetails')
        ..add(serializers.serialize(object.tmdbDetails,
            specifiedType: const FullType(TmdbMovie)));
    }

    return result;
  }

  @override
  Movie deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MovieBuilder();

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
        case 'tmdbMovieId':
          result.tmdbMovieId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'followed':
          result.followed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'overview':
          result.overview = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'posterPath':
          result.posterPath = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'jokeCount':
          result.jokeCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'firstAirDate':
          result.firstAirDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'followerCount':
          result.followerCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tmdbDetails':
          result.tmdbDetails.replace(serializers.deserialize(value,
              specifiedType: const FullType(TmdbMovie)) as TmdbMovie);
          break;
      }
    }

    return result.build();
  }
}

class _$Movie extends Movie {
  @override
  final int id;
  @override
  final String name;
  @override
  final int tmdbMovieId;
  @override
  final bool followed;
  @override
  final String overview;
  @override
  final String posterPath;
  @override
  final int jokeCount;
  @override
  final DateTime firstAirDate;
  @override
  final int followerCount;
  @override
  final TmdbMovie tmdbDetails;

  factory _$Movie([void Function(MovieBuilder) updates]) =>
      (new MovieBuilder()..update(updates)).build() as _$Movie;

  _$Movie._(
      {this.id,
      this.name,
      this.tmdbMovieId,
      this.followed,
      this.overview,
      this.posterPath,
      this.jokeCount,
      this.firstAirDate,
      this.followerCount,
      this.tmdbDetails})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Movie', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Movie', 'name');
    }
    if (tmdbMovieId == null) {
      throw new BuiltValueNullFieldError('Movie', 'tmdbMovieId');
    }
    if (jokeCount == null) {
      throw new BuiltValueNullFieldError('Movie', 'jokeCount');
    }
    if (firstAirDate == null) {
      throw new BuiltValueNullFieldError('Movie', 'firstAirDate');
    }
    if (followerCount == null) {
      throw new BuiltValueNullFieldError('Movie', 'followerCount');
    }
  }

  @override
  Movie rebuild(void Function(MovieBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$MovieBuilder toBuilder() => new _$MovieBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Movie &&
        id == other.id &&
        name == other.name &&
        tmdbMovieId == other.tmdbMovieId &&
        followed == other.followed &&
        overview == other.overview &&
        posterPath == other.posterPath &&
        jokeCount == other.jokeCount &&
        firstAirDate == other.firstAirDate &&
        followerCount == other.followerCount &&
        tmdbDetails == other.tmdbDetails;
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
                                    tmdbMovieId.hashCode),
                                followed.hashCode),
                            overview.hashCode),
                        posterPath.hashCode),
                    jokeCount.hashCode),
                firstAirDate.hashCode),
            followerCount.hashCode),
        tmdbDetails.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Movie')
          ..add('id', id)
          ..add('name', name)
          ..add('tmdbMovieId', tmdbMovieId)
          ..add('followed', followed)
          ..add('overview', overview)
          ..add('posterPath', posterPath)
          ..add('jokeCount', jokeCount)
          ..add('firstAirDate', firstAirDate)
          ..add('followerCount', followerCount)
          ..add('tmdbDetails', tmdbDetails))
        .toString();
  }
}

class _$MovieBuilder extends MovieBuilder {
  _$Movie _$v;

  @override
  int get id {
    _$this;
    return super.id;
  }

  @override
  set id(int id) {
    _$this;
    super.id = id;
  }

  @override
  String get name {
    _$this;
    return super.name;
  }

  @override
  set name(String name) {
    _$this;
    super.name = name;
  }

  @override
  int get tmdbMovieId {
    _$this;
    return super.tmdbMovieId;
  }

  @override
  set tmdbMovieId(int tmdbMovieId) {
    _$this;
    super.tmdbMovieId = tmdbMovieId;
  }

  @override
  bool get followed {
    _$this;
    return super.followed;
  }

  @override
  set followed(bool followed) {
    _$this;
    super.followed = followed;
  }

  @override
  String get overview {
    _$this;
    return super.overview;
  }

  @override
  set overview(String overview) {
    _$this;
    super.overview = overview;
  }

  @override
  String get posterPath {
    _$this;
    return super.posterPath;
  }

  @override
  set posterPath(String posterPath) {
    _$this;
    super.posterPath = posterPath;
  }

  @override
  int get jokeCount {
    _$this;
    return super.jokeCount;
  }

  @override
  set jokeCount(int jokeCount) {
    _$this;
    super.jokeCount = jokeCount;
  }

  @override
  DateTime get firstAirDate {
    _$this;
    return super.firstAirDate;
  }

  @override
  set firstAirDate(DateTime firstAirDate) {
    _$this;
    super.firstAirDate = firstAirDate;
  }

  @override
  int get followerCount {
    _$this;
    return super.followerCount;
  }

  @override
  set followerCount(int followerCount) {
    _$this;
    super.followerCount = followerCount;
  }

  @override
  TmdbMovieBuilder get tmdbDetails {
    _$this;
    return super.tmdbDetails ??= new TmdbMovieBuilder();
  }

  @override
  set tmdbDetails(TmdbMovieBuilder tmdbDetails) {
    _$this;
    super.tmdbDetails = tmdbDetails;
  }

  _$MovieBuilder() : super._();

  MovieBuilder get _$this {
    if (_$v != null) {
      super.id = _$v.id;
      super.name = _$v.name;
      super.tmdbMovieId = _$v.tmdbMovieId;
      super.followed = _$v.followed;
      super.overview = _$v.overview;
      super.posterPath = _$v.posterPath;
      super.jokeCount = _$v.jokeCount;
      super.firstAirDate = _$v.firstAirDate;
      super.followerCount = _$v.followerCount;
      super.tmdbDetails = _$v.tmdbDetails?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Movie other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Movie;
  }

  @override
  void update(void Function(MovieBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Movie build() {
    _$Movie _$result;
    try {
      _$result = _$v ??
          new _$Movie._(
              id: id,
              name: name,
              tmdbMovieId: tmdbMovieId,
              followed: followed,
              overview: overview,
              posterPath: posterPath,
              jokeCount: jokeCount,
              firstAirDate: firstAirDate,
              followerCount: followerCount,
              tmdbDetails: super.tmdbDetails?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tmdbDetails';
        super.tmdbDetails?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Movie', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
