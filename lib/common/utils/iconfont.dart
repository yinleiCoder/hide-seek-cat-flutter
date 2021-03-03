import 'package:flutter/material.dart';

/**
 * iconfont图标库
 * usage steps:
    1. in the iconfont.cn, find your need iconfont or svg.
    2. add these iconfonts/svgs into your project.
    3. go into your account page, download your this project, then you will get a .zip file.
    4. unzip this file to your local computer,then copy it's iconfont.ttf file into androidstudio's flutter your custom dir
    5. finally, modify pubspec.yaml, add font family and path.
    that's all steps. (edited by yinlei.)
 * @author yinlei
*/
class AppIconfont {
  // call: Icon(AppIconfont.news),
  static const news = IconData(
    0xe619,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );
  static const newsActive = IconData(
    0xe673,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );
  static const chat = IconData(
    0xe674,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );
  static const chatActive = IconData(
    0xe67c,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );
  static const square = IconData(
    0xe6d5,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );
  static const squareActive = IconData(
    0xe6a2,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );
  static const learn = IconData(
    0xe7fb,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );
  static const learnActive = IconData(
    0xe600,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );

}