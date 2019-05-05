// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_credit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TmdbMovieCredit> _$tmdbMovieCreditSerializer =
    new _$TmdbMovieCreditSerializer();

class _$TmdbMovieCreditSerializer
    implements StructuredSerializer<TmdbMovieCredit> {
  @override
  final Iterable<Type> types = const [TmdbMovieCredit, _$TmdbMovieCredit];
  @override
  final String wireName = 'TmdbMovieCredit';

  @override
  Iterable serialize(Serializers serializers, TmdbMovieCredit object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'cast',
      serializers.serialize(object.cast,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TmdbMovieCast)])),
    ];

    return result;
  }

  @override
  TmdbMovieCredit deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TmdbMovieCreditBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'cast':
          result.cast.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TmdbMovieCast)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$TmdbMovieCredit extends TmdbMovieCredit {
  @override
  final BuiltList<TmdbMovieCast> cast;

  factory _$TmdbMovieCredit([void Function(TmdbMovieCreditBuilder) updates]) =>
      (new TmdbMovieCreditBuilder()..update(updates)).build();

  _$TmdbMovieCredit._({this.cast}) : super._() {
    if (cast == null) {
      throw new BuiltValueNullFieldError('TmdbMovieCredit', 'cast');
    }
  }

  @override
  TmdbMovieCredit rebuild(void Function(TmdbMovieCreditBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TmdbMovieCreditBuilder toBuilder() =>
      new TmdbMovieCreditBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TmdbMovieCredit && cast == other.cast;
  }

  @override
  int get hashCode {
    return $jf($jc(0, cast.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TmdbMovieCredit')..add('cast', cast))
        .toString();
  }
}

class TmdbMovieCreditBuilder
    implements Builder<TmdbMovieCredit, TmdbMovieCreditBuilder> {
  _$TmdbMovieCredit _$v;

  ListBuilder<TmdbMovieCast> _cast;
  ListBuilder<TmdbMovieCast> get cast =>
      _$this._cast ??= new ListBuilder<TmdbMovieCast>();
  set cast(ListBuilder<TmdbMovieCast> cast) => _$this._cast = cast;

  TmdbMovieCreditBuilder();

  TmdbMovieCreditBuilder get _$this {
    if (_$v != null) {
      _cast = _$v.cast?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TmdbMovieCredit other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TmdbMovieCredit;
  }

  @override
  void update(void Function(TmdbMovieCreditBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TmdbMovieCredit build() {
    _$TmdbMovieCredit _$result;
    try {
      _$result = _$v ?? new _$TmdbMovieCredit._(cast: cast.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'cast';
        cast.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TmdbMovieCredit', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
