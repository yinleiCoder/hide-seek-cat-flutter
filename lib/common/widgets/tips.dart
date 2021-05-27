import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 躲猫猫官方tips
 * @author yinlei
 */
Widget YlTips({@required String tipContent}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.6),
      borderRadius: BorderRadius.circular(6.r),
    ),
    child: Text(
      tipContent,
      style: TextStyle(color: Colors.white, fontFamily: 'YinLei'),
    ),
  );
}