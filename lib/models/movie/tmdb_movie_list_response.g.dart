// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TmdbMovieListResponse> _$tmdbMovieListResponseSerializer =
    new _$TmdbMovieListResponseSerializer();

class _$TmdbMovieListResponseSerializer
    implements StructuredSerializer<TmdbMovieListResponse> {
  @override
  final Iterable<Type> types = const [
    TmdbMovieListResponse,
    _$TmdbMovieListResponse
  ];
  @override
  final String wireName = 'TmdbMovieListResponse';

  @override
  Iterable serialize(Serializers serializers, TmdbMovieListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'total_pages',
      serializers.serialize(object.totalPages,
          specifiedType: const FullType(int)),
      'page',
      serializers.serialize(object.currentPage,
          specifiedType: const FullType(int)),
      'results',
      serializers.serialize(object.results,
          specifiedType:
              const FullType(BuiltList, const [const FullType(TmdbMovie)])),
    ];
    if (object.perPage != null) {
      result
        ..add('perPage')
        ..add(serializers.serialize(object.perPage,
            specifiedType: const FullType(int)));
    }
    if (object.nextPage != null) {
      result
        ..add('nextPage')
        ..add(serializers.serialize(object.nextPage,
            specifiedType: const FullType(int)));
    }
    if (object.previousPage != null) {
      result
        ..add('previousPage')
        ..add(serializers.serialize(object.previousPage,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  TmdbMovieListResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TmdbMovieListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'total_pages':
          result.totalPages = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'perPage':
          result.perPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'page':
          result.currentPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'nextPage':
          result.nextPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'previousPage':
          result.previousPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'results':
          result.results.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(TmdbMovie)])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$TmdbMovieListResponse extends TmdbMovieListResponse {
  @override
  final int totalPages;
  @override
  final int perPage;
  @override
  final int currentPage;
  @override
  final int nextPage;
  @override
  final int previousPage;
  @override
  final BuiltList<TmdbMovie> results;

  factory _$TmdbMovieListResponse(
          [void Function(TmdbMovieListResponseBuilder) updates]) =>
      (new TmdbMovieListResponseBuilder()..update(updates)).build();

  _$TmdbMovieListResponse._(
      {this.totalPages,
      this.perPage,
      this.currentPage,
      this.nextPage,
      this.previousPage,
      this.results})
      : super._() {
    if (totalPages == null) {
      throw new BuiltValueNullFieldError('TmdbMovieListResponse', 'totalPages');
    }
    if (currentPage == null) {
      throw new BuiltValueNullFieldError(
          'TmdbMovieListResponse', 'currentPage');
    }
    if (results == null) {
      throw new BuiltValueNullFieldError('TmdbMovieListResponse', 'results');
    }
  }

  @override
  TmdbMovieListResponse rebuild(
          void Function(TmdbMovieListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TmdbMovieListResponseBuilder toBuilder() =>
      new TmdbMovieListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TmdbMovieListResponse &&
        totalPages == other.totalPages &&
        perPage == other.perPage &&
        currentPage == other.currentPage &&
        nextPage == other.nextPage &&
        previousPage == other.previousPage &&
        results == other.results;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, totalPages.hashCode), perPage.hashCode),
                    currentPage.hashCode),
                nextPage.hashCode),
            previousPage.hashCode),
        results.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TmdbMovieListResponse')
          ..add('totalPages', totalPages)
          ..add('perPage', perPage)
          ..add('currentPage', currentPage)
          ..add('nextPage', nextPage)
          ..add('previousPage', previousPage)
          ..add('results', results))
        .toString();
  }
}

class TmdbMovieListResponseBuilder
    implements Builder<TmdbMovieListResponse, TmdbMovieListResponseBuilder> {
  _$TmdbMovieListResponse _$v;

  int _totalPages;
  int get totalPages => _$this._totalPages;
  set totalPages(int totalPages) => _$this._totalPages = totalPages;

  int _perPage;
  int get perPage => _$this._perPage;
  set perPage(int perPage) => _$this._perPage = perPage;

  int _currentPage;
  int get currentPage => _$this._currentPage;
  set currentPage(int currentPage) => _$this._currentPage = currentPage;

  int _nextPage;
  int get nextPage => _$this._nextPage;
  set nextPage(int nextPage) => _$this._nextPage = nextPage;

  int _previousPage;
  int get previousPage => _$this._previousPage;
  set previousPage(int previousPage) => _$this._previousPage = previousPage;

  ListBuilder<TmdbMovie> _results;
  ListBuilder<TmdbMovie> get results =>
      _$this._results ??= new ListBuilder<TmdbMovie>();
  set results(ListBuilder<TmdbMovie> results) => _$this._results = results;

  TmdbMovieListResponseBuilder();

  TmdbMovieListResponseBuilder get _$this {
    if (_$v != null) {
      _totalPages = _$v.totalPages;
      _perPage = _$v.perPage;
      _currentPage = _$v.currentPage;
      _nextPage = _$v.nextPage;
      _previousPage = _$v.previousPage;
      _results = _$v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TmdbMovieListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TmdbMovieListResponse;
  }

  @override
  void update(void Function(TmdbMovieListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TmdbMovieListResponse build() {
    _$TmdbMovieListResponse _$result;
    try {
      _$result = _$v ??
          new _$TmdbMovieListResponse._(
              totalPages: totalPages,
              perPage: perPage,
              currentPage: currentPage,
              nextPage: nextPage,
              previousPage: previousPage,
              results: results.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'results';
        results.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TmdbMovieListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
