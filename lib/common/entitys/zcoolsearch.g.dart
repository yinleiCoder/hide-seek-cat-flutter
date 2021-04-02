// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zcoolsearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZcoolSearch _$ZcoolSearchFromJson(Map<String, dynamic> json) {
  return ZcoolSearch(
    id: json['id'] as num,
    cover: json['cover'] as String,
    title: json['title'] as String,
    cateStr: json['cateStr'] as String,
    subCateStr: json['subCateStr'] as String,
    publishTimeDiffStr: json['publishTimeDiffStr'] as String,
    viewCountStr: json['viewCountStr'] as String,
    recommendCountStr: json['recommendCountStr'] as String,
    creatorObj: json['creatorObj'] == null
        ? null
        : ZcoolCreator.fromJson(json['creatorObj'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ZcoolSearchToJson(ZcoolSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cover': instance.cover,
      'title': instance.title,
      'cateStr': instance.cateStr,
      'subCateStr': instance.subCateStr,
      'publishTimeDiffStr': instance.publishTimeDiffStr,
      'viewCountStr': instance.viewCountStr,
      'recommendCountStr': instance.recommendCountStr,
      'creatorObj': instance.creatorObj?.toJson(),
    };
