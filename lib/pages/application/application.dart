import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/providers/provider.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/chat/chat_page.dart';
import 'package:flutter_hide_seek_cat/pages/learn/learn_page.dart';
import 'package:flutter_hide_seek_cat/pages/news/news_page.dart';
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
    User appUser = await UserApi.somebodyUserInfo(context: context, uid: AppGlobal.profile.user.uid);
    if(appUser != null) {
      Provider.of<UserModel>(context, listen: false).user = appUser;
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
                  AppGlobal.profile?.user?.avatar_url ?? 'https://img.zcool.cn/community/010bba5f0890a6a801215aa00c8d22.jpg@1280w_1l_0o_100sh.jpg'
              ),
            ),
          ),
          label: '聊天',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIconfont.news),
          activeIcon: Icon(AppIconfont.newsActive),
          label: '时讯',
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
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add, color: Theme.of(context).scaffoldBackgroundColor,),
        elevation: 4.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

}
