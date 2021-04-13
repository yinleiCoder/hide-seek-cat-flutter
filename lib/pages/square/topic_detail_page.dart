import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/date.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/post_card.dart';
import 'package:flutter_hide_seek_cat/common/widgets/skeleton.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
/**
 * 获取某个特定的话题
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
            pinned: false,
            centerTitle: true,
            stretch: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_drop_down_circle_rounded),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Image.network(_showOfTopic.avatar_url, fit: BoxFit.cover,),
            ),
            bottom: PreferredSize(
              preferredSize: Size(1.sw, 60.h),
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
                    padding: EdgeInsets.all(5.r),
                    child: Wrap(
                      runSpacing: 5.0,
                      spacing: 3.0,
                      children: [
                        Text(_showOfTopic.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.ssp, letterSpacing: 1.2,),),
                        Text(_showOfTopic.introduction),
                        Text('创建时间: ${ylTimeFormat(DateTime.parse(_showOfTopic.createdAt))}'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if(_allPostsOfSomeonTopic!=null)SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
            sliver: SliverStaggeredGrid.countBuilder(
              itemCount: _allPostsOfSomeonTopic.length,
              crossAxisCount: 2,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 5.0,
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

