import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/providers/provider.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/toast.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/chat/chat_page.dart';
import 'package:flutter_hide_seek_cat/pages/learn/learn_page.dart';
import 'package:flutter_hide_seek_cat/pages/videos/videos_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/post_edit_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/square_page.dart';
import 'package:provider/provider.dart';
/**
 * APP 主界面
 * @auhor yinlei
*/
class ApplicationPage extends StatefulWidget {
  static String routeName = '/application_page';

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {

  var _currentPage = 0;
  PageController _pageController;

  /// 上次点击的时间[用于1s内点击2次返回按钮是否退出]
  DateTime _lastPressedAt;
  User appUser;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: this._currentPage,
      keepPage: true,
    );
    _loadCurrentAppUserInfo();
  }

  /// 获取当前APP用户的个人信息并全局化响应到Provider树上
  _loadCurrentAppUserInfo() async {
   appUser = await UserApi.somebodyUserInfo(context: context, uid: AppGlobal.profile.user.uid);
    if(appUser != null && mounted) {
      AppGlobal.profile.user = appUser;
      AppGlobal.saveProfile();
      setState(() {});
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      elevation: 22.0,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(AppIconfont.square),
          activeIcon: Icon(AppIconfont.squareActive),
          label: '广场',
        ),
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.ylPrimaryColor,
                  offset: Offset(5, 6),
                  blurRadius: 16,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 14,
              backgroundImage: NetworkImage(
                appUser.avatar_url,
              ),
            ),
          ),
          label: '聊天',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIconfont.news),
          activeIcon: Icon(AppIconfont.newsActive),
          label: '视频专区',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIconfont.learn),
          activeIcon: Icon(AppIconfont.learnActive),
          label: '考编专区',
        ),
      ],
    );
  }

  Widget _buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: (targetPage) {
        setState(() {
          this._currentPage = targetPage;
        });
      },
      children: [
        SquarePage(),
        ChatPage(),
        NewsPage(),
        LearnPage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(_lastPressedAt == null || DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          appShowToast(msg: '1秒内点击2次返回键则退出APP');
          /// 2次点击间隔超过1s则重新⏲
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: _buildPageView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed(PostEditPage.routeName,),
          child: Icon(Icons.add, color: Theme.of(context).scaffoldBackgroundColor,),
          elevation: 4.0,
          shape: _DiamondBorder(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

}

/// custom floatingactionbutton shape.
class _DiamondBorder extends ShapeBorder {

  const _DiamondBorder();

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.only();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => getOuterPath(rect, textDirection: textDirection);
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()
        ..moveTo(rect.left + rect.width / 2.0, rect.top)
        ..lineTo(rect.right, rect.top + rect.height / 2.0)
        ..lineTo(rect.left + rect.width / 2.0, rect.bottom)
        ..lineTo(rect.left, rect.top + rect.height / 2.0)
        ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }

}
