// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

App _$AppFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['device']);
  return App(
    device: json['device'] as String,
    channel: json['channel'] as String,
    architecture: json['architecture'] as String,
    model: json['model'] as String,
    shopUrl: json['shopUrl'] as String,
    fileUrl: json['fileUrl'] as String,
    latestVersion: json['latestVersion'] as String,
    latestDescription: json['latestDescription'] as String,
  );
}

Map<String, dynamic> _$AppToJson(App instance) => <String, dynamic>{
      'device': instance.device,
      'channel': instance.channel,
      'architecture': instance.architecture,
      'model': instance.model,
      'shopUrl': instance.shopUrl,
      'fileUrl': instance.fileUrl,
      'latestVersion': instance.latestVersion,
      'latestDescription': instance.latestDescription,
    };
