import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/application/application.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/login.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/register.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/signin_page.dart';
import 'package:flutter_hide_seek_cat/pages/welcome/welcome_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    /// 初始化Flutter屏幕适配:
    /// https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_CN.md
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      designSize: Size(375, 812),
      allowFontScaling: true,
    );
    return Scaffold(
      body: AppGlobal.isFirstOpen == true ? WelcomePage() : (
        AppGlobal.isOfflineLogin == true ? ApplicationPage() : SignInPage()
      ),
    );
  }
}
