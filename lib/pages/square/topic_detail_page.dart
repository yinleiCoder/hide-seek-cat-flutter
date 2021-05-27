import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/date.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/post_card.dart';
import 'package:flutter_hide_seek_cat/common/widgets/skeleton.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
/**
 * 话题详情页
 * @author yinlei
*/
class TopicDetailPage extends StatefulWidget {
  static String routeName = '/topic_detail_page';

  final String tid;

  const TopicDetailPage({Key key, this.tid}) : super(key: key);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {

  Topic _showOfTopic;
  List<Post> _allPostsOfSomeonTopic;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  _loadAllData() async {
    _showOfTopic = await PostApi.someoneTopic(context: context, tid: widget.tid);
    _allPostsOfSomeonTopic = await PostApi.allPostsOfSomeonTopic(context: context, tid: widget.tid);

    if(mounted) {
      setState(() {});
    }
  }

  _handleAttentionTopic() {
    appShowToast(msg: '关注话题');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showOfTopic == null ? appCardProfileLightSkeleton() :
      CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 250.h,
            floating: true,
            snap: true,
            pinned: true,
            centerTitle: true,
            stretch: true,
            leading: YlBackButton(context),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Image.network(_showOfTopic.avatar_url, fit: BoxFit.cover,),
            ),
            bottom: PreferredSize(
              preferredSize: Size(1.sw, 60.h),
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(_showOfTopic.name, style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white,
                    ),),
                    GestureDetector(
                      onTap: _handleAttentionTopic,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(33.r)),
                          gradient: LinearGradient(
                            colors: [Color(0xff6D0EB5), Color(0xff4059F1)],
                            begin: Alignment.bottomRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                        child: Text('关注', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, wordSpacing: 2, letterSpacing: 1.5,),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if(_allPostsOfSomeonTopic!=null)SliverToBoxAdapter(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 10.0,
                  sigmaX: 10.0,
                ),
                child: Container(
                  width: 1.sw,
                  height: 50.h,
                  padding: EdgeInsets.all(5.r),
                  child: Wrap(
                    runSpacing: 5.0,
                    spacing: 3.0,
                    children: [
                      Text('话题简介: ', style: TextStyle(color: AppColors.ylPrimaryColor, fontWeight: FontWeight.bold),),
                      Text(_showOfTopic.introduction),
                      Text('创建时间: ${ylTimeFormat(DateTime.parse(_showOfTopic.createdAt))}'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if(_allPostsOfSomeonTopic!=null)SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            sliver: SliverStaggeredGrid.countBuilder(
              itemCount: _allPostsOfSomeonTopic.length,
              crossAxisCount: 2,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 8.0,
              itemBuilder: (BuildContext context, int index) {
                return ylPostCard(
                  context: context,
                  uid: _allPostsOfSomeonTopic[index].poster.uid,
                  userName: _allPostsOfSomeonTopic[index].poster.name,
                  userAvatar: _allPostsOfSomeonTopic[index].poster.avatar_url,
                  publishTime: _allPostsOfSomeonTopic[index].createdAt,
                  publishImage: _allPostsOfSomeonTopic[index].url,
                  publishTitle: _allPostsOfSomeonTopic[index].title,
                  publishText: _allPostsOfSomeonTopic[index].description,
                  topics: _allPostsOfSomeonTopic[index].topics,
                );
              },
              staggeredTileBuilder: (int index) {
                return StaggeredTile.fit(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

