import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/launch_url.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/signin_page.dart';
import 'package:rive/rive.dart';
import 'package:flutter_screenutil/size_extension.dart';

/**
 * 引导页、欢迎页
 * Rive Animation:
 * https://rive.app/community/
 * @author yinlei
 */
class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {

  /// rive.
  final riveFileName = 'assets/rives/marty_v6.riv';
  Artboard _artboard;
  RiveAnimationController _riveController;

  /// animatedWidget.
  AnimationController _controller;

  /// pageview
  PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  /// load rive file.
  void _loadRiveFile() async {
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load(riveFileName).then(
          (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard.We store a reference to it so we can toggle playback.
        artboard.addController(_riveController = SimpleAnimation('Animation1'));
        setState(() => _artboard = artboard);
      },
    );
  }


  Widget _buildIndicatorsPage() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int currentPage) {
              setState(() {
                currentIndex = currentPage;
              });
            },
            children: [
              _buildBootChildPage(
                image: 'assets/images/flutter_dash.png',
                title: '躲猫猫社交平台',
                content: '一个主打私聊的平台，遵循马哲的联系是普遍性、条件性的观点，为陌生人之间架起沟通心灵的“桥梁”。私聊就完事了？No!拒绝商业化，一切为了用户考虑，娱乐为辅，短视频流行的5G浪口，采用最系统的音视频学习知识，利用Ffmpeg、WebRTC助力音视频娱乐，同时Tensorflow机器学习助力推荐系统！悄悄告诉你，躲猫猫开发者热爱考编，特意为各位考公朋友们开通了“刷题”模块。',
              ),
              _buildBootChildPage(
                image: 'assets/images/flutter_web.png',
                title: '码力全开，躲猫猫持续更新！',
                content: '我1人正独立构建网站、后端、微信小程序、Windows客户端软件。采用最流行的编码架构和性能优化，打造最优质的应用。涉及C、C++、Kotlin、Flutter、Go、Ffmpeg、WebRTC、Docker、RabbitMQ、Sentry错误上报、数据埋点、大数据分析、分布式、微服务，代码全部开源供学习交流使用！！！\n详情请关注微信公众号：尹哥',
                reverse: true,
              ),
              _buildBootChildPage(
                image: 'assets/images/dash.png',
                title: 'Dark Theme适配',
                content: '采纳Google I/O大会的建议与标准，遵循Material Design设计风格,并自学新型设计理念，持续美化UI，完善用户体验。现已全面适配Android Q系统的深色模式。请用户打开手机Settings->Display->Dark theme按钮以开启深色模式。',
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                Rive(
                  artboard: _artboard,
                  fit: BoxFit.cover,
                ),
                ButtonTransition(controller: _controller),
              ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 40.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          ),
        ],
      ),
      bottomSheet: currentIndex == 3 ? Container(
        height: 60.h,
        width: 1.sw,
        color: Colors.white,
        child: Center(
          child: GestureDetector(
            onTap: () =>  Navigator.pushReplacementNamed(context, SignInPage.routeName),
            child: Text('Get Started'.toUpperCase(), style: TextStyle(
              color: AppColors.ylPrimaryColor,
              fontWeight: FontWeight.bold,
              wordSpacing: 2,
              letterSpacing: 1.5,
            ),),
          ),
        ),
      ) : Text(''),
    );
  }

  Widget _buildBootChildPage({image, title, content, reverse = false}) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !reverse ? Column(
            children: [
              Image.asset(image),
              SizedBox(
                height: 30.h,
              ),
            ],
          ) : SizedBox(),
          Text(
            title,
            style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              content,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .color
                    .withOpacity(0.7),
              ),
            ),
          ),
          reverse ? Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Image.asset(image),
              ),
            ],
          ) : SizedBox(),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 8.h,
      width: isActive ? 30.w : 8.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        color: AppColors.ylPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for(int i = 0; i < 4; i++) {
      if(currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }


  @override
  Widget build(BuildContext context) {
    return _artboard != null ?
        _buildIndicatorsPage()
        : Container();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    _riveController.dispose();
    super.dispose();
  }

}

/// custom button by AnimatedWidget.
class ButtonTransition extends AnimatedWidget {

  const ButtonTransition({Key key, AnimationController controller}) : super(key: key, listenable: controller);

  Animation<double> get _width => listenable;

  @override
  Widget build(BuildContext context) {
    // print(_width.value);
    return OutlineButton(
      onPressed: () =>  appLaunchUrl('https://rive.app/'),
      borderSide: BorderSide(
        width: _width.value * 5,
        color: AppColors.ylPrimaryColor,
      ),
      child: Text(
        'Rive for Flutter',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.ssp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

