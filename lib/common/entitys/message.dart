import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'message.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.

enum MessageStatus { not_sent, not_view, viewed }

@JsonSerializable(explicitToJson: true)
/***
    {
    "_id": "6060525f9e7d8836ece1fda4",
    "from": "6060211d84a042087cc61d89",
    "to": "6060210984a042087cc61d88",
    "content": "我们已经成为好友啦！",
    "type": 0,
    "state": 1,
    "createdAt": "2021-03-28T09:54:39.312Z",
    "updatedAt": "2021-03-28T09:54:39.312Z"
    },
 */
class Message {
  Message({this.msgid ,this.from ,this.to ,this.content ,this.type ,this.state ,this.createdAt ,this.updatedAt, this.messageStatus = MessageStatus.viewed, this.animationController});

  @JsonKey(name: '_id')
  String msgid;
  User from;
  User to;
  String content;
  num type;
  num state;
  String createdAt;
  String updatedAt;

  @JsonKey(ignore: true)
  MessageStatus messageStatus;
  @JsonKey(ignore: true)
  AnimationController animationController;




  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}