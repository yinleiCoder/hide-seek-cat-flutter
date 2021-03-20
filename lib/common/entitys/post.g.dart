// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    pid: json['_id'] as String,
    poster: json['poster'] == null
        ? null
        : User.fromJson(json['poster'] as Map<String, dynamic>),
    title: json['title'] as String,
    description: json['description'] as String,
    topics: (json['topics'] as List)
        ?.map(
            (e) => e == null ? null : Topic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      '_id': instance.pid,
      'poster': instance.poster?.toJson(),
      'title': instance.title,
      'description': instance.description,
      'topics': instance.topics?.map((e) => e?.toJson())?.toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
