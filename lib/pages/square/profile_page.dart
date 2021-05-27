import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/square/topic_detail_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/view_img_detail_page.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
/**
 * 用户个人资料页
 * @author yinlei
 * 如果需要动态获取布局高度可以用[例如制作动态sliver_appbar的高度]：after_layout库
*/
class UserProfile extends StatefulWidget {
  static String routeName = '/user_profile_page';
  final String uid;

  const UserProfile({Key key, @required this.uid}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  User _currentUser;
  List<User> _attentionSelfsUsers=[]; /// 粉丝
  List<String> _flutterDash = ["assets/images/flutter2.png", "assets/images/dash.png", "assets/images/dash-android.png", "assets/images/flutter_dash.png", ];
  static const _diplomas = [
    "高中及以下",
    "大专",
    "本科",
    "硕士",
    "博士及以上",
  ];


  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  _loadAllData() async {
    _currentUser = await UserApi.somebodyUserInfo(context: context, uid: widget.uid);
    _attentionSelfsUsers = await UserApi.allattentionUsers(context: context, uid: widget.uid);
    if(mounted) {
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ylProfileBgColor,
      appBar: AppBar(
        title: Text('用户公开个人资料'),
        centerTitle: false,
        leading: YlBackButton(context),
        elevation: 0,
        backgroundColor: AppColors.ylProfileBgColor,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Icon(Icons.more_vert, color: Colors.white,),
          ),
        ],
      ),
      body: _currentUser == null ? appCardProfileDarkSkeleton() :Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 28.w, top: 7.h),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(ViewDetailPage.routeName, arguments: _currentUser.avatar_url),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      _currentUser.avatar_url,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_currentUser.name, style: Theme.of(context).textTheme.headline4.copyWith(color: AppColors.ylPrimaryColor, fontWeight: FontWeight.bold, letterSpacing: 1.5, wordSpacing: 2, fontFamily: 'YinLei'),),
                    SizedBox(height: 10.h,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Colors.white, size: 17,),
                        Text(_currentUser.locations.isNotEmpty ? _currentUser.locations[0].name : '暂未定位地理位置', style: TextStyle(
                          color: Colors.white,
                          wordSpacing: 2,
                          letterSpacing: 4,
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${_currentUser.following.length}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.ssp),),
                    Text('关注数', style: TextStyle(color: Colors.white),),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                    width: 2,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${_attentionSelfsUsers.length}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.ssp),),
                    Text("粉丝数", style: TextStyle(color: Colors.white),),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                    width: 2,
                  ),
                ),
               OutlinedButton(
                 onPressed: () => (widget.uid == AppGlobal.profile.user.uid ? _handleModifyUserInfo(): _handleAttentionUser()),
                 child: Text(widget.uid == AppGlobal.profile.user.uid ? '编辑个人资料' : '关注',),
                 style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(width: 2, color: AppColors.ylPrimaryColor),
                 ),
               )
              ],
            ),
          ),
          Container(
            height: 44.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _attentionSelfsUsers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(UserProfile.routeName, arguments: _attentionSelfsUsers[index].uid),
                    child: Chip(
                        avatar: CircleAvatar(
                          backgroundImage: NetworkImage(
                              _attentionSelfsUsers[index].avatar_url,
                          ),
                        ),
                        label: Text(_attentionSelfsUsers[index].name),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _buildDraggableScrollableSheet(),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableScrollableSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
        return SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),
            child: Scrollbar(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w,right: 10.w,),
                      child: Column(
                        children: [
                          Container(
                            height: 5.h,
                            width: 30.w,
                            margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            children: [
                              Text('uid:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.ssp, color: Colors.black,),),
                              SizedBox(width: 5.w,),
                              Text(_currentUser.uid, style: TextStyle( color: Colors.black,),),
                            ],
                          ),
                          Row(
                            children: [
                              Text('个性签名:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.ssp, color: Colors.black,),),
                              SizedBox(width: 5.w,),
                              Text(_currentUser.headline, style: TextStyle( color: Colors.black,),),
                            ],
                          ),
                          Row(
                            children: [
                              Text('职业:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.ssp, color: Colors.black,),),
                              SizedBox(width: 5.w,),
                              Text(_currentUser.business?.name??'神秘工种', style: TextStyle( color: Colors.black,),),
                            ],
                          ),
                          Row(
                            children: [
                              Text('性别:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.ssp, color: Colors.black,),),
                              SizedBox(width: 5.w,),
                              _currentUser.gender == 'male' ? Icon(
                                Icons.male,
                                color: Colors.blue,
                              ) : Icon(
                                Icons.female,
                                color: Colors.pink,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('注册时间:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.ssp, color: Colors.black,),),
                              SizedBox(width: 5.w,),
                              Text('${DateTime.parse(_currentUser.createdAt)}', style: TextStyle( color: Colors.black,),),
                            ],
                          ),
                          FractionallySizedBox(
                            widthFactor: 1.0,
                            child: Wrap(
                              children: [
                                Text('教育经历:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.ssp, color: Colors.black,),),
                                SizedBox(width: 5.w,),
                                Wrap(
                                  children: _currentUser.educations.map((education) {
                                    return Text('${education.school.name} ${education.major.name} ${_diplomas[education.diploma-1]} ${education.entrance_year}-${education.graduation_year}年', style: TextStyle( color: Colors.black,),);
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text('工作经历:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.ssp, color: Colors.black,),),
                              SizedBox(width: 5.w,),
                              Row(
                                children: _currentUser.employments.map((employment) {
                                  return Text('${employment.company.name}(${employment.job.name}) ', style: TextStyle( color: Colors.black,),);
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, left: 10.w,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('关注的人', style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.5,wordSpacing: 2, color: AppColors.ylPrimaryColor, fontFamily: 'YinLei'),),
                          SizedBox(height: 15.h),
                          SizedBox(
                            height: 60.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _currentUser.following.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).pushNamed(UserProfile.routeName, arguments: _currentUser.following[index].uid),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            _currentUser.following[index].avatar_url,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(_currentUser.following[index].name, style: TextStyle( color: Colors.black,),),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('关注的话题', style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.5,wordSpacing: 2, color: AppColors.ylPrimaryColor, fontFamily: 'YinLei'),),
                          SizedBox(height: 15.h),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 16 / 9,
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 8.0,
                            ),
                            itemCount: _currentUser.followingTopics.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(TopicDetailPage.routeName, arguments: _currentUser.followingTopics[index].tid),
                                child: _buildAttentionedTopicsCard(
                                  topicBg: _currentUser.followingTopics[index].avatar_url,
                                  topicName: _currentUser.followingTopics[index].name,
                                  topicCreatedTime: _currentUser.followingTopics[index].createdAt,                                          ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, left: 10.w,),
                      child: Text('Flutter Dash吉祥物', style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.5,wordSpacing: 2, color: AppColors.ylPrimaryColor, fontFamily: 'YinLei'),),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                      child: StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        itemCount: 4,
                        mainAxisSpacing: 9,
                        crossAxisSpacing: 8,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(12.r)),
                              child: Image.asset(_flutterDash[index], fit: BoxFit.cover,),
                            ),
                          );
                        },
                        staggeredTileBuilder: (int index) => StaggeredTile.count(
                          2,
                          index.isEven ? 3 : 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttentionedTopicsCard({topicBg, topicName, topicCreatedTime}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(topicBg),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              stops: [0.3, 0.9],
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2),
              ]
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(topicName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                Text(
                  ylTimeFormat(DateTime.parse(topicCreatedTime)),
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleModifyUserInfo() {
    print('编辑用户个人信息');
  }

  _handleAttentionUser() {
    print('关注');
  }

}
