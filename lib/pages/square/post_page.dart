import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:rive/rive.dart' hide LinearGradient;

/**
 * 广场中的动态tab页
 * @author yinlei
*/
class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with TickerProviderStateMixin{

  /// animated Icon.
  AnimationController _animationController;
  bool isClickCommentBtning = false;

  /// rive.
  final riveFileName = 'assets/rives/rudolph.riv';
  Artboard _artboard;

  List<Post> allPosts;

  List<String> tempTopics = [
    '绵阳',
    '乐山',
    '小姐姐',
    '性感',
    '2021'
  ];

  Widget _buildRecommendTopics({topicImg, userAvatar, userName}) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(
              topicImg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.1),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white, width: 3.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.ylPrimaryColor,
                          offset: Offset(5, 10),
                          blurRadius: 16,
                        )
                      ],
                      image: DecorationImage(
                        image: NetworkImage(userAvatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    userName,
                    style: ylCommonTextStyle.copyWith(
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

  Widget _buildOtherUsersPuslishedPost({userName, userAvatar, publishTime, publishText, publishImage, List<Topic> topics}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(userAvatar, width: 48.r, height: 48.r, fit: BoxFit.cover,
                      ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          userName,
                          style: ylCommonTextStyle.copyWith(
                            fontSize: 16.ssp,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                          publishTime,
                          style: ylCommonTextStyle.copyWith(
                            color: Colors.grey,
                          ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.more_horiz, size: 30.ssp,),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(publishText),
          SizedBox(
            height: 20.h,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(publishImage, width: 1.sw, fit: BoxFit.cover,),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Wrap(
            spacing: 5.0,
            children: topics.map((tag) {
              return Chip(
                avatar: ClipOval(child: Image.network(tag.avatar_url, fit: BoxFit.cover,)),
                label: Text(tag.name),
              );
            }).toList(),
          ),
          Row(
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
              FlatButton.icon(onPressed: (){
                setState(() {
                  isClickCommentBtning = !isClickCommentBtning;
                  isClickCommentBtning ? _animationController.forward() : _animationController.reverse();
                });
              }, icon: AnimatedIcon(
                icon: AnimatedIcons.view_list,
                progress: _animationController,
              ), label: Text('821条评论')),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAreaTitle({areaTitle, moreDetail, isSqure=false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Container(
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Row(
              children: [
                Text(
                  areaTitle,
                  style: TextStyle(
                    color: AppColors.ylPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.ssp,
                    letterSpacing: 1.2,
                  ),
                ),
                isSqure ? Icon(AppIconfont.square, color: AppColors.ylPrimaryColor,) : Container(),
              ],
            ),
            moreDetail != null ? FlatButton.icon(
              icon: Icon(Icons.more_horiz),
              onPressed: (){
              },
              label: Text(moreDetail),
            ) : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 450),
    );
    _loadAllData();
    _loadLatestWithDiskCache();
  }

  _loadAllData() async {
    allPosts = await PostApi.allUsersPosts(context: context);
    setState(() {});

    if(mounted) {
      setState(() {});
    }
  }

  /// 如果有磁盘缓存，延迟3秒拉取更新档案
  _loadLatestWithDiskCache() {
    if(CACHE_ENABLE == true) {
      var cacheData = AppStorage().getJSON(STORAGE_CACHE_KEY);
      if(cacheData != null) {
        Timer(Duration(seconds: 1), () {
          /// controller.callRefresh()
        });
      }
    }
  }

  /// load rive file.
  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile();

    if(file.import(bytes)) {
      /// select an animation by its name
      setState(() => _artboard = file.mainArtboard
        ..addController(
          SimpleAnimation('dance'),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAreaTitle(areaTitle: '每日话题精选', moreDetail: '更多话题'),
          Container(
            height: 180.h,
            width: 1.sw,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: PageController(
                keepPage: true,
                viewportFraction: 0.9,
              ),
              children: [
                _buildRecommendTopics(topicImg: 'https://img.zcool.cn/community/017a1f600e370b11013f7928ee1196.jpg@1280w_1l_2o_100sh.jpg', userAvatar: 'https://img.zcool.cn/community/0133995c63a554a801203d223f3f17.jpg@520w_390h_1c_1e_1o_100sh.jpg', userName: '尹哥'),
                _buildRecommendTopics(topicImg: 'https://img.zcool.cn/community/01fb0060137f3811013f79281d481f.jpg@1280w_1l_2o_100sh.jpg', userAvatar: 'https://img.zcool.cn/community/0133995c63a554a801203d223f3f17.jpg@520w_390h_1c_1e_1o_100sh.jpg', userName: '张明'),
                _buildRecommendTopics(topicImg: 'https://img.zcool.cn/community/0100bb5fa3aeb911013fdcc78b065a.jpg@1280w_1l_2o_100sh.jpg', userAvatar: 'https://img.zcool.cn/community/0133995c63a554a801203d223f3f17.jpg@520w_390h_1c_1e_1o_100sh.jpg', userName: '宋阳'),
              ],
            ),
          ),
          Wrap(
            spacing: 5.0,
            children: tempTopics.map((tag) {
              return Chip(
                avatar: ClipOval(child: Image.network('https://img.zcool.cn/community/0133995c63a554a801203d223f3f17.jpg@520w_390h_1c_1e_1o_100sh.jpg', fit: BoxFit.cover,)),
                label: Text(tag),
                onDeleted: () {
                  setState(() {
                    tempTopics.remove(tag);
                  });
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 20.h,
          ),
          _artboard != null ? SizedBox(
            height: 200.h,
            child: FractionallySizedBox(
              widthFactor: 1.0,
              child: Rive(
                artboard: _artboard,
                fit: BoxFit.cover,
              ),
            ),
          ) : appCardPageDarkSkeleton(),
          _buildAreaTitle(areaTitle: '广场', isSqure: true),
          allPosts == null ? SizedBox(width: 1.sw,height: 1.sh, child: appListDarkSkeleton(),) : ListView.separated(
            itemCount: allPosts?.length,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            separatorBuilder: (context, position) => Divider(),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _buildOtherUsersPuslishedPost(
                userName: allPosts[index].poster.name,
                userAvatar: allPosts[index].poster.avatar_url,
                publishTime: allPosts[index].createdAt??'',
                publishText: allPosts[index].description,
                publishImage: 'https://img.zcool.cn/community/01fb0060137f3811013f79281d481f.jpg@1280w_1l_2o_100sh.jpg',
                topics: allPosts[index].topics,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
