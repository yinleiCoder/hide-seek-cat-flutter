import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:webview_flutter/webview_flutter.dart';

/**
 * 考编学习页
 * webView: https://pub.dev/packages/webview_flutter
 * @author yinlei
 */
class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> with AutomaticKeepAliveClientMixin<LearnPage> {

  bool _isPageFinished = false;
  double _webViewHeight = 200;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybird composition
    if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  /// WebView
  Widget _buildWebView() {
    return Container(
      height: _webViewHeight,
      child: WebView(
        initialUrl: 'https://m.bilibili.com/space/300722822',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _controller.complete(webViewController);
          /// load local html
          /// String contentBase64 = base64Encode(const Utf8Encoder().convert(htmlPage));
          /// await webViewController.loadUrl('data:text/html;base64,$contentBase64');
        },
        javascriptChannels: <JavascriptChannel>[
          _invokeJavascriptChannel(context),
        ].toSet(),
        navigationDelegate: (NavigationRequest request) {
          if(!request.url.startsWith("https://m.bilibili.com/")) {
            appShowToast(msg: "不允许访问未知链接哦！");
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          Timer(Duration(milliseconds: 500), () => removeSomeInNeedDOM());
        },
        onPageFinished: (String url) {
          // getWebViewDevicePixelRatio();
          getWebViewHeight();
          setState(() {
            _isPageFinished = true;
          });
        },
        gestureNavigationEnabled: true,
      ),
    );
  }

  /// 获取Web像素密度
  getWebViewDevicePixelRatio() async {
    await (await _controller.future)?.evaluateJavascript('''
        try {
          Invoke.postMessage(window.devicePixelRatio);
        } catch {}
        ''');
  }

  /// 注册js回调
  JavascriptChannel _invokeJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Invoke',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
          var webHeight = double.parse(message.message);
          if (webHeight != null) {
            setState(() {
              _webViewHeight = webHeight;
            });
          }
        });
  }

  /// 获取HTML页面高度
  getWebViewHeight() async {
    await (await _controller.future)?.evaluateJavascript('''
        try {
          // Invoke.postMessage([document.body.clientHeight,document.documentElement.clientHeight,document.documentElement.scrollHeight]);
          let scrollHeight = document.documentElement.scrollHeight;
          if (scrollHeight) {
            Invoke.postMessage(scrollHeight);
          }
        } catch {}
        ''');
  }

  /// 删除加载的网页中不想展示的DOM元素
  removeSomeInNeedDOM() async {
    await (await _controller.future)?.evaluateJavascript('''
        try {
          function removeElement(elementName){
            let _element = document.getElementById(elementName);
            if(!_element) {
              _element = document.querySelector(elementName);
            }
            if(!_element) {
              return;
            }
            let _parentElement = _element.parentNode;
            if(_parentElement){
                _parentElement.removeChild(_element);
            }
          }

          removeElement('.open-app-btn');
          removeElement('.m-navbar');
        } catch{}
        ''');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('早日进面，早日上岸🖐'),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () => appShareText(text: 'https://m.bilibili.com/space/300722822')),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildWebView(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
