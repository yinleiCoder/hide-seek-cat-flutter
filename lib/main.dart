import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/providers/provider.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/index/index.dart';
import 'package:flutter_hide_seek_cat/routes.dart';
import 'package:flutter_hide_seek_cat/theme.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/**
 * 躲猫猫APP
 * 一款专门为年轻人打造的社交APP
 * @author yinlei.
 * @description Created by 尹磊 on 2021/02/27
 * @code https://github.com/yinleiCoder/hide-seek-cat-flutter
 */

bool get isInDebugMode {
  // return false;
  return true;
}
/**
 * 错误收集：
 * 1. Dart错误
 * 2. Flutter widget builder错误
 * 3. android ios原生错误
 */
Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if(isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {// debug mode: handle flutter error and report runZonedGuarded.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZonedGuarded(() async {
    await SentryFlutter.init(
          (options) {
        options.dsn = 'https://2b5774881b104016ab50df4d9b28ef64@o496762.ingest.sentry.io/5685064';
      },
    );
    await AppGlobal.init();
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => CardProvider(),
          ),
          // ChangeNotifierProvider(
          //   create: (_) => ThemeModel(ThemeType.light),
          // ),
          // ChangeNotifierProvider.value(value: null)
        ],
        child: MyApp(),
      ),
    );
  }, (exception, stackTrace) async {
    if(isInDebugMode) {
      print(stackTrace);
    } else {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      print('Uploaded error to sentry.io');
    }
  });
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        SentryNavigatorObserver(),
      ],
      title: '躲猫猫',
      debugShowCheckedModeBanner: false,
      // onUnknownRoute: ,
      theme: ylLightThemeData(context),
      darkTheme: ylDarkThemeData(context),
      themeMode: ThemeMode.system,
      routes: ylRoutes,
      home: IndexPage(),
    );
  }
}



