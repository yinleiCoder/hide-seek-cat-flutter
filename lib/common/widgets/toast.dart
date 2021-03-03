import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
/**
 * 封装toast
 * https://pub.dev/packages/fluttertoast
 * @author yinlei
 */
Future<bool> appShowToast({
  @required String msg,
  Color bgColor = AppColors.primaryColor,
  Color textColor = Colors.white,
  double fontSize = 14.0,
}) async {
  return await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP_LEFT,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: fontSize.ssp,
  );
}