import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';
/**
 *App Update：
 * iOS: APP Store
 * Android:
 *   1. 检查是否有新版本
 *   2. 提示用户
 *   3. 执行升级——跳转APP商店 OR 后台下载APK并安装[√]
 *
 *   # 设备信息https://pub.dev/packages/device_info
    device_info: ^2.0.0
    # 包信息https://pub.dev/packages/package_info/install
    package_info: ^2.0.0
    # 路径https://pub.dev/packages/path_provider/install
    path_provider: ^2.0.1
    # 权限处理https://pub.dev/packages/permission_handler/install
    permission_handler: ^6.1.1
    # 安装apk https://pub.dev/packages/install_plugin/install
    install_plugin: ^2.0.1
 * @author yinlei
*/
class AppUpdate {
  /// singleton design mode.
  static AppUpdate _instance = AppUpdate._internal();
  factory AppUpdate() => _instance;

  BuildContext _context;
  App _appUpdateInfo;

  AppUpdate._internal();


  /// get current device infor and server latest information.
  Future run(BuildContext context) async {
    _context = context;
    /// commit current app's device information
    App requestDeviceInfo = App(
      device: AppGlobal.isIOS == true ? "ios" : "android",
      channel: AppGlobal.channel,
      architecture: AppGlobal.isIOS == true
        ? AppGlobal.iosDeviceInfo.utsname.machine
          : AppGlobal.androidDeviceInfo.device,
      model: AppGlobal.isIOS == true
        ? AppGlobal.iosDeviceInfo.name
          : AppGlobal.androidDeviceInfo.brand,
    );
    _appUpdateInfo = await AppApi.appUpdate(context: context, params: requestDeviceInfo);
    if(_appUpdateInfo != null) {
      runAppUpdate();
    }
  }

  /// check: is there new app version from koa server?
  Future runAppUpdate() async {
    /// compare version.
    final isNewVersion = (_appUpdateInfo.latestVersion.compareTo(AppGlobal.packageInfo.version) == 1);
    if(isNewVersion) {
      /// has new version . request to user.
      await appShowConfirmDialog(
        context: _context,
        app: _appUpdateInfo,
        cancelPressed: () => Navigator.of(_context).pop(),
        onPressed: () {
          /// start to upgrade
          Navigator.of(_context).pop();
          if(AppGlobal.isIOS) {
            var url = _appUpdateInfo.shopUrl.isEmpty
                ? 'https://itunes.apple.com/cn/app/%E5%86%8D%E6%83%A0%E5%90%88%E4%BC%99%E4%BA%BA/id1375433239?l=zh&ls=1&mt=8'
                : _appUpdateInfo.shopUrl;
            InstallPlugin.gotoAppStore(url);
          } else if(AppGlobal.isAndroid) {
            /// download apk and install.
            appShowToast(msg: "后台下载新版APK……");
            downloadAndroidApkAndInstall(_appUpdateInfo.fileUrl);
          }
        }
      );
    }
  }

  /// Android : download apk and install.
  Future downloadAndroidApkAndInstall(String fileUrl) async {
    print('download new version apk......');
    /// 1. Download
    // installplugin must external storage.
    Directory externalDir = await getExternalStorageDirectory();
    String fullPath = "${externalDir.path}/hideseekcat.apk";
    Dio dio = new Dio(
      BaseOptions(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) => status < 500,
      ),
    );
    Response response = await dio.get(fileUrl);
    /// 2. save downloaded file to target location by Dart api
    File file = File(fullPath);
    var writer = file.openSync(mode: FileMode.write);
    writer.writeFromSync(response.data);
    await writer.close();
    appShowToast(msg: "躲猫猫APP下载完成，准备安装中……");

    /// 3. install apk which located at target location
    /// for Android : install apk by its file absolute path;
    /// if the target platform is higher than android 24:
    /// a [appId] is required
    /// (the caller's applicationId which is defined in build.gradle)
    await InstallPlugin.installApk(fullPath, AppGlobal.packageInfo.packageName);
  }

}




