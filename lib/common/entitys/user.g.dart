// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['name']);
  return User(
    uid: json['_id'] as String,
    name: json['name'] as String,
    password: json['password'] as String,
    gender: json['gender'] as String,
    locations: (json['locations'] as List)
        ?.map(
            (e) => e == null ? null : Topic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    business: json['business'] == null
        ? null
        : Topic.fromJson(json['business'] as Map<String, dynamic>),
    following: (json['following'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    followingTopics: (json['followingTopics'] as List)
        ?.map(
            (e) => e == null ? null : Topic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    likingAnswers:
        (json['likingAnswers'] as List)?.map((e) => e as String)?.toList(),
    dislikingAnswers:
        (json['dislikingAnswers'] as List)?.map((e) => e as String)?.toList(),
    collectingAnswers:
        (json['collectingAnswers'] as List)?.map((e) => e as String)?.toList(),
    employments: (json['employments'] as List)
        ?.map((e) =>
            e == null ? null : Employment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    educations: (json['educations'] as List)
        ?.map((e) =>
            e == null ? null : Education.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    headline: json['headline'] as String,
    avatar_url: json['avatar_url'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.uid,
      'gender': instance.gender,
      'locations': instance.locations?.map((e) => e?.toJson())?.toList(),
      'business': instance.business?.toJson(),
      'following': instance.following?.map((e) => e?.toJson())?.toList(),
      'followingTopics':
          instance.followingTopics?.map((e) => e?.toJson())?.toList(),
      'likingAnswers': instance.likingAnswers,
      'dislikingAnswers': instance.dislikingAnswers,
      'collectingAnswers': instance.collectingAnswers,
      'employments': instance.employments?.map((e) => e?.toJson())?.toList(),
      'educations': instance.educations?.map((e) => e?.toJson())?.toList(),
      'headline': instance.headline,
      'avatar_url': instance.avatar_url,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'password': instance.password,
    };
