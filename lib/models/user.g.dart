// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<User> _$userSerializer = new _$UserSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
    ];
    if (object.profilePhoto != null) {
      result
        ..add('profilePhoto')
        ..add(serializers.serialize(object.profilePhoto,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.jokeCount != null) {
      result
        ..add('jokeCount')
        ..add(serializers.serialize(object.jokeCount,
            specifiedType: const FullType(int)));
    }
    if (object.following != null) {
      result
        ..add('following')
        ..add(serializers.serialize(object.following,
            specifiedType: const FullType(bool)));
    }
    if (object.followed != null) {
      result
        ..add('followed')
        ..add(serializers.serialize(object.followed,
            specifiedType: const FullType(bool)));
    }
    if (object.followerCount != null) {
      result
        ..add('followerCount')
        ..add(serializers.serialize(object.followerCount,
            specifiedType: const FullType(int)));
    }
    if (object.followingCount != null) {
      result
        ..add('followingCount')
        ..add(serializers.serialize(object.followingCount,
            specifiedType: const FullType(int)));
    }
    if (object.isAdmin != null) {
      result
        ..add('isAdmin')
        ..add(serializers.serialize(object.isAdmin,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

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
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'profilePhoto':
          result.profilePhoto = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'jokeCount':
          result.jokeCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'following':
          result.following = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'followed':
          result.followed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'followerCount':
          result.followerCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'followingCount':
          result.followingCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'isAdmin':
          result.isAdmin = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$User extends User {
  @override
  final int id;
  @override
  final String username;
  @override
  final String profilePhoto;
  @override
  final String email;
  @override
  final int jokeCount;
  @override
  final bool following;
  @override
  final bool followed;
  @override
  final int followerCount;
  @override
  final int followingCount;
  @override
  final bool isAdmin;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build() as _$User;

  _$User._(
      {this.id,
      this.username,
      this.profilePhoto,
      this.email,
      this.jokeCount,
      this.following,
      this.followed,
      this.followerCount,
      this.followingCount,
      this.isAdmin})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('User', 'id');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('User', 'username');
    }
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$UserBuilder toBuilder() => new _$UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        username == other.username &&
        profilePhoto == other.profilePhoto &&
        email == other.email &&
        jokeCount == other.jokeCount &&
        following == other.following &&
        followed == other.followed &&
        followerCount == other.followerCount &&
        followingCount == other.followingCount &&
        isAdmin == other.isAdmin;
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
                                $jc($jc($jc(0, id.hashCode), username.hashCode),
                                    profilePhoto.hashCode),
                                email.hashCode),
                            jokeCount.hashCode),
                        following.hashCode),
                    followed.hashCode),
                followerCount.hashCode),
            followingCount.hashCode),
        isAdmin.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('id', id)
          ..add('username', username)
          ..add('profilePhoto', profilePhoto)
          ..add('email', email)
          ..add('jokeCount', jokeCount)
          ..add('following', following)
          ..add('followed', followed)
          ..add('followerCount', followerCount)
          ..add('followingCount', followingCount)
          ..add('isAdmin', isAdmin))
        .toString();
  }
}

class _$UserBuilder extends UserBuilder {
  _$User _$v;

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
  String get username {
    _$this;
    return super.username;
  }

  @override
  set username(String username) {
    _$this;
    super.username = username;
  }

  @override
  String get profilePhoto {
    _$this;
    return super.profilePhoto;
  }

  @override
  set profilePhoto(String profilePhoto) {
    _$this;
    super.profilePhoto = profilePhoto;
  }

  @override
  String get email {
    _$this;
    return super.email;
  }

  @override
  set email(String email) {
    _$this;
    super.email = email;
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
  bool get following {
    _$this;
    return super.following;
  }

  @override
  set following(bool following) {
    _$this;
    super.following = following;
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
  int get followingCount {
    _$this;
    return super.followingCount;
  }

  @override
  set followingCount(int followingCount) {
    _$this;
    super.followingCount = followingCount;
  }

  @override
  bool get isAdmin {
    _$this;
    return super.isAdmin;
  }

  @override
  set isAdmin(bool isAdmin) {
    _$this;
    super.isAdmin = isAdmin;
  }

  _$UserBuilder() : super._();

  UserBuilder get _$this {
    if (_$v != null) {
      super.id = _$v.id;
      super.username = _$v.username;
      super.profilePhoto = _$v.profilePhoto;
      super.email = _$v.email;
      super.jokeCount = _$v.jokeCount;
      super.following = _$v.following;
      super.followed = _$v.followed;
      super.followerCount = _$v.followerCount;
      super.followingCount = _$v.followingCount;
      super.isAdmin = _$v.isAdmin;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ??
        new _$User._(
            id: id,
            username: username,
            profilePhoto: profilePhoto,
            email: email,
            jokeCount: jokeCount,
            following: following,
            followed: followed,
            followerCount: followerCount,
            followingCount: followingCount,
            isAdmin: isAdmin);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
