import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/pages/application/application.dart';
import 'package:flutter_hide_seek_cat/pages/chat/chat_message_page.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/login.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/register.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/signin_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/hide_cat_coder.dart';

/**
 * Flutter App Simple Route Manager Method.
 * @author yinlei.
 */
final Map<String, WidgetBuilder> ylRoutes = {
  SignInPage.routeName: (context) => SignInPage(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  ApplicationPage.routeName: (context) => ApplicationPage(),
  HideCatCoder.routeName: (context) => HideCatCoder(),
  ChatMessagePage.routeName: (context) => ChatMessagePage(friend: ModalRoute.of(context).settings.arguments,),
};
