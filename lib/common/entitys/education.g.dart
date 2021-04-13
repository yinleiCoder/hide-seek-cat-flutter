// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Education _$EducationFromJson(Map<String, dynamic> json) {
  return Education(
    school: json['school'] == null
        ? null
        : Topic.fromJson(json['school'] as Map<String, dynamic>),
    major: json['major'] == null
        ? null
        : Topic.fromJson(json['major'] as Map<String, dynamic>),
    diploma: json['diploma'] as num,
    entrance_year: json['entrance_year'] as num,
    graduation_year: json['graduation_year'] as num,
  );
}

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
      'school': instance.school?.toJson(),
      'major': instance.major?.toJson(),
      'diploma': instance.diploma,
      'entrance_year': instance.entrance_year,
      'graduation_year': instance.graduation_year,
    };
