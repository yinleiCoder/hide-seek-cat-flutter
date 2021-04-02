import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/storage.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:package_info/package_info.dart';
/**
 * App 全局数据
 * @author yinlei
*/
class AppGlobal {

  /// user profile
  static Profile profile = Profile();

  /// release status?
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// first time to open ?
  static bool isFirstOpen = false;

  /// offlineLogin?
  static bool isOfflineLogin = false;

  /// ios?
  static bool isIOS = Platform.isIOS;

  /// android?
  static bool isAndroid = Platform.isAndroid;

  /// app publish channel
  static String channel = "Google";

  /// app package information
  static PackageInfo packageInfo;

  /// android device information
  static AndroidDeviceInfo androidDeviceInfo;

  /// ios device information
  static IosDeviceInfo iosDeviceInfo;

  static Future init() async {
    /// tell flutter framework wait AppGlobal then render.
    WidgetsFlutterBinding.ensureInitialized();

    /// init storage util.
    await AppStorage.init();


    /// init AppHttps util.
    AppHttps();

    /// init AppSocketIo util.
    AppSocketIo();


    /// device is first time opened?
    isFirstOpen = !AppStorage().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if(isFirstOpen) {
      AppStorage().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }

    /// read offline profile.
    var _profileJSON = AppStorage().getJSON(STORAGE_USER_PROFILE_KEY);
    if(_profileJSON != null) {
      profile = Profile.fromJson(_profileJSON);
      isOfflineLogin = true;
    }

    /// change android's statusbar to transparent.
    if(AppGlobal.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    /// read current device's information
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if(AppGlobal.isIOS) {
      AppGlobal.iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    } else if(AppGlobal.isAndroid) {
      AppGlobal.androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    }
    /// read app package information
    AppGlobal.packageInfo = await PackageInfo.fromPlatform();
  }

  /// save user and user's profile config.
  static Future<bool> saveProfile() {
    return AppStorage().setJSON(STORAGE_USER_PROFILE_KEY, profile.toJson());
  }

}