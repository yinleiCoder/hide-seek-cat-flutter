import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/pages/application/application.dart';
import 'package:flutter_hide_seek_cat/pages/chat/chat_audio_call_page.dart';
import 'package:flutter_hide_seek_cat/pages/chat/chat_message_page.dart';
import 'package:flutter_hide_seek_cat/pages/chat/chat_video_call_page.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/login.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/register.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/signin_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/hide_cat_coder.dart';
import 'package:flutter_hide_seek_cat/pages/square/post_detail_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/post_edit_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/profile_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/topic_detail_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/topic_page.dart';
import 'package:flutter_hide_seek_cat/pages/videos/video_player_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/view_img_detail_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/zcool_detail_page.dart';

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
  UserProfile.routeName: (context) => UserProfile(uid: ModalRoute.of(context).settings.arguments,),
  TopicPage.routeName: (context) => TopicPage(),
  PostDetailPage.routeName: (context) => PostDetailPage(posterid: ModalRoute.of(context).settings.arguments,),
  ZcoolDetailPage.routeName: (context) => ZcoolDetailPage(objectId: ModalRoute.of(context).settings.arguments,),
  ViewDetailPage.routeName: (context) => ViewDetailPage(imgUrl: ModalRoute.of(context).settings.arguments,),
  TopicDetailPage.routeName: (context) => TopicDetailPage(tid: ModalRoute.of(context).settings.arguments,),
  PostEditPage.routeName: (context) => PostEditPage(),
  VideoPlayerPage.routeName: (context) => VideoPlayerPage(playUrl: ModalRoute.of(context).settings.arguments,),
  ChatAudioCallPage.routeName: (context) => ChatAudioCallPage(friend: ModalRoute.of(context).settings.arguments,),
  ChatVideoCallPage.routeName: (context) => ChatVideoCallPage(friend: ModalRoute.of(context).settings.arguments,),
};
