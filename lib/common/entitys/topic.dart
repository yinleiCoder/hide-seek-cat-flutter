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
    "_id": "6038495765d4da0d705100bc",
    "name": "美女话题",
    "avatar_url": "https://img.zcool.cn/community/012030603736b111013f3745117ac8.jpg@1280w_1l_2o_100sh.jpg"
    },
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