// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Joke> _$jokeSerializer = new _$JokeSerializer();

class _$JokeSerializer implements StructuredSerializer<Joke> {
  @override
  final Iterable<Type> types = const [Joke, _$Joke];
  @override
  final String wireName = 'Joke';

  @override
  Iterable serialize(Serializers serializers, Joke object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'commentCount',
      serializers.serialize(object.commentCount,
          specifiedType: const FullType(int)),
      'liked',
      serializers.serialize(object.liked, specifiedType: const FullType(bool)),
      'favorited',
      serializers.serialize(object.favorited,
          specifiedType: const FullType(bool)),
    ];
    if (object.text != null) {
      result
        ..add('text')
        ..add(serializers.serialize(object.text,
            specifiedType: const FullType(String)));
    }
    if (object.dateAdded != null) {
      result
        ..add('dateAdded')
        ..add(serializers.serialize(object.dateAdded,
            specifiedType: const FullType(DateTime)));
    }
    if (object.likeCount != null) {
      result
        ..add('likeCount')
        ..add(serializers.serialize(object.likeCount,
            specifiedType: const FullType(int)));
    }
    if (object.movie != null) {
      result
        ..add('movie')
        ..add(serializers.serialize(object.movie,
            specifiedType: const FullType(Movie)));
    }
    if (object.owner != null) {
      result
        ..add('owner')
        ..add(serializers.serialize(object.owner,
            specifiedType: const FullType(User)));
    }
    if (object.imageUrl != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(object.imageUrl,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Joke deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new JokeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'commentCount':
          result.commentCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'dateAdded':
          result.dateAdded = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'likeCount':
          result.likeCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'liked':
          result.liked = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'favorited':
          result.favorited = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'movie':
          result.movie.replace(serializers.deserialize(value,
              specifiedType: const FullType(Movie)) as Movie);
          break;
        case 'owner':
          result.owner.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Joke extends Joke {
  @override
  final String id;
  @override
  final String title;
  @override
  final String text;
  @override
  final int commentCount;
  @override
  final DateTime dateAdded;
  @override
  final int likeCount;
  @override
  final bool liked;
  @override
  final bool favorited;
  @override
  final Movie movie;
  @override
  final User owner;
  @override
  final String imageUrl;

  factory _$Joke([void Function(JokeBuilder) updates]) =>
      (new JokeBuilder()..update(updates)).build();

  _$Joke._(
      {this.id,
      this.title,
      this.text,
      this.commentCount,
      this.dateAdded,
      this.likeCount,
      this.liked,
      this.favorited,
      this.movie,
      this.owner,
      this.imageUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Joke', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Joke', 'title');
    }
    if (commentCount == null) {
      throw new BuiltValueNullFieldError('Joke', 'commentCount');
    }
    if (liked == null) {
      throw new BuiltValueNullFieldError('Joke', 'liked');
    }
    if (favorited == null) {
      throw new BuiltValueNullFieldError('Joke', 'favorited');
    }
  }

  @override
  Joke rebuild(void Function(JokeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JokeBuilder toBuilder() => new JokeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Joke &&
        id == other.id &&
        title == other.title &&
        text == other.text &&
        commentCount == other.commentCount &&
        dateAdded == other.dateAdded &&
        likeCount == other.likeCount &&
        liked == other.liked &&
        favorited == other.favorited &&
        movie == other.movie &&
        owner == other.owner &&
        imageUrl == other.imageUrl;
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
                                $jc(
                                    $jc(
                                        $jc($jc(0, id.hashCode),
                                            title.hashCode),
                                        text.hashCode),
                                    commentCount.hashCode),
                                dateAdded.hashCode),
                            likeCount.hashCode),
                        liked.hashCode),
                    favorited.hashCode),
                movie.hashCode),
            owner.hashCode),
        imageUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Joke')
          ..add('id', id)
          ..add('title', title)
          ..add('text', text)
          ..add('commentCount', commentCount)
          ..add('dateAdded', dateAdded)
          ..add('likeCount', likeCount)
          ..add('liked', liked)
          ..add('favorited', favorited)
          ..add('movie', movie)
          ..add('owner', owner)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class JokeBuilder implements Builder<Joke, JokeBuilder> {
  _$Joke _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  int _commentCount;
  int get commentCount => _$this._commentCount;
  set commentCount(int commentCount) => _$this._commentCount = commentCount;

  DateTime _dateAdded;
  DateTime get dateAdded => _$this._dateAdded;
  set dateAdded(DateTime dateAdded) => _$this._dateAdded = dateAdded;

  int _likeCount;
  int get likeCount => _$this._likeCount;
  set likeCount(int likeCount) => _$this._likeCount = likeCount;

  bool _liked;
  bool get liked => _$this._liked;
  set liked(bool liked) => _$this._liked = liked;

  bool _favorited;
  bool get favorited => _$this._favorited;
  set favorited(bool favorited) => _$this._favorited = favorited;

  MovieBuilder _movie;
  MovieBuilder get movie => _$this._movie ??= new MovieBuilder();
  set movie(MovieBuilder movie) => _$this._movie = movie;

  UserBuilder _owner;
  UserBuilder get owner => _$this._owner ??= new UserBuilder();
  set owner(UserBuilder owner) => _$this._owner = owner;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  JokeBuilder();

  JokeBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _text = _$v.text;
      _commentCount = _$v.commentCount;
      _dateAdded = _$v.dateAdded;
      _likeCount = _$v.likeCount;
      _liked = _$v.liked;
      _favorited = _$v.favorited;
      _movie = _$v.movie?.toBuilder();
      _owner = _$v.owner?.toBuilder();
      _imageUrl = _$v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Joke other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Joke;
  }

  @override
  void update(void Function(JokeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Joke build() {
    _$Joke _$result;
    try {
      _$result = _$v ??
          new _$Joke._(
              id: id,
              title: title,
              text: text,
              commentCount: commentCount,
              dateAdded: dateAdded,
              likeCount: likeCount,
              liked: liked,
              favorited: favorited,
              movie: _movie?.build(),
              owner: _owner?.build(),
              imageUrl: imageUrl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'movie';
        _movie?.build();
        _$failedField = 'owner';
        _owner?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Joke', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
