import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
 

  static Serializer<User> get serializer => _$userSerializer;

  String get id;
  String get username;
  @nullable
  String get photoUrl;
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

  factory User([updates(UserBuilder b)]) = _$User;
  User._();

  factory User.fromJson( Map<String, dynamic> json){

    //final parsed = json.jsonDecode(jsonString);
    User user = standardSerializers.deserializeWith(User.serializer, json);
    return user;
  }

}
