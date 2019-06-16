// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Comment> _$commentSerializer = new _$CommentSerializer();

class _$CommentSerializer implements StructuredSerializer<Comment> {
  @override
  final Iterable<Type> types = const [Comment, _$Comment];
  @override
  final String wireName = 'Comment';

  @override
  Iterable serialize(Serializers serializers, Comment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
    ];
    if (object.anonymousName != null) {
      result
        ..add('anonymousName')
        ..add(serializers.serialize(object.anonymousName,
            specifiedType: const FullType(String)));
    }
    if (object.owner != null) {
      result
        ..add('owner')
        ..add(serializers.serialize(object.owner,
            specifiedType: const FullType(User)));
    }
    return result;
  }

  @override
  Comment deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommentBuilder();

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
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'anonymousName':
          result.anonymousName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'owner':
          result.owner.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$Comment extends Comment {
  @override
  final int id;
  @override
  final String content;
  @override
  final String anonymousName;
  @override
  final User owner;
  @override
  final DateTime createdAt;

  factory _$Comment([void Function(CommentBuilder) updates]) =>
      (new CommentBuilder()..update(updates)).build();

  _$Comment._(
      {this.id, this.content, this.anonymousName, this.owner, this.createdAt})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Comment', 'id');
    }
    if (content == null) {
      throw new BuiltValueNullFieldError('Comment', 'content');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('Comment', 'createdAt');
    }
  }

  @override
  Comment rebuild(void Function(CommentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentBuilder toBuilder() => new CommentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
        id == other.id &&
        content == other.content &&
        anonymousName == other.anonymousName &&
        owner == other.owner &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), content.hashCode),
                anonymousName.hashCode),
            owner.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Comment')
          ..add('id', id)
          ..add('content', content)
          ..add('anonymousName', anonymousName)
          ..add('owner', owner)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class CommentBuilder implements Builder<Comment, CommentBuilder> {
  _$Comment _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  String _anonymousName;
  String get anonymousName => _$this._anonymousName;
  set anonymousName(String anonymousName) =>
      _$this._anonymousName = anonymousName;

  UserBuilder _owner;
  UserBuilder get owner => _$this._owner ??= new UserBuilder();
  set owner(UserBuilder owner) => _$this._owner = owner;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  CommentBuilder();

  CommentBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _content = _$v.content;
      _anonymousName = _$v.anonymousName;
      _owner = _$v.owner?.toBuilder();
      _createdAt = _$v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Comment other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Comment;
  }

  @override
  void update(void Function(CommentBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Comment build() {
    _$Comment _$result;
    try {
      _$result = _$v ??
          new _$Comment._(
              id: id,
              content: content,
              anonymousName: anonymousName,
              owner: _owner?.build(),
              createdAt: createdAt);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'owner';
        _owner?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Comment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
