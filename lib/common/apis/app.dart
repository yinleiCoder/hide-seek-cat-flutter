import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';

/**
 * App Api Network request.
 * @author yinlei
 */
class AppApi {

  /// App升级
  static Future<App> appUpdate({@required context, @required App params}) async {
    var response = await AppHttps().post('/app/update', context: context, params: params);
    return App.fromJson(response);
  }



}