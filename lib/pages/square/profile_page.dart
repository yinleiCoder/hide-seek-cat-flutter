import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/square/topic_detail_page.dart';
import 'package:flutter_screenutil/size_extension.dart';
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

class _UserProfileState extends State<UserProfile> with TickerProviderStateMixin{

  User _currentUser;
  DateTime _selectedDate = DateTime.now();
  static const diplomas = [
    "高中及以下",
    "大专",
    "本科",
    "硕士",
    "博士及以上",
  ];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  _loadAllData() async {
    _currentUser = await UserApi.somebodyUserInfo(context: context, uid: widget.uid);
    if(mounted) {
      setState(() {});
    }
  }

  _handleSelectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1998),
        lastDate: DateTime(2025),
        helpText: '选择日期',
        cancelText: '暂不选择',
        confirmText: '确定',
        fieldLabelText: '填写日期',
        fieldHintText: '月/日/年',
        errorFormatText: '日期不合法',
        errorInvalidText: '请在有效的时间范围内选择日期',
        selectableDayPredicate: (DateTime day) {
          if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
              day.isBefore(DateTime.now().add(Duration(days: 7))))) {
            return true;
          }
          return false;
        },
    );
    if(picked != null && picked != _selectedDate){
      setState(() {
        _selectedDate = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_drop_down_circle_rounded),
                onPressed: () => Navigator.pop(context),
              ),
              expandedHeight: 250.h,
              stretch: true,
              pinned: true,
              onStretchTrigger: () {
                /// 刷新内容
              },
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                background: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.r),
                        bottomRight: Radius.circular(24.r),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://img.zcool.cn/community/018e905d157b84a8012155294638ae.jpg@1280w_1l_2o_100sh.jpg',
                        ),
                      )
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 10.h, right: 10.h, left: 10.h),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              maxRadius: 40.r,
                              backgroundImage: NetworkImage(
                                _currentUser.avatar_url,
                              ),
                            ),
                            Positioned(
                              right: -10,
                              bottom: -5,
                              child: CircleAvatar(
                                backgroundColor: AppColors.ylPrimaryColor.withOpacity(0.9),
                                foregroundColor: Colors.white,
                                child: Icon(Icons.edit,),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 22.w,),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                            label: Text('关注'),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          _currentUser.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline4.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.5, color: AppColors.ylPrimaryColor, fontFamily: 'YinLei'),
                        ),
                        Text("(uid: ${_currentUser.uid})", style: Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 1.5, height: 1.5, color: Colors.grey,)),
                      ],
                    ),
                    SizedBox(height: 5.h,),
                    Text(_currentUser.headline,style: Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 1.5, height: 1.5, color: Colors.grey,)),
                    SizedBox(height: 5.h,),
                    Divider(
                      height: 10,
                      thickness: 3,
                      indent: 10,
                      endIndent: 10,
                    ),
                    SizedBox(height: 22.h,),
                    Card(
                      margin: EdgeInsets.only(bottom: 22.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 10.0,
                      child: FractionallySizedBox(
                        widthFactor: 1.0,
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: 300.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage('https://img.zcool.cn/community/0146cf5eec3a0ea801215aa07313bc.jpg@1280w_1l_2o_100sh.jpg'),
                            ),
                          ),
                          padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                          child: Form(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // TextFormWidget(
                                //   controller: null,
                                //   labelText: '啊啊a ',
                                //   hintText: 'Account',
                                //   marginTop: 0,
                                //   isOutlineInputBorder: false,
                                // ),
                                ClipRect(  // <-- clips to the 200x200 [Container] below
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10.0,
                                      sigmaY: 10.0,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(vertical: 10.h),
                                      child: Text(_currentUser.business?.name?? '神秘工种', style: TextStyle(
                                        fontFamily: 'YinLei',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                        color: AppColors.ylPrimaryColor,
                                        fontSize: 20.ssp,
                                      ),),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: '男',
                                          groupValue: '男',
                                          onChanged: (val){

                                          },
                                        ),
                                        Text('男'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: '女',
                                          groupValue: '男',
                                          onChanged: (val){

                                          },
                                        ),
                                        Text('女'),
                                      ],
                                    ),
                                  ],
                                ),
                                if(_currentUser.locations.isNotEmpty) Wrap(
                                  children: _currentUser.locations.map((location){
                                    return Chip(
                                      backgroundColor: AppColors.ylSecondaryBgColor,
                                      label: Text(
                                        location.name,
                                        style: TextStyle(
                                          letterSpacing: 1.2,
                                          color: AppColors.ylPrimaryColor,
                                        ),
                                      ),
                                      elevation: 3.0,
                                      avatar: Icon(Icons.location_on, size: 22.ssp, color: AppColors.ylPrimaryColor,),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                InkWell(
                                  onTap: () => _handleSelectDate(context),
                                    child: Text("破蛋日：${DateTime.parse(_currentUser.createdAt)}")),
                                Text("系统当前日期：${_selectedDate.toLocal()}".split(' ')[0]),
                                // Text(_currentUser.gender == 'male' ? '男' : '女'),
                                _currentUser.educations.isNotEmpty ? Stepper(
                                  currentStep: _index,
                                  onStepCancel: () {
                                    if (_index <= 0) {
                                      return;
                                    }
                                    setState(() {
                                      _index--;
                                    });
                                  },
                                  onStepContinue: () {
                                    if (_index >= 1) {
                                      return;
                                    }
                                    setState(() {
                                      _index++;
                                    });
                                  },
                                  onStepTapped: (index) {
                                    setState(() {
                                      _index = index;
                                    });
                                  },
                                  steps: _currentUser.educations.asMap().entries.map((e){
                                    int currentIndex = e.key;
                                    Education education = e.value;
                                    return Step(
                                      isActive: currentIndex == _index ? true : false,
                                      title: Text(education.school.name),
                                      subtitle: Text("${education.major.name} ${diplomas[education.diploma-1]}" ),
                                      content: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Colors.grey[200],
                                          inactiveTrackColor: Colors.grey[700],
                                          thumbColor: Colors.grey[100],
                                          trackHeight: 2.h,
                                          thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 10.r,
                                          ),
                                          overlayColor: Colors.white.withAlpha(32),
                                          overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 20.r,
                                          ),
                                        ),
                                        child: Slider(
                                          min: education.entrance_year.toDouble(),
                                          max: education.graduation_year.toDouble(),
                                          value: education.entrance_year.toDouble(),
                                          label: "${education.entrance_year.toDouble()}",
                                          activeColor: Colors.white,
                                          divisions: education.graduation_year - education.entrance_year,
                                          onChanged: (value) async {
                                          },
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ) : Container(child: Text('他/她很懒，未填写相关教育经历'),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
              sliver: SliverToBoxAdapter(
                child: Text('${_currentUser.name}的工作经历', style: Theme.of(context).textTheme.headline6.copyWith(letterSpacing: 1.5, height: 1.5, fontWeight: FontWeight.bold, fontFamily: 'YinLei'),),
              ),
            ),
            _currentUser.employments.isNotEmpty ? SliverList(
              delegate: SliverChildBuilderDelegate((context,index) {
                return _buildTopicCard(
                  topicBg: _currentUser.employments[index].company.avatar_url,
                  topicName: _currentUser.employments[index].job.name,
                  topicCreatedTime: _currentUser.employments[index].job.createdAt,
                );
              }, childCount: _currentUser.employments.length),
            ) : SliverToBoxAdapter(child: Center(child: Text('他/她很懒，未填写相关工作经历')),),
            SliverPadding(
              padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
              sliver: SliverToBoxAdapter(
                child: Text('${_currentUser.name}关注的人', style: Theme.of(context).textTheme.headline6.copyWith(letterSpacing: 1.5, height: 1.5, fontWeight: FontWeight.bold, fontFamily: 'YinLei'),),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 60.h,
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                child: _currentUser.following != null ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _currentUser.following.length,
                  itemBuilder: (contex, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(UserProfile.routeName, arguments: _currentUser.following[index].uid),
                      child: Container(
                        margin: EdgeInsets.only(right: 10.w),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                _currentUser.following[index].avatar_url,
                              ),
                            ),
                            Spacer(),
                            Text(_currentUser.following[index].name),
                          ],
                        ),
                      ),
                    );
                  },
                ) : Center(
                  child: Text('他/她很懒，未关注任何人'),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(10.r),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
              sliver: SliverToBoxAdapter(
                child: Text('${_currentUser.name}关注的话题', style: Theme.of(context).textTheme.headline6.copyWith(letterSpacing: 1.5, height: 1.5, fontWeight: FontWeight.bold, fontFamily: 'YinLei'),),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
              sliver: _currentUser.followingTopics.isNotEmpty ? SliverGrid(
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 3,
                   mainAxisSpacing: 3.0,
                   crossAxisSpacing: 5.0,
                 ),
                 delegate: SliverChildBuilderDelegate(
                   (BuildContext context, int index) {
                     return GestureDetector(
                       onTap: () => Navigator.of(context).pushNamed(TopicDetailPage.routeName, arguments: _currentUser.followingTopics[index].tid),
                       child: _buildTopicCard(
                         topicBg: _currentUser.followingTopics[index].avatar_url,
                         topicName: _currentUser.followingTopics[index].name,
                         topicCreatedTime: _currentUser.followingTopics[index].createdAt,
                       ),
                     );
                   },
                   childCount: _currentUser.followingTopics.length,
                 ),
              ) : SliverToBoxAdapter(child: Container(
                child: Center(child: Text('他/她很懒，未关注任何话题'),),
              ),),
            ),
          ],
        ),
    );
  }

  Widget _buildTopicCard({topicBg, topicName, topicCreatedTime}) {
    return Container(
      height: 150.h,
      margin: EdgeInsets.only(bottom: 10.h),
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
}

