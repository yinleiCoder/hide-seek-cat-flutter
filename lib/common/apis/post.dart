import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';

/**
 * Post Api Network request.
 * @author yinlei
 */
class PostApi {

  /// 获取全部用户发布的帖子
  static Future<List<Post>> allUsersPosts({@required context}) async {
    var response = await AppHttps().get('/posts?page=1&per_page=20&q=', context: context, );
    return response
        .map<Post>((item) => Post.fromJson(item))
        .toList();
  }

  /// 获取某话题下的全部帖子列表
  static Future<List<Post>> allPostsOfSomeonTopic({@required context, @required String tid}) async {
    var response = await AppHttps().get('/topics/${tid}/posts', context: context, );
    return response
        .map<Post>((item) => Post.fromJson(item))
        .toList();
  }

  /// 获取前3个精选话题或全部话题
  static Future<List<Topic>> allUsersTopics({@required context, num page = 1,num per_page = 20, String q=''}) async {
    var response = await AppHttps().get('/topics?page=${page}&per_page=${per_page}&q=${q}', context: context, );
    return response
        .map<Topic>((item) => Topic.fromJson(item))
        .toList();
  }

  /// 获取某个特定的话题
  static Future<Topic> someoneTopic({@required context, @required String tid = ''}) async {
    var response = await AppHttps().get('/topics/${tid}?fields=introduction;', context: context, );
    return Topic.fromJson(response);
  }

  /// 发布帖子
  static Future<void> publishPost({@required context, dynamic params}) async {
    await AppHttps().postFormData('/posts', context: context, params: params);
    // await AppHttps().postFormData('/upload', context: context, params: params);
    // return Post.fromJson(response);
  }

}