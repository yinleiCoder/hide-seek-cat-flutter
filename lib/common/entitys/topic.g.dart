// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic(
    tid: json['_id'] as String,
    name: json['name'] as String,
    avatar_url: json['avatar_url'] as String,
    introduction: json['introduction'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      '_id': instance.tid,
      'name': instance.name,
      'avatar_url': instance.avatar_url,
      'introduction': instance.introduction,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
