import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:google_fonts/google_fonts.dart';
/**
 * Light and Dark主题
 * 跟随手机系统适配
 * 不太好的写法：
 *    // themeMode: ThemeMode.dark,
    // darkTheme: ThemeData(
    //   primaryColorDark: AppColors.primaryColor,
    //   accentColor: AppColors.primaryColor,
    //   brightness: Brightness.dark,
    // ),
    @author yinlei
*/
ThemeData ylLightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: AppColors.ylPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
    iconTheme: IconThemeData(
      color: AppColors.ylContentColorLightTheme,
    ),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
      .apply(bodyColor: AppColors.ylContentColorLightTheme),
    colorScheme: ColorScheme.light(
      primary: AppColors.ylPrimaryColor,
      secondary: AppColors.ylSecondaryColor,
      error: AppColors.ylErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.ylContentColorLightTheme.withOpacity(0.7),
      unselectedItemColor: AppColors.ylContentColorLightTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: AppColors.ylPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}

ThemeData ylDarkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: AppColors.ylPrimaryColor,
    // scaffoldBackgroundColor: AppColors.ylContentColorLightTheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
    iconTheme: IconThemeData(color: AppColors.ylContentColorDarkTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
      .apply(bodyColor: AppColors.ylContentColorDarkTheme),
    colorScheme: ColorScheme.dark().copyWith(
      primary: AppColors.ylPrimaryColor,
      secondary: AppColors.ylSecondaryColor,
      error: AppColors.ylErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      // backgroundColor: AppColors.ylContentColorLightTheme,
      selectedItemColor: Colors.white70,
      unselectedItemColor: AppColors.ylContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: AppColors.ylPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}

