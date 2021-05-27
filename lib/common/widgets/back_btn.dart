import 'package:flutter/material.dart';
/**
 * 返回上一界面按钮
 * @author yinlei
*/
Widget YlBackButton(context) {
  return IconButton(
    icon: Icon(Icons.arrow_drop_down_circle_rounded, color: Colors.white,),
    onPressed: () => Navigator.pop(context),
  );
}
