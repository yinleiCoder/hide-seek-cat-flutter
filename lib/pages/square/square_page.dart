import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/providers/provider.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/toast.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/square/graffiti_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/hide_cat_coder.dart';
import 'package:flutter_hide_seek_cat/pages/square/pdf_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/post_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/profile_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/topic_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/zcool_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
/***
 * 广场页
 * @author yinlei
 */
class SquarePage extends StatefulWidget {
  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<SquarePage> {
  TabController _tabController;
  static const tabs = [
    "广场",
    "话题",
    "站酷图集",
    "躲猫猫涂鸦",
    "PDF预览",
  ];

  var _isExpanded = false;
  Future _future;

  /// QRCode save
  AnimationController _qrcodeAnimationCtrl;
  AnimationController _qrcodeScaleAnimationCtrl;
  AnimationController _qrcodeFadeAnimationCtrl;
  Animation<double> _qrcodeAnimation;
  Animation<double> _qrcodeScaleAnimation;
  Animation<double> _qrcodeFadeAnimation;
  double btnWidth = 200.w;
  double scale = 1.0;
  bool isAnimationComplete = false;
  double barColorOpacity = .6;

  @override
  void initState() {
    super.initState();
    _future = _loadOverlayImage(AppGlobal.profile.user.avatar_url);
    _tabController = TabController(length: tabs.length, vsync: this);
    _handleQRCodeAnimation();
  }


  Future<ui.Image> _loadOverlayImage(String network_url) async {
    final completer = Completer<ui.Image>();
    // final byteData = await rootBundle.load('assets/images/4.0x/logo_yakka.png');
    // ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(network_url)).load(network_url)).buffer.asUint8List();
    ui.decodeImageFromList(bytes, completer.complete);
    return completer.future;
  }


  void _handleQRCodeAnimation() {
    _qrcodeAnimationCtrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _qrcodeScaleAnimationCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _qrcodeFadeAnimationCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _qrcodeFadeAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(_qrcodeFadeAnimationCtrl);
    _qrcodeScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(_qrcodeScaleAnimationCtrl)..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _qrcodeScaleAnimationCtrl.reverse();
        _qrcodeFadeAnimationCtrl.forward();
        _qrcodeAnimationCtrl.forward();
      }
    });
    _qrcodeAnimation = Tween<double>(
      begin: 0.0,
      end: btnWidth,
    ).animate(_qrcodeAnimationCtrl)..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        isAnimationComplete = true;
        barColorOpacity = .0;
      }
    });
  }

  void _handleGenQRCode() {
    showModalBottomSheet<void>(
        context: context,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        builder: (BuildContext context) {
          return FutureBuilder<ui.Image>(
            future: _future,
            builder: (ctx, snapshot) {
              Widget child;
              if(snapshot.hasData) {
                child = Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Positioned(
                      top: 40.h,
                      child: CustomPaint(
                        size: Size.square(150),
                        painter: QrPainter(
                          data: AppGlobal.profile.user.uid,
                          version: QrVersions.auto,
                          eyeStyle: const QrEyeStyle(
                            eyeShape: QrEyeShape.square,
                            color: AppColors.ylPrimaryColor,
                          ),
                          dataModuleStyle: const QrDataModuleStyle(
                            dataModuleShape: QrDataModuleShape.circle,
                            color: AppColors.ylSecondaryColor,
                          ),
                          embeddedImage: snapshot.data,
                          embeddedImageStyle: QrEmbeddedImageStyle(
                            size: Size.square(40),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 80.h,
                      child: Text(
                        '说明: 保存上方二维码，分享扫码后可添加为躲猫猫好友',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 1.5, height: 1.5, color: Colors.grey,),
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      child: Stack(
                        children: [
                          AnimatedBuilder(
                            animation: _qrcodeScaleAnimationCtrl,
                            builder: (context, child) => Transform.scale(
                              scale: _qrcodeScaleAnimation.value,
                              child: InkWell(
                                onTap: () {
                                  _qrcodeScaleAnimationCtrl.forward();
                                },
                                child: Container(
                                  width: 200.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.ylPrimaryColor,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          child: isAnimationComplete == false ? Text('保存二维码到本地', style: TextStyle(color: Colors.white, letterSpacing: 1.5, fontFamily: 'YinLei'),)
                                              : Icon(Icons.check_circle_rounded, color: Colors.white,),
                                        ),
                                      ),
                                      AnimatedBuilder(
                                        animation: _qrcodeFadeAnimationCtrl,
                                        builder: (context, childe) => Container(
                                          width: _qrcodeFadeAnimation.value,
                                          height: 50.r,
                                          decoration: BoxDecoration(
                                            color: AppColors.ylSecondaryColor,
                                            borderRadius: BorderRadius.circular(3.r),
                                          ),
                                          child: Icon(Icons.cloud_download_sharp, color: Colors.white,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _qrcodeAnimationCtrl,
                            builder: (context, child) => Positioned(
                              left: 0,
                              top: 0,
                              width: _qrcodeAnimation.value,
                              height: 50.h,
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 200),
                                opacity: barColorOpacity,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if(snapshot.hasError) {
                child = Center(
                  child: Text('发生未知错误，请重新加载'),
                );
              } else {
                child = Center(
                  child: Text('发生未知错误，请稍等...'),
                );
              }
              return Container(
                height: 300.h,
                child: child,
              );
            },
          );
        });
  }

  void _handleAppInfoDetail() {
    showAboutDialog(
      context: context,
      applicationName:
      AppGlobal.packageInfo.appName,
      applicationVersion:
      AppGlobal.packageInfo.version,
      applicationIcon:
      Icon(AppIconfont.square),
      applicationLegalese: '遵循MIT协议',
      children: [
        Text('一款专门为年轻人设计的社交APP🐱'),
        Text('Flutter2助力多端开发😀'),
        Text('正码力全开🎊，加速构建躲猫猫社交全平台，尽请期待🎉🎉🎉'),
      ],
    );
  }

  Widget _buildExpansionPanelList() {
    return ExpansionPanelList(
      animationDuration: Duration(seconds: 2),
      dividerColor: Colors.pink,
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.all(8.r),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isExpanded = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: _isExpanded,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text("躲猫猫社交全平台"),
              subtitle: Text('现已将Web、APP、微信小程序、Windows桌面软件开发提上日程！'),
            );
          },
          body: Container(
            width: double.infinity,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.apps),
                  title: Text('躲猫猫社交平台官网'),
                ),
                ListTile(
                  leading: Icon(Icons.code),
                  title: Text('躲猫猫全平台Github源码'),
                ),
                ListTile(
                  leading: FlutterLogo(),
                  title: Text('APP开发者'),
                  onTap: () => Navigator.of(context)
                      .pushNamed(HideCatCoder.routeName),
                ),
                ListTile(
                  leading: Icon(Icons.error),
                  title: Text('错误上报平台Sentry'),
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('APP分享与推广'),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle_rounded),
                  title: Text('版本更新'),
                  onTap: () async {
                    if (await Permission.storage.isGranted) {
                      AppUpdate().run(context);
                    } else {
                      appShowToast(
                          msg: 'APP未被授存储权限，请在手机设置中手动打开！');
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.verified_sharp),
                  title: Text(
                      '关于${AppGlobal.packageInfo.appName}'),
                  trailing: Text(
                      '版本${AppGlobal.packageInfo.version}'),
                  onTap: _handleAppInfoDetail,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Consumer<UserModel>(
      builder: (context, userModel, _) {
        return Container(
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.white
              : Colors.black.withOpacity(.7),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(userModel.user.name),
                accountEmail: Text('${userModel.user.headline}'),
                currentAccountPicture: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    UserProfile.routeName,
                    arguments: AppGlobal.profile.user.uid,
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      userModel.user.avatar_url,
                    ),
                  ),
                ),
                otherAccountsPictures: [
                  IconButton(
                      icon: Icon(Icons.qr_code),
                      color: Colors.white,
                      onPressed: _handleGenQRCode
                  ),
                ],
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/flutter2.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black12.withOpacity(0.25),
                      BlendMode.srcOver,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    children: [
                      _buildExpansionPanelList(),
                      ListTile(
                        leading: Icon(Icons.confirmation_number),
                        title: Text('uid'),
                        subtitle: Text(
                          userModel.user.uid,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        ),
                        onTap: () {},
                      ),
                      AppGlobal.profile.user != null
                          ? ListTile(
                              onTap: () => goLoginPage(context),
                              title: Text(
                                '退出登录',
                                style: TextStyle(
                                  color: AppColors.ylPrimaryColor,
                                  fontSize: 22.ssp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.4,
                                ),
                              ),
                              trailing: Icon(
                                Icons.power_settings_new,
                                color: AppColors.ylPrimaryColor,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: _buildDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(
                        Icons.storage,
                        color: AppColors.ylPrimaryColor,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Theme.of(context).textTheme.bodyText1.color,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 3.0,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: AppColors.ylPrimaryColor,
                        width: 3.w,
                      ),
                      insets: EdgeInsets.only(bottom: 10.h),
                    ),
                    tabs: tabs
                        .map((tab) => Tab(
                              text: tab,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  PostPage(),
                  TopicPage(),
                  ZcoolPage(),
                  GraffitiPage(),
                  PdfPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _qrcodeAnimationCtrl.dispose();
    _qrcodeScaleAnimationCtrl.dispose();
    _qrcodeFadeAnimationCtrl.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

}
