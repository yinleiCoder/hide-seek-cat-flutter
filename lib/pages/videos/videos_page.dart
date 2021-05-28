import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/square/profile_page.dart';
import 'package:flutter_hide_seek_cat/pages/videos/video_player_page.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rive/rive.dart';
/**
 * 视频娱乐页
 * NestedScrollView解决customscrollview嵌套listview的滑动问题
 * 【注意是sliver,也可以用sliverlist】
 */
class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> with AutomaticKeepAliveClientMixin<VideosPage> {
  ScrollController _scrollController;

  /// rive.
  /// space_reload.riv: Loading Idle Pull Trigger
  /// knight063.riv: idle day_night night_day
  final riveFileName = 'assets/rives/space_reload.riv';
  Artboard _artboard;
  RiveAnimationController _riveController;

  List<String> _tempVideoDatas = [
    "http://static-thefair-bj.oss-cn-beijing.aliyuncs.com/eyepetizer/pgc_video/video_summary/190663.mp4",
    "http://static-thefair-bj.oss-cn-beijing.aliyuncs.com/eyepetizer/pgc_video/video_summary/192381.mp4",
    "http://static-thefair-bj.oss-cn-beijing.aliyuncs.com/eyepetizer/pgc_video/video_summary/192196.mp4",
    "https://yinlei-hide-seek-cat.oss-cn-chengdu.aliyuncs.com/react-cat/ad.mp4",
  ];
  List<String> _tempVideoThumbnailUrl = [
    "https://img.zcool.cn/community/01a9a460a611f611013e3b7d7d770a.jpg@3000w_1l_0o_100sh.jpg",
    "https://img.zcool.cn/community/01d6a160ab55c011013f4720f6d8c1.jpg@3000w_1l_0o_100sh.jpg",
    "https://img.zcool.cn/community/01f06560acb0dd11013eaf707cbfaa.jpg@3000w_1l_0o_100sh.jpg",
    "https://img.zcool.cn/community/0116bd60ad246211013f4720455937.jpg@3000w_1l_0o_100sh.jpg",
  ];
  List<String> _tempVideoDescriptionDatas = [
    "找个有钱人嫁了，就是中国式婚姻真相？",
    "伪一镜到底时尚短片，1 分钟色彩搭配教科书",
    "去他妈的工具人生活",
    "油管上最喜欢听的音乐！虽然没听懂一句",
  ];

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
      }
    });
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
        artboard.addController(_riveController = SimpleAnimation('Loading'));
        setState(() => _artboard = artboard);
        _artboard.addController(SimpleAnimation('Pull'));
      },
    );
  }

  // Widget _buildVideoCard(index) {
  //   return GestureDetector(
  //     child: Card(
  //       margin: EdgeInsets.only(bottom: 22.h, left: 10.w, right: 10.w,),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.r),
  //       ),
  //       elevation: 10.0,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           ClipRRect(
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(12.r),
  //                 topRight: Radius.circular(12.r),
  //               ),
  //               child: YlVideoPlayer(playUrl: _tempVideoDatas[index],)),
  //           Padding(
  //             padding: EdgeInsets.all(8.0.r),
  //             child: FractionallySizedBox(
  //               widthFactor: 1.0,
  //               child: Wrap(
  //                 direction: Axis.horizontal,
  //                 alignment: WrapAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     _tempVideoDescriptionDatas[index],
  //                     style: Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 1.5, height: 1.5, color: Colors.grey, fontFamily: 'YinLei'),
  //                   ),
  //                   Icon(Icons.local_fire_department, color: Colors.redAccent,),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildVideoCard(index) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, VideoPlayerPage.routeName, arguments: _tempVideoDatas[index]),
                child: Image.network(_tempVideoThumbnailUrl[index], width: 1.sw, height: 220.h, fit: BoxFit.cover,)),
            Positioned(
              bottom: 8.0,
              right: 8.0,
              child: Container(
                margin: EdgeInsets.only(
                  left: 5.w,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Text(
                  '00:14',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(UserProfile.routeName, arguments: AppGlobal.profile.user.uid,),
                child: CircleAvatar(
                  foregroundImage: NetworkImage(AppGlobal.profile.user.avatar_url),
                ),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: Text(_tempVideoDescriptionDatas[index], maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15.ssp, fontWeight: FontWeight.bold),)),
                    Flexible(child: Text('1天前',style: Theme.of(context).textTheme.caption.copyWith(fontSize: 14.ssp,))),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){},
                child: Icon(Icons.more_vert, size: 20.ssp,),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2), () {
            return true;
          });
        },
        notificationPredicate: (_) {
          /// 解决深度为0才能处理下拉刷新和这里的nestedscrollview的问题
          return true;
        },
        child: NestedScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 150.h,
                floating: false,
                snap: false,
                pinned: true,
                centerTitle: true,
                stretch: true,
                leadingWidth: 100.w,
                leading: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: GestureDetector(
                      onTap: () => appLaunchUrl('https://flutter.dev/'),
                      child: Row(
                        children: [
                          Image.asset("assets/images/dash_logo.png", width: 30.r,height: 30.r,fit: BoxFit.cover,),
                          SizedBox(width: 5.w,),
                          Text('Dash', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, wordSpacing: 2, letterSpacing: 1.5, fontFamily: 'YinLei'),)
                        ],
                      ),
                    )),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.cast),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_outlined),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pushNamed(UserProfile.routeName, arguments: AppGlobal.profile.user.uid,),
                    icon: CircleAvatar(
                      foregroundImage: NetworkImage(
                        AppGlobal.profile.user.avatar_url,
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  background: _artboard != null ? Container(
                    width: 1.sw,
                    child: Rive(
                      artboard: _artboard,
                      fit: BoxFit.cover,
                    ),
                  ) : Center(child: Text('loading'),),
                ),
              ),
            ];
          },
          body: Scrollbar(
            child: ListView.builder(
              itemCount: _tempVideoDatas.length,
              itemBuilder: (context, index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: _buildVideoCard(index),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: '收藏',
                      color: Colors.yellowAccent,
                      icon: Icons.archive,
                      onTap: () => appShowToast(msg: '收藏'),
                    ),
                    IconSlideAction(
                      caption: '分享',
                      color: Colors.greenAccent,
                      icon: Icons.share,
                      onTap: () => appShowToast(msg: '分享'),
                    ),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: '视频详情',
                      color: Colors.blueAccent,
                      icon: Icons.details,
                      onTap: () => appShowToast(msg: '视频详情'),
                    ),
                    IconSlideAction(
                      caption: '不感兴趣',
                      color: Colors.redAccent,
                      icon: Icons.delete,
                      onTap: () => appShowToast(msg: '不感兴趣'),
                    ),
                  ],
                );
              },
            ),
          )
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    _riveController.dispose();
    super.dispose();
  }

}
