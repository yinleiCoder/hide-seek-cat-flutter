// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zcoolcreator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZcoolCreator _$ZcoolCreatorFromJson(Map<String, dynamic> json) {
  return ZcoolCreator(
    id: json['id'] as num,
    username: json['username'] as String,
    avatar: json['avatar'] as String,
    pageUrl: json['pageUrl'] as String,
    signature: json['signature'] as String,
    cityName: json['cityName'] as String,
    professionName: json['professionName'] as String,
    contentCountTips: json['contentCountTips'] as String,
    popularityCountTips: json['popularityCountTips'] as String,
    fansCountTips: json['fansCountTips'] as String,
    contentPageUrl: json['contentPageUrl'] as String,
  );
}

Map<String, dynamic> _$ZcoolCreatorToJson(ZcoolCreator instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'pageUrl': instance.pageUrl,
      'signature': instance.signature,
      'cityName': instance.cityName,
      'professionName': instance.professionName,
      'contentCountTips': instance.contentCountTips,
      'popularityCountTips': instance.popularityCountTips,
      'fansCountTips': instance.fansCountTips,
      'contentPageUrl': instance.contentPageUrl,
    };
