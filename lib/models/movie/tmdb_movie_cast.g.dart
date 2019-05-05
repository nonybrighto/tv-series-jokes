// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_cast.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TmdbMovieCast> _$tmdbMovieCastSerializer =
    new _$TmdbMovieCastSerializer();

class _$TmdbMovieCastSerializer implements StructuredSerializer<TmdbMovieCast> {
  @override
  final Iterable<Type> types = const [TmdbMovieCast, _$TmdbMovieCast];
  @override
  final String wireName = 'TmdbMovieCast';

  @override
  Iterable serialize(Serializers serializers, TmdbMovieCast object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    if (object.character != null) {
      result
        ..add('character')
        ..add(serializers.serialize(object.character,
            specifiedType: const FullType(String)));
    }
    if (object.profilePath != null) {
      result
        ..add('profile_path')
        ..add(serializers.serialize(object.profilePath,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  TmdbMovieCast deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TmdbMovieCastBuilder();

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
        case 'character':
          result.character = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'profile_path':
          result.profilePath = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TmdbMovieCast extends TmdbMovieCast {
  @override
  final int id;
  @override
  final String character;
  @override
  final String name;
  @override
  final String profilePath;

  factory _$TmdbMovieCast([void Function(TmdbMovieCastBuilder) updates]) =>
      (new TmdbMovieCastBuilder()..update(updates)).build();

  _$TmdbMovieCast._({this.id, this.character, this.name, this.profilePath})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('TmdbMovieCast', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('TmdbMovieCast', 'name');
    }
  }

  @override
  TmdbMovieCast rebuild(void Function(TmdbMovieCastBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TmdbMovieCastBuilder toBuilder() => new TmdbMovieCastBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TmdbMovieCast &&
        id == other.id &&
        character == other.character &&
        name == other.name &&
        profilePath == other.profilePath;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), character.hashCode), name.hashCode),
        profilePath.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TmdbMovieCast')
          ..add('id', id)
          ..add('character', character)
          ..add('name', name)
          ..add('profilePath', profilePath))
        .toString();
  }
}

class TmdbMovieCastBuilder
    implements Builder<TmdbMovieCast, TmdbMovieCastBuilder> {
  _$TmdbMovieCast _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _character;
  String get character => _$this._character;
  set character(String character) => _$this._character = character;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _profilePath;
  String get profilePath => _$this._profilePath;
  set profilePath(String profilePath) => _$this._profilePath = profilePath;

  TmdbMovieCastBuilder();

  TmdbMovieCastBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _character = _$v.character;
      _name = _$v.name;
      _profilePath = _$v.profilePath;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TmdbMovieCast other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TmdbMovieCast;
  }

  @override
  void update(void Function(TmdbMovieCastBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TmdbMovieCast build() {
    final _$result = _$v ??
        new _$TmdbMovieCast._(
            id: id, character: character, name: name, profilePath: profilePath);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
