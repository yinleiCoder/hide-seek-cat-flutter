import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/values/colors.dart';
import 'package:flutter_hide_seek_cat/pages/square/view_img_detail_page.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 站酷详情页面
 * @author yinlei
 */
class ZcoolDetailPage extends StatefulWidget {
  static String routeName = '/zcool_detail_page';
  final String objectId;/// 获取站酷每条item的id作为详情页接口的参数关联

  const ZcoolDetailPage({Key key, this.objectId}) : super(key: key);

  @override
  _ZcoolDetailPageState createState() => _ZcoolDetailPageState();
}

class _ZcoolDetailPageState extends State<ZcoolDetailPage> {

  Future _future;
  Future<ZcoolDetail> _loadAllData() async {
    return await UserApi.zcoolDetail(context: context, objectId: widget.objectId);
  }


  @override
  void initState() {
    super.initState();
    _future = _loadAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ZcoolDetail>(
        future: _future,
        builder: (context, snapshot) {
          List<Widget> children;
          if(snapshot.hasData) {

          }else if(snapshot.hasError) {
            children = [Text('发生未知出错啦！')];
          }else {
            children = [Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60.r,
                height: 60.r,
              ),
            )];
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 150.h,
                floating: false,
                snap: false,
                pinned: false,
                centerTitle: true,
                stretch: true,
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
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(snapshot.data.cover,),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(20.r),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data.title, style: Theme.of(context).textTheme.headline6.copyWith(letterSpacing: 1.2, fontWeight: FontWeight.bold,),),
                        SizedBox(height: 5.h,),
                        Text(snapshot.data.description, style: Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 1.2,),),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                sliver: SliverToBoxAdapter(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 10.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.r, horizontal: 5.w),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                maxRadius: 24,
                                backgroundImage: NetworkImage(snapshot.data.creatorObj.avatar),
                              ),
                              SizedBox(height: 5.h,),
                              Text(snapshot.data.creatorObj.username, style: TextStyle(color: AppColors.ylPrimaryColor, letterSpacing: 1.2, fontWeight: FontWeight.bold,),),
                              SizedBox(height: 30.h,),
                              Text('签名：${snapshot.data.creatorObj.signature}'),
                              SizedBox(height: 5.h,),
                              Text('主页: ${snapshot.data.creatorObj.pageUrl}'),
                              SizedBox(height: 5.h,),
                              Text('当前页：${snapshot.data.creatorObj.contentPageUrl}'),
                            ],
                          ),
                          Positioned(
                            left: 80.w,
                            top: 0.h,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange.withOpacity(.6),
                              child: Text(snapshot.data.creatorObj.cityName,textAlign: TextAlign.center, style: TextStyle(color: Colors.white,),),
                            ),
                          ),
                          Positioned(
                            left: 75.w,
                            top: 45.h,
                            child: CircleAvatar(
                              backgroundColor: Colors.greenAccent.withOpacity(.6),
                              radius: 25,
                              child: Text(snapshot.data.creatorObj.professionName,textAlign: TextAlign.center, style: TextStyle(color: Colors.white,),),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: -5.h,
                            child: CircleAvatar(
                              backgroundColor: Colors.blueAccent.withOpacity(.6),
                              radius: 45,
                              child: Text(snapshot.data.creatorObj.contentCountTips, textAlign: TextAlign.center,style: TextStyle(color: Colors.white,),),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: -5.h,
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent.withOpacity(.6),
                              radius: 40,
                              child: Text(snapshot.data.creatorObj.popularityCountTips,textAlign: TextAlign.center, style: TextStyle(color: Colors.white,),),
                            ),
                          ),
                          Positioned(
                            right: 65.w,
                            top: 15.h,
                            child: CircleAvatar(
                              backgroundColor: Colors.deepPurpleAccent.withOpacity(.6),
                              radius: 35,
                              child: Text(snapshot.data.creatorObj.fansCountTips,textAlign: TextAlign.center, style: TextStyle(color: Colors.white,),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 20.h),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 16 / 9,
                  children: snapshot.data.allImageList.map((img) {
                    return InkWell(
                      onTap: () => Navigator.of(context).pushNamed(ViewDetailPage.routeName, arguments: img),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            img,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null)
                                return child;
                              return Center(
                                child: LinearProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(20.r),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    child: Wrap(
                      runSpacing: 3.0,
                      spacing: 8.0,
                      children: snapshot.data.productTags.map((tag) {
                        return Chip(
                          label: Text(tag, style: TextStyle(letterSpacing: 1.2, ),),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
