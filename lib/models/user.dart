import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
 

  static Serializer<User> get serializer => _$userSerializer;

  int get id;
  String get username;
  @nullable
  String get profilePhoto;
  @nullable
  String get email;
  @nullable
  int get jokeCount;
  @nullable
  bool get following;
  @nullable
  bool get followed;
  @nullable
  int get followerCount;
  @nullable
  int get followingCount;
  @nullable
  bool get isAdmin;

  factory User([updates(UserBuilder b)]) = _$User;
  User._();

  factory User.fromJson( Map<String, dynamic> json){

    //final parsed = json.jsonDecode(jsonString);
    User user = standardSerializers.deserializeWith(User.serializer, json);
    return user;
  }

}

abstract class UserBuilder
    implements Builder<User, UserBuilder> {

 int id;
  String username;
  @nullable
  String profilePhoto;
  @nullable
  String email;
  @nullable
  int jokeCount;
  @nullable
  bool following = false;
  @nullable
  bool followed = false;
  @nullable
  int followerCount;
  @nullable
  int followingCount;
  @nullable
  bool isAdmin = false;

  factory UserBuilder() = _$UserBuilder;
  UserBuilder._();
}