import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/providers/provider.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/square/hide_cat_coder.dart';
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

class _SquarePageState extends State<SquarePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<SquarePage> {

  TabController _tabController;
  static const tabs = [
    "广场", // 动态帖子
    "发现", // 话题
    "关注", // 粉丝
    "自拍墙",
    "音乐专区",
    "视频专区",
  ];

  var _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  Widget _buildDrawer() {
    return Consumer<UserModel>(
      builder: (context, userModel, _) {
        return Container(
          color: Colors.black.withOpacity(.7),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(userModel.isLogin ? userModel.user.name : '用户名'),
                // accountEmail: Text('uid: ${userModel.isLogin ? userModel.user.uid : ''}'),
                accountEmail: Text('${userModel.isLogin ? userModel.user.headline : ''}'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    userModel.isLogin ? userModel.user.avatar_url : 'https://img.zcool.cn/community/019e006054343f11013e87f440a8b8.jpg@3000w_1l_0o_100sh.jpg',
                  ),
                ),
                otherAccountsPictures: [
                  IconButton(icon: Icon(Icons.qr_code), onPressed: (){}),
                ],
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://img.zcool.cn/community/01ca635a295054a801216e8d609191.jpg@2o.jpg',),
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
                      ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            _isExpanded = !isExpanded;
                          });
                        },
                        children: [
                          ExpansionPanel(
                            isExpanded: _isExpanded,
                            headerBuilder: (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: Text("关于躲猫猫平台"),
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
                                    title: Text('躲猫猫社交平台源码'),
                                  ),
                                  ListTile(
                                    leading: FlutterLogo(),
                                    title: Text('躲猫猫APP开发者'),
                                    onTap: () => Navigator.of(context).pushNamed(HideCatCoder.routeName),
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if(userModel.isLogin) ListTile(
                        leading: Icon(Icons.confirmation_number),
                        title: Text('uid'),
                        subtitle: Text(userModel.user.uid),
                        onTap: () {
                        },
                      ),
                      if(userModel.isLogin) ListTile(
                        leading: Icon(Icons.bolt),
                        title: Text('性别'),
                        subtitle: Text(userModel.user.gender),
                        onTap: () {
                        },
                      ),
                      if(userModel.isLogin) ListTile(
                        leading: Icon(Icons.cake_rounded),
                        title: Text('破壳日'),
                        subtitle: Text(userModel.user.createdAt),
                        onTap: () {
                        },
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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

  @override
  bool get wantKeepAlive => true;

}
