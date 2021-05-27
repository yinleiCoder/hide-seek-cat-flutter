import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/pages/square/post_detail_page.dart';
import 'package:flutter_hide_seek_cat/pages/square/topic_detail_page.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:rive/rive.dart' hide LinearGradient;

/**
 * 帖子页
 * @author yinlei
*/
class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<PostPage>{


  /// rive.
  /// space_reload.riv: Loading Idle Pull Trigger
  /// knight063.riv: idle day_night night_day
  final riveFileName = 'assets/rives/phone_drop.riv';
  Artboard _artboard;
  RiveAnimationController _riveController;

  List<Post> allPosts = [];
  List<Topic> top3Topics = [];
  ScrollController _scrollController;
  num _currentPage = 1;


  Widget _buildRecommendTopics({topicImg, topicName, publishTime, topicId}) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(TopicDetailPage.routeName, arguments: topicId),
      child: AspectRatio(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                    Text(
                      topicName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ylTimeFormat(DateTime.parse(publishTime)),
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
            moreDetail != null ? TextButton.icon(
              icon: Icon(Icons.more_horiz),
              onPressed: (){
              },
              label: Text(moreDetail,),
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
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double currentScrollExtent = _scrollController.position.pixels;
      print(maxScrollExtent.toString()+":"+currentScrollExtent.toString());
      if(currentScrollExtent > (maxScrollExtent - 20)) {
        print('start loading more');
        _loadAllData(page: ++_currentPage);
      }
    });
    _loadAllData();
    _loadLatestWithDiskCache();
  }

  _loadAllData({num page = 1, num per_page = 10}) async {
    var temps = await PostApi.allUsersPosts(context: context, page: page, per_page: per_page);
    top3Topics = await PostApi.allUsersTopics(context: context, per_page: 3);

    if(mounted) {
      setState(() {
        allPosts.addAll(temps);
      });
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
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load(riveFileName).then(
          (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard.We store a reference to it so we can toggle playback.
        artboard.addController(_riveController = SimpleAnimation('phone_loop'));
        setState(() => _artboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2), () {
          setState(() {
            allPosts = [];
            _currentPage = 1;
          });
          _loadAllData();
        });
      },
      child: ListView(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          _buildAreaTitle(areaTitle: '每日话题精选', ),
          Container(
            height: 180.h,
            width: 1.sw,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: PageController(
                keepPage: true,
                viewportFraction: 0.95,
              ),
              children: top3Topics.map((topic) => _buildRecommendTopics(topicImg: topic.avatar_url, topicName: topic.name, publishTime: topic.createdAt, topicId: topic.tid)).toList(),
            ),
          ),
          Wrap(
            spacing: 5.0,
            children: top3Topics.map((topic) {
              return Chip(
                avatar: ClipOval(child: Image.network(topic.avatar_url, fit: BoxFit.cover,)),
                label: Text(topic.name),
                onDeleted: () {
                  if(top3Topics.length == 1){
                    appShowToast(msg: '每日话题精选至少展示一个话题');
                    return;
                  }
                  setState(() {
                    top3Topics.remove(topic);
                  });
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
              color: AppColors.ylPrimaryColor,
              padding: EdgeInsets.symmetric(vertical: 5.h),
              height: 30.h,
              child: appMarquee(
                  text: '根据《中华人民共和国网络安全法》规定，保障网络安全，维护网络空间主权和国家安全、社会公共利益，保护公民、法人和其他组织的合法权益，促进经济社会信息化健康发展。若有用户违反相关条例，本平台将密切配合司法机关提起公诉⚠',
                  customStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
              ),
          ),
          _buildAreaTitle(areaTitle: '广场', isSqure: true),
          allPosts == null ? SizedBox(width: 1.sw,height: 1.sh, child: appListDarkSkeleton(),) : ListView.builder(
            itemCount: allPosts?.length,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ylPostCard(
                context: context,
                uid: allPosts[index].poster.uid,
                userName: allPosts[index].poster.name,
                userAvatar: allPosts[index].poster.avatar_url,
                publishTime: allPosts[index].createdAt??'',
                publishTitle: allPosts[index].title,
                publishText: allPosts[index].description,
                publishImage: allPosts[index].url,
                topics: allPosts[index].topics,
              );
            },
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _riveController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
