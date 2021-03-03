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
    await AppHttps().get('/', context: context);
    var response = await AppHttps().post('/users/login', context: context, params: params);
    return Login.fromJson(response);
  }


}