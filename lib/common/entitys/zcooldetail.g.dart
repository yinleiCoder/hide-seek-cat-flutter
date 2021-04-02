// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zcooldetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZcoolDetail _$ZcoolDetailFromJson(Map<String, dynamic> json) {
  return ZcoolDetail(
    id: json['id'] as num,
    title: json['title'] as String,
    cover: json['cover'] as String,
    description: json['description'] as String,
    productTags:
        (json['productTags'] as List)?.map((e) => e as String)?.toList(),
    creatorObj: json['creatorObj'] == null
        ? null
        : ZcoolCreator.fromJson(json['creatorObj'] as Map<String, dynamic>),
    allImageList:
        (json['allImageList'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ZcoolDetailToJson(ZcoolDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover': instance.cover,
      'description': instance.description,
      'productTags': instance.productTags,
      'creatorObj': instance.creatorObj?.toJson(),
      'allImageList': instance.allImageList,
    };
