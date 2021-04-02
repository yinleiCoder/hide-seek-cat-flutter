
import 'package:flutter/material.dart';

/***
 * 暗黑主题/普通主题[不采用该provider,因为我的目的是采用跟随系统]
 * @author yinlei
*/
enum ThemeType { light, dark }
class ThemeModel extends ChangeNotifier {
  ThemeData themeData;

  ThemeType currentType;

  ThemeModel(ThemeType type) {
    currentType = type;
    if(type == ThemeType.dark) {
      themeData = ThemeData.dark();
    }else {
      themeData = ThemeData.light();
    }
  }

  void reverse() {
    if(currentType == ThemeType.light) {
      _update(ThemeType.dark);
    } else {
      _update(ThemeType.light);
    }
  }

  void _update(ThemeType type) {
    currentType = type;
    if(type == ThemeType.dark) {
      themeData = ThemeData.light();
    } else {
      themeData = ThemeData.dark();
    }
    notifyListeners();
  }

}