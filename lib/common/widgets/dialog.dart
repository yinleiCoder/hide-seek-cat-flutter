import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'dart:math' as math;
/**
 * AlertDialog
 * @author yinlei
*/
Future appShowConfirmDialog({
  @required BuildContext context,
  @required VoidCallback onPressed,
  @required VoidCallback cancelPressed,
  App app,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: Text('发现新版本${app.latestVersion}'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(app.latestDescription),
            SizedBox(height: 15.h,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Transform.rotate(
                angle: math.pi / 11.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                    child: Image.network('https://img.zcool.cn/community/0124445f1058a7a801206621ed7f26.jpg@3000w_1l_0o_100sh.jpg', height: 200.h, fit: BoxFit.cover,)),
              ),
            ),
            Text('系统：${app.device}'),
            Text('渠道：${app.channel}'),
            Text('CPU架构：${app.architecture}'),
            Text('机型：${app.model}'),
          ],
        ),
      ),
      actions: [
          OutlinedButton(
            child: Text('升级'),
            onPressed: onPressed,
          ),
          TextButton(
            child: Text('忽略'),
            onPressed: cancelPressed,
          ),
      ],
      shape: BeveledRectangleBorder(),
      elevation: 24.0,
    ),
  );
}