import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'app.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

class App {
  App({@required this.device, this.channel, this.architecture, this.model, this.shopUrl, this.fileUrl, this.latestVersion, this.latestDescription,});

  @JsonKey(required: true)
  String device;

  String channel;
  String architecture;
  String model;
  String shopUrl;
  String fileUrl;
  String latestVersion;
  String latestDescription;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory App.fromJson(Map<String, dynamic> json) => _$AppFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AppToJson(this);
}