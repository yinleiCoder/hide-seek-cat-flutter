// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    msgid: json['_id'] as String,
    from: json['from'] == null
        ? null
        : User.fromJson(json['from'] as Map<String, dynamic>),
    to: json['to'] == null
        ? null
        : User.fromJson(json['to'] as Map<String, dynamic>),
    content: json['content'] as String,
    type: json['type'] as num,
    state: json['state'] as num,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      '_id': instance.msgid,
      'from': instance.from?.toJson(),
      'to': instance.to?.toJson(),
      'content': instance.content,
      'type': instance.type,
      'state': instance.state,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
