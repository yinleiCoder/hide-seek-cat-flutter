import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_screenutil/size_extension.dart';

/**
 * 考编学习页
 * @author yinlei
 */
class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('${AppGlobal.profile.user.uid}'),
        ],
      )
    );
  }
}
