import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 用户个人资料页
 * @author yinlei
 * 如果需要动态获取布局高度可以用[例如制作动态sliver_appbar的高度]：after_layout库
*/
class UserProfile extends StatefulWidget {
  static String routeName = '/user_profile_page';

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> with TickerProviderStateMixin{

  double _extraPicHeight = 0;
  double _prev_dy;
  BoxFit _fitType;
  AnimationController _animationController;
  Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _prev_dy = 0;
    _fitType = BoxFit.fitWidth;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _anim = Tween(
      begin: 0.0,
      end: 0.0
    ).animate(_animationController);
  }

  _handleUpdatePicHeight(changed) {
    if(_prev_dy == 0) {
      _prev_dy = changed;
    }
    _extraPicHeight += changed - _prev_dy;
    if(_extraPicHeight >= 100) {
      _fitType = BoxFit.fitHeight;
    }else {
      _fitType = BoxFit.fitWidth;
    }
    setState(() {
      _prev_dy = changed;
      _extraPicHeight = _extraPicHeight;
      _fitType = _fitType;
    });
  }

  _handleRunAnimate() {
    setState(() {
      _anim = Tween(
          begin: _extraPicHeight,
          end: 0.0
      ).animate(_animationController)..addListener(() {
        if(_extraPicHeight >= 100) {
          _fitType = BoxFit.fitHeight;
        }else {
          _fitType = BoxFit.fitWidth;
        }
        setState(() {
          _extraPicHeight = _anim.value;
          _fitType = _fitType;
        });
      });
      _prev_dy = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerMove: (PointerMoveEvent event){
          _handleUpdatePicHeight(event.position.dy);
        },
        onPointerUp: (PointerUpEvent event) {
          _handleRunAnimate();
          _animationController.forward(from: 0);
        },
        child: CustomScrollView(
          // physics: BouncingScrollPhysics(),
          physics: ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              expandedHeight: 450.h + _extraPicHeight,
              stretch: true,
              onStretchTrigger: () {
                /// 刷新内容
              },
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                background: Column(
                  children: [
                    Image.asset('assets/images/cat_bg.png', height: 200.h + _extraPicHeight, width: 1.sw, fit: _fitType,),
                    Container(height: 150.h,
                      child: Align(
                        alignment: FractionalOffset(0, -2.0),
                        child: Container(
                          height: 140.h,
                          width: 1.sw,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 80.r,
                                    height: 80.r,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(color: Colors.white, width: 3.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.ylPrimaryColor,
                                          offset: Offset(5, 10),
                                          blurRadius: 16,
                                        )
                                      ],
                                      image: DecorationImage(
                                        image: NetworkImage(AppGlobal.profile.user.avatar_url),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  OutlinedButton(
                                      onPressed: (){},
                                      child: Text('编辑资料', style: TextStyle(color: Colors.white,),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Divider(color: Colors.grey[700],),
                    ),
                    Container(height: 100.h,),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return Container(height: 30.h, color: Colors.redAccent,);
              },
                childCount: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

