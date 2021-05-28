import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
/**
 * url_launcher
 * 启动外部app或浏览器
 * https://pub.dev/packages/url_launcher
 * @author yinlei
 */
void appLaunchUrl(String url) async =>
    await canLaunch(url) ? await launch(url) : appShowToast(msg: 'Could not launch $url');