import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:rive/rive.dart';
/**
 * 时讯页
 * NestedScrollView解决customscrollview嵌套listview的滑动问题
 * 【注意是sliver,也可以用sliverlist】
 */
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with AutomaticKeepAliveClientMixin<NewsPage> {
  ScrollController _scrollController;

  /// rive.
  /// space_reload.riv: Loading Idle Pull Trigger
  /// knight063.riv: idle day_night night_day
  final riveFileName = 'assets/rives/space_reload.riv';
  Artboard _artboard;
  RiveAnimationController _riveController;

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
                floating: true,
                snap: true,
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
            itemCount: 30,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(15.r),
                child: Center(
                  child: Text(index.toString()),
                ),
              );
            },
          )
            // SliverFillViewport(
            //   viewportFraction: 0.2,
            //   delegate: SliverChildBuilderDelegate((context, index) {
            //     return Padding(
            //       padding: EdgeInsets.all(15.r),
            //       child: Text('啊啊啊${index.toString()}'),
            //     );
            //   }),
            // ),
            // SliverFillRemaining(
            //   child: Container(
            //     color: Colors.orange,
            //   ),
            // ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate((context, index) {
            //     return Padding(
            //       padding: EdgeInsets.all(15.r),
            //       child: Text('啊啊啊'),
            //     );
            //   }),
            // ),
            // SliverFixedExtentList(
            //   itemExtent: ,// 指定item的高度
            // ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
