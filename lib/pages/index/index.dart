import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/application/application.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/signin_page.dart';
import 'package:flutter_hide_seek_cat/pages/welcome/welcome_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  @override
  void initState() {
    super.initState();
    /// check app version and upgrade
    // if(AppGlobal.isRelease) {
      checkAppUpdateAndRequestPermission();
    // }
  }

  /// check app version and upgrade
  Future checkAppUpdateAndRequestPermission() async {
    await Future.delayed(Duration(seconds: 3), () async {
      if(AppGlobal.isAndroid && await Permission.storage.isGranted == false) {
        await [Permission.storage].request();
      }
      if(await Permission.storage.isGranted) {
        AppUpdate().run(context);
      }
    });
  }

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
