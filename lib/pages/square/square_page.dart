import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/providers/provider.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/square/post_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/size_extension.dart';

/***
 * 广场页
 * @author yinlei
 */
class SquarePage extends StatefulWidget {
  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> with SingleTickerProviderStateMixin {

  TabController _tabController;
  static const tabs = [
    "广场", // 动态帖子
    "发现", // 话题
    "关注", // 粉丝
    "小姐姐",
    "美图专区",
    "视频专区",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.white,
              labelStyle: ylCommonTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: ylCommonTextStyle.copyWith(
                fontWeight: FontWeight.normal,
              ),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3.0,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 3.w,
                ),
                insets: EdgeInsets.only(bottom: 10.h),
              ),
              tabs: tabs.map((tab) => Tab(text: tab,)).toList(),
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  PostPage(),
                  Text('广场2'),
                  Text('广场3'),
                  Text('广场4'),
                  Text('广场5'),
                  Text('广场5'),
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
    super.dispose();
  }

}

// body: Center(
// child: Column(
// children: [
// Text('广场:${AppGlobal.profile.user?.name} ${AppGlobal.profile.token}'),
// MaterialButton(
// child: Text('注销'),
// onPressed: () => goLoginPage(context),
// ),
// ],
// ),
// ),
