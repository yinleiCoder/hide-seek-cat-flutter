import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/square/video_player_page.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:rive/rive.dart';
/**
 * 时讯页
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
  ];
  List<String> _tempVideoDescriptionDatas = [
    "找个有钱人嫁了，就是中国式婚姻真相？",
    "伪一镜到底时尚短片，1 分钟色彩搭配教科书",
    "去他妈的工具人生活",
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

  @override
  void dispose() {
    _scrollController.dispose();
    _riveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // body: FractionallySizedBox(
      //   widthFactor: 1.0,
      //     child: Container(color: Colors.red, height: 150.h,child: YlVideoPlayer(playUrl: 'https://yinlei-hide-seek-cat.oss-cn-chengdu.aliyuncs.com/%E8%8A%8A%E8%8A%8A.mp4',))),
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
            headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 150.h,
                floating: false,
                snap: false,
                pinned: false,
                centerTitle: true,
                stretch: true,
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
          body: ListView.builder(
            itemCount: _tempVideoDatas.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, VideoPlayerPage.routeName, arguments: _tempVideoDatas[index]),
                child: Card(
                  margin: EdgeInsets.only(bottom: 22.h, left: 5.w, right: 5.w,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                          ),
                          child: YlVideoPlayer(playUrl: _tempVideoDatas[index],)),
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Text(
                                _tempVideoDescriptionDatas[index],
                                style: Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 1.5, height: 1.5, color: Colors.grey, fontFamily: 'YinLei'),
                              ),
                              Icon(Icons.local_fire_department, color: Colors.redAccent,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
