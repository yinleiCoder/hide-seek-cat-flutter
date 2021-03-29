import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
/***
 * {
    "gender": "male",
    "locations": [
    {
    "_id": "603855b7ed367a33ac4f0900",
    "name": "绵阳"
    },
    {
    "_id": "603855bded367a33ac4f0901",
    "name": "乐山"
    }
    ],
    "following": [
    {
    "gender": "male",
    "_id": "60376a080dd1bd090853bcd2",
    "name": "尹伟"
    }
    ],
    "followingTopics": [
    {
    "_id": "6038495765d4da0d705100bc",
    "name": "美女话题",
    "avatar_url": "https://img.zcool.cn/community/012030603736b111013f3745117ac8.jpg@1280w_1l_2o_100sh.jpg"
    }
    ],
    "likingAnswers": [],
    "dislikingAnswers": [],
    "collectingAnswers": [],
    "_id": "60376d77dd47df35b0d3a71b",
    "name": "尹磊",
    "avatar_url": "http://localhost:3000/uploads/upload_8e1a25e55e136db4ab832135b55014e4.jpg",
    "business": {
    "_id": "603855c5ed367a33ac4f0902",
    "name": "计算机IT"
    },
    "educations": [
    {
    "_id": "603e4368efb2bd37b8a2323c",
    "school": {
    "_id": "603855e0ed367a33ac4f0905",
    "name": "四川大学锦江学院"
    },
    "major": {
    "_id": "603855e8ed367a33ac4f0906",
    "name": "软件工程"
    },
    "diploma": 3,
    "entrance_year": 2017,
    "graduation_year": 2021
    }
    ],
    "employments": [
    {
    "_id": "603e4368efb2bd37b8a2323b",
    "company": {
    "_id": "603855d4ed367a33ac4f0903",
    "name": "中国联合网络通信有限公司绵阳市分公司"
    },
    "job": {
    "_id": "603855daed367a33ac4f0904",
    "name": "数据分析工程师"
    }
    }
    ],
    "headline": "我是尹磊，躲猫猫作者啊",
    "updatedAt": "2021-03-02T13:53:44.440Z"
    }
 */
class User {
  User({this.uid, this.name, this.password,this.gender = 'male', this.locations, this.following, this.followingTopics, this.likingAnswers, this.dislikingAnswers, this.collectingAnswers, this.employments, this.educations, this.headline, this.avatar_url, this.createdAt, this.updatedAt,});

  @JsonKey(name: '_id')
  String uid;

  String gender;
  List<String> locations;
  List<User> following;
  List<Topic> followingTopics;
  List<String> likingAnswers;
  List<String> dislikingAnswers;
  List<String> collectingAnswers;
  List<String> employments;
  List<String> educations;
  String headline;
  String avatar_url;
  String createdAt;
  String updatedAt;


  @JsonKey(required: true)
  String name;

  String password;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}