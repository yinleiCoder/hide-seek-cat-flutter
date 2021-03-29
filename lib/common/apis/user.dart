import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';

/**
 * User Api Network request.
 * @author yinlei
 */
class UserApi {

  /// 用户登录
  static Future<Login> login({@required context, User params}) async {
    var response = await AppHttps().post('/users/login', context: context, params: {"name": params.name, "password": params.password});
    return Login.fromJson(response);
  }

  /// 新用户注册
  static Future<User> register({@required context, User params}) async {
    var response = await AppHttps().post('/users', context: context, params: params);
    return User.fromJson(response);
  }

  /// 获取特定的用户个人信息
  static Future<User> somebodyUserInfo({@required context, @required String uid}) async {
    var response = await AppHttps().get('/users/${uid}?fields=following;locations;business;employments;educations;followingTopics;likingAnswers;dislikingAnswers;collectingAnswers', context: context, );
    return User.fromJson(response);
  }

  /// 获取我和我朋友们的最新聊天消息
  static Future<List<Message>> allfriendLatestMessages({@required context, @required String uid}) async {
    var response = await AppHttps().get('/users/${uid}/allfriendsandmessages', context: context, );
    return response
        .map<Message>((item) => Message.fromJson(item))
        .toList();
  }

  /// 获取我和某个朋友的全部历史聊天记录
  static Future<List<Message>> historyChatMessages({@required context, @required String uid, @required String fid}) async {
    var response = await AppHttps().get('/users/${uid}/allmessageswithSomeone/${fid}?page=1&per_page=20&q=', context: context, );
    return response
        .map<Message>((item) => Message.fromJson(item))
        .toList();
  }


}