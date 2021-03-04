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
    "自拍墙",
    "音乐专区",
    "视频专区",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  Widget _buildDrawer() {
    return Container(
      color: Colors.black.withOpacity(.7),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('用户名'),
            accountEmail: Text('邮箱'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://img.zcool.cn/community/0133995c63a554a801203d223f3f17.jpg@520w_390h_1c_1e_1o_100sh.jpg',
              ),
            ),
            otherAccountsPictures: [
              IconButton(icon: Icon(Icons.qr_code), onPressed: (){}),
            ],
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://img.zcool.cn/community/017a1f600e370b11013f7928ee1196.jpg@1280w_1l_2o_100sh.jpg',),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black12.withOpacity(0.3),
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
                  ListTile(
                    title: Text('Tips: 往左滑动or点击我关闭本窗口', style: TextStyle(color: AppColors.primaryColor, fontSize: 20.ssp, fontWeight: FontWeight.bold,),),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  ListTile(
                    leading: Icon(Icons.apps),
                    title: Text('躲猫猫社交平台官网'),
                  ),
                  ListTile(
                    leading: Icon(Icons.code),
                    title: Text('躲猫猫社交平台源码'),
                  ),
                  ListTile(
                    leading: Icon(Icons.verified_sharp),
                    title: Text('关于躲貓貓'),
                    trailing: Text('版本v1.0.0'),
                    onTap: () {
                      showAboutDialog(
                          context: context,
                          applicationName: '躲猫猫',
                        applicationVersion: 'v1.0.0',
                        applicationIcon: Icon(AppIconfont.square),
                        applicationLegalese: '遵循MIT协议',
                        children:[
                          Text('一款专门为年轻人设计的社交APP'),
                          Text('前端：React'),
                          Text('后端：Koa2 RESTful API'),
                        ],
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.error),
                    title: Text('错误上报平台Sentry'),
                  ),
                  ListTile(
                    leading: FlutterLogo(),
                    title: Text('躲猫猫APP开发者'),
                  ),
                  AppGlobal.profile.user != null ? ListTile(
                    onTap: () => goLoginPage(context),
                    title: Text('退出登录', style: TextStyle(color: AppColors.primaryColor, fontSize: 22.ssp, fontWeight: FontWeight.bold,letterSpacing: 1.4,),),
                    trailing: Icon(Icons.power_settings_new, color: AppColors.primaryColor,),
                  ) : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      icon: Icon(Icons.storage, color: AppColors.primaryColor,),
                    );
                  },
                ),
                Expanded(
                  child: TabBar(
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
                ),
              ],
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
// onPressed: () => ,
// ),
// ],
// ),
// ),
