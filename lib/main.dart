import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/providers/provider.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/index/index.dart';
import 'package:flutter_hide_seek_cat/routes.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:provider/provider.dart';

/**
 * 躲猫猫APP
 * 一款专门为年轻人打造的社交APP
 * @author yinlei.
 * @description Created by 尹磊 on 2021/02/27
 * @code https://github.com/yinleiCoder/hide-seek-cat-flutter
 */

void main() => AppGlobal.init().then((e) => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserModel(),
      ),
      // ChangeNotifierProvider.value(value: null)
    ],
    child: MyApp(),
  ),
));


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '躲猫猫',
      debugShowCheckedModeBanner: false,
      // onUnknownRoute: ,
      theme: ThemeData(
        // fontFamily: 'Yinlei'
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        primaryColorDark: AppColors.primaryColor,
        accentColor: AppColors.primaryColor,
        brightness: Brightness.dark,
      ),
      routes: ylRoutes,
      home: IndexPage(),
    );
  }
}



