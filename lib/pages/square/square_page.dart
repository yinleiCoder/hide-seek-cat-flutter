import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/providers/provider.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:provider/provider.dart';

/***
 * 广场页
 * @author yinlei
 */
class SquarePage extends StatefulWidget {
  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('广场:${AppGlobal.profile.user?.name} ${AppGlobal.profile.token}'),
          MaterialButton(
            child: Text('注销'),
            onPressed: () => goLoginPage(context),
          ),
        ],
      ),
    );
  }
}
