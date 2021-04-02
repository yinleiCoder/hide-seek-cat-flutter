import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'topic.g.dart';
@JsonSerializable(explicitToJson: true)
/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
/***
    {
    "_id": "6060242384a042087cc61d8c",
    "name": "绵阳",
    "avatar_url": "https://img.zcool.cn/community/0149205f2bc83ba801215aa05e028c.jpg@3000w_1l_0o_100sh.jpg",
    "createdAt": "2021-03-28T06:37:23.492Z",
    "updatedAt": "2021-03-28T06:37:23.492Z"
    }
 */
class Topic {
  Topic({this.tid, this.name, this.avatar_url, this.introduction, this.createdAt, this.updatedAt,});

  @JsonKey(name: '_id')
  String tid;

  String name;
  String avatar_url;
  String introduction;
  String createdAt;
  String updatedAt;
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}