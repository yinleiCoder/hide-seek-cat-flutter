import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 视频播放
 * @author yinlei
 */
class VideoPlayerPage extends StatefulWidget {
  static String routeName = '/video_player_page';
  final String playUrl;

  const VideoPlayerPage({Key key, @required this.playUrl}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 10.h,
            floating: false,
            snap: false,
            pinned: false,
            centerTitle: true,
            stretch: true,
            title: Text('躲猫猫视频'),
            leading: IconButton(
              icon: Icon(Icons.arrow_drop_down_circle_sharp),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(icon: Icon(Icons.share), onPressed: () => appShareText(text: widget.playUrl)),
            ],
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
            ),
          ),
          SliverFillViewport(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Center(child: YlVideoPlayer(playUrl: widget.playUrl, isAutoPlay: true,));
            }, childCount: 1, ),
            viewportFraction: 1.0,
          ),
        ],
      ),
    );
  }
}
