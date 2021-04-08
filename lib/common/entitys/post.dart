import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'post.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
/***
    {
    "topics": [
    {
    "_id": "6038495765d4da0d705100bc",
    "name": "美女话题",
    "avatar_url": "https://img.zcool.cn/community/012030603736b111013f3745117ac8.jpg@1280w_1l_2o_100sh.jpg"
    },
    {
    "_id": "603855b7ed367a33ac4f0900",
    "name": "绵阳"
    }
    ],
    "_id": "603884f118b59a22b49550f7",
    "title": "这是我的第一条帖子",
    "poster": {
    "avatar_url": "http://localhost:3000/uploads/upload_8e1a25e55e136db4ab832135b55014e4.jpg",
    "gender": "male",
    "headline": "我是尹磊，躲猫猫作者啊",
    "_id": "60376d77dd47df35b0d3a71b",
    "name": "尹磊",
    "updatedAt": "2021-03-02T13:53:44.440Z"
    },
    "description": "我爱王可尔!"
    },
 */
class Post {
  Post({this.pid, this.poster, this.title, this.url, this.description, this.topics, this.createdAt, this.updatedAt});

  @JsonKey(name: '_id')
  String pid;

  User poster;

  String title;
  String description;
  String url;
  List<Topic> topics;
  String createdAt;
  String updatedAt;
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PostToJson(this);
}