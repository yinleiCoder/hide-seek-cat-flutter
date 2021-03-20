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



}