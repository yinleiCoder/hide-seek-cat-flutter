// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employment _$EmploymentFromJson(Map<String, dynamic> json) {
  return Employment(
    company: json['company'] == null
        ? null
        : Topic.fromJson(json['company'] as Map<String, dynamic>),
    job: json['job'] == null
        ? null
        : Topic.fromJson(json['job'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EmploymentToJson(Employment instance) =>
    <String, dynamic>{
      'company': instance.company?.toJson(),
      'job': instance.job?.toJson(),
    };
