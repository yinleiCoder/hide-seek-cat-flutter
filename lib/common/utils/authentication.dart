import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/login.dart';
/**
 * 授权登录、注销登录
 * @author yinlei
*/
/// 检查是否授权
Future<bool> isAuthenticated() async {
  var profileJSON = AppStorage().getJSON(STORAGE_USER_PROFILE_KEY);
  return profileJSON != null ? true : false;
}

/// 注销登录
Future deleteAuthentication() async {
  await AppStorage().remove(STORAGE_USER_PROFILE_KEY);
  AppGlobal.profile.user = null;
}

/// 注销登录并去登录
Future goLoginPage(BuildContext context) async {
  await deleteAuthentication();
  Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
}
