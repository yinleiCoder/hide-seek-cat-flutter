import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 帖子详情页
 * @author yinlei
*/
class PostDetailPage extends StatefulWidget {
  static String routeName = '/post_detail_page';
  final String posterid; /// 帖子详情人id

  const PostDetailPage({Key key, this.posterid}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double currentScrollExtent = _scrollController.position.pixels;
      print(maxScrollExtent.toString()+":"+currentScrollExtent.toString());
      if(currentScrollExtent > (maxScrollExtent - 20)) {
        print('start loading more');
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2), () {
            return true;
          });
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 100.h,
              floating: true,
              snap: true,
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
                background: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
                    child: Image.asset('assets/images/cat_bg.png', fit: BoxFit.cover,)),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage('https://img.zcool.cn/community/0124445f1058a7a801206621ed7f26.jpg@3000w_1l_0o_100sh.jpg'),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '王可尔',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.5,),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  ylTimeFormat(DateTime.parse('2021-03-28T06:37:23.492Z')),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('啊啊啊'),
                    SizedBox(
                      height: 15.h,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          'https://img.zcool.cn/community/0124445f1058a7a801206621ed7f26.jpg@3000w_1l_0o_100sh.jpg',
                          width: 1.sw,
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
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // Wrap(
                    //   spacing: 5.0,
                    //   children: ['啊', '啊'].map((tag) {
                    //     return Chip(
                    //       avatar: ClipOval(child: Image.network(tag.avatar_url, fit: BoxFit.cover,)),
                    //       label: Text(tag.name),
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: MySliverCommentDelete(),
              // pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context,  index) {
                return Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Center(
                    child: Text('this is a comment'),
                  ),
                );
              }, childCount: 20),
            ),

          ],
        ),
      ),
    );
  }
}

class MySliverCommentDelete extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 48.h,
      margin: EdgeInsets.symmetric(horizontal: 15.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 25.r,
                height: 25.r,
                decoration: BoxDecoration(
                  color: AppColors.ylSecondaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.favorite, size: 12.ssp, color: Colors.white,),
                ),
              ),
              Transform.translate(
                offset: Offset(-5,0),
                child: Container(
                  width: 25.r,
                  height: 25.r,
                  decoration: BoxDecoration(
                    color: AppColors.ylPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.thumb_up, size: 12.ssp, color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(width: 5.w,),
              Text(
                  '2.1w'
              ),
            ],
          ),
          Text('评论'),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 60.h;

  @override
  double get minExtent => 60.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}
