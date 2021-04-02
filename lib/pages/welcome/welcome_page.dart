import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/pages/sign_in/signin_page.dart';
import 'package:rive/rive.dart';
import 'package:flutter_screenutil/size_extension.dart';

/**
 * 引导页
 * Rive Animation:
 * https://rive.app/community/
 * @author yinlei.
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
              _buildEachPage(
                image: 'assets/images/step-one.png',
                title: '独处',
                content: '互联网时代下的新青年们，越来越依赖手机进行沟通。可是望着通讯录的寥寥几个好友……渐渐的，在现实生活中，陌生人带着耳机、玩着手机，连轻易打扰想认识对方的勇气都没有了😪。',
              ),
              _buildEachPage(
                image: 'assets/images/step-two.png',
                title: '诱惑',
                content: '👧姐姐的腿不是腿，塞纳河畔的春水。姐姐的背不是背，保加利亚的玫瑰。姐姐的腰不是腰，夺命三郎的弯刀。姐姐的嘴不是嘴，安河桥下的清水。',
                reverse: true,
              ),
              _buildEachPage(
                image: 'assets/images/step-three.png',
                title: '寻找or妥协',
                content: '时间不会等你，慢慢的你就会不知不觉的从18岁到19、20、21、22、23、24、25、26、27、28、29岁……面对家人的催婚，你眼里他人恋爱的快乐画面，你会选择等待属于你的幸福❤or妥协去相亲💔。无论你是想寻找SoulMate还是想认识新朋友，我相信，躲猫猫APP都会帮助您逃离孤单的生活圈😀',
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
    );
  }

  Widget _buildEachPage({image, title, content, reverse = false}) {
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
    print(_width.value);
    return OutlineButton(
      onPressed: () =>  Navigator.pushReplacementNamed(context, SignInPage.routeName),
      borderSide: BorderSide(
        width: _width.value * 5,
        color: AppColors.ylPrimaryColor,
      ),
      child: Text(
        'GET START',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.ssp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );  
  }
}

