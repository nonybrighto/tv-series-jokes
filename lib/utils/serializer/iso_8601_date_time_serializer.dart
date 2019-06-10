import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

class Iso8601DateTimeSerializer implements PrimitiveSerializer<DateTime> {
  final bool structured = false;
  @override
  final Iterable<Type> types = BuiltList<Type>([DateTime]);
  @override
  final String wireName = 'DateTime';

  @override
  Object serialize(Serializers serializers, DateTime dateTime,
      {FullType specifiedType = FullType.unspecified}) {
    if (!dateTime.isUtc) {
      throw ArgumentError.value(
          dateTime, 'dateTime', 'Must be in utc for serialization.');
    }

    return dateTime.toIso8601String();
  }

  @override
  DateTime deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
        //This is the only addition made from the original in built_value library
        //used to retun null date wehn tmdb gives an empty string date
      if((serialized as String).isEmpty) return null;
    return DateTime.parse(serialized as String).toUtc();
  }
}