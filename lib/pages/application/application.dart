import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/pages/chat/chat_page.dart';
import 'package:flutter_hide_seek_cat/pages/learn/learn_page.dart';
import 'package:flutter_hide_seek_cat/pages/news/news_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/square_page.dart';
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
    );
  }


  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      elevation: 22.0,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(AppIconfont.square),
          activeIcon: Icon(AppIconfont.squareActive),
          label: '广场',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIconfont.chat),
          activeIcon: Icon(AppIconfont.chatActive),
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
        onPressed: () {},
        child: Icon(Icons.add),
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
