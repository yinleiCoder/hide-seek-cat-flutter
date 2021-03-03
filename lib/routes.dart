import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/pages/application/application.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/login.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/register.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/signin_page.dart';

/**
 * Flutter App Simple Route Manager Method.
 * @author yinlei.
 */
final Map<String, WidgetBuilder> ylRoutes = {
  SignInPage.routeName: (context) => SignInPage(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  ApplicationPage.routeName: (context) => ApplicationPage(),
};
