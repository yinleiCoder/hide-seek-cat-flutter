import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_hide_seek_cat/common/values/colors.dart';
import 'dart:ui';
import 'package:flutter_screenutil/size_extension.dart';

/**
 * video player:
 * https://pub.dev/packages/video_player
 */
class YlVideoPlayer extends StatefulWidget {
  final String playUrl;
  final bool isAutoPlay;

  const YlVideoPlayer({
    Key key,
    @required this.playUrl,
    this.isAutoPlay = false,
  }) : super(key: key);

  @override
  _YlVideoPlayerState createState() => _YlVideoPlayerState();
}

class _YlVideoPlayerState extends State<YlVideoPlayer>
    with TickerProviderStateMixin {
  VideoPlayerController _videoController;
  String _curTime;

  // int _curSlideVal;

  /// 倍速
  static const _playBackRates = [
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    2.0,
  ];

  bool _isMuted;
  double _curVideoVolume;
  AnimationController _playOrPauseController;

  /// 字幕文件closedCaptionFile: _loadCaptions(),
  // Future<ClosedCaptionFile> _loadCaptions() async {
  //   final String fileContents = await DefaultAssetBundle.of(context)
  //       .loadString('assets/bumble_bee_captions.srt');
  //   return SubRipCaptionFile(fileContents);
  // }

  handleInitVideoPlayer() async {
    _videoController = VideoPlayerController.network(
      widget.playUrl,
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
      ),
    );
    _videoController.addListener(() {
      setState(() {
        //   _curSlideVal = _videoController.value.position.inMilliseconds;
        _curTime =
            "${_videoController.value.position.inMinutes.toString().padLeft(2, "0")}:${(_videoController.value.position.inSeconds % 60).toString().padLeft(2, "0")}";
      });
    });
    _videoController.setLooping(true);
    await _videoController.initialize();
    if (widget.isAutoPlay) {
      _videoController.play();
    }
  }


  @override
  void initState() {
    super.initState();
    handleInitVideoPlayer();
    if (_videoController.value.volume == 0.0) {
      _isMuted = true;
    } else {
      _isMuted = false;
    }
    _curVideoVolume = _videoController.value.volume;
    _playOrPauseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _playOrPauseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoController.value.isInitialized
        ? AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(_videoController),
              /// 字幕文件
              ClosedCaption(text: _videoController.value.caption.text),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10.0,
                      sigmaY: 10.0,
                    ),
                    child: Container(
                      width: 1.sw,
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 5.w,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _videoController.value.isPlaying
                                  ? _videoController.pause()
                                  : _videoController.play();
                            },
                            child: Container(
                              width: 30.r,
                              height: 30.r,
                              margin: EdgeInsets.only(
                                right: 5.w,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                              child: AnimatedIcon(
                                icon: _videoController.value.isPlaying
                                    ? AnimatedIcons.pause_play
                                    : AnimatedIcons.play_pause,
                                progress: _playOrPauseController,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: Text(
                              _curTime,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontFamily: 'YinLei'),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: VideoProgressIndicator(
                              _videoController,
                              allowScrubbing: true,
                              colors: VideoProgressColors(
                                playedColor: AppColors.ylPrimaryColor,
                              ),
                            ),
                            // child: SliderTheme(
                            //   data: SliderTheme.of(context).copyWith(
                            //     activeTrackColor: Colors.grey[200],
                            //     inactiveTrackColor: Colors.grey[700],
                            //     thumbColor: Colors.grey[100],
                            //     trackHeight: 2.h,
                            //     thumbShape: RoundSliderThumbShape(
                            //       enabledThumbRadius: 10.r,
                            //     ),
                            //     overlayColor: Colors.white.withAlpha(32),
                            //     overlayShape: RoundSliderOverlayShape(
                            //       overlayRadius: 20.r,
                            //     ),
                            //   ),
                            //   child: Slider(
                            //     min: 0,
                            //     max: _videoController.value.duration.inMilliseconds.toDouble(),
                            //     value: _curSlideVal.toDouble(),
                            //     label: "啊啊",
                            //     activeColor: Colors.white,
                            //     divisions: _videoController.value.duration.inMilliseconds,
                            //     onChanged: (value) async {
                            //       await _videoController.seekTo(Duration(milliseconds: value.ceil()));
                            //     },
                            //   ),
                            // ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text(
                              "${_videoController.value.duration.inMinutes.toString().padLeft(2, "0")}:${(_videoController.value.duration.inSeconds % 60).toString().padLeft(2, "0")}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontFamily: 'YinLei'),
                            ),
                          ),
                          PopupMenuButton<double>(
                            initialValue:
                                _videoController.value.playbackSpeed,
                            tooltip: '倍速',
                            onSelected: (speed) {
                              _videoController.setPlaybackSpeed(speed);
                            },
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
                                '${_videoController.value.playbackSpeed}x',
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            itemBuilder: (context) {
                              return [
                                for (final speed in _playBackRates)
                                  PopupMenuItem(
                                    value: speed,
                                    child: Text('${speed}x'),
                                  )
                              ];
                            },
                          ),
                          Container(
                            width: 30.r,
                            height: 30.r,
                            margin: EdgeInsets.only(left: 5.w),
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: _isMuted
                                  ? Icon(
                                      Icons.volume_off,
                                      size: 14.ssp,
                                    )
                                  : Icon(
                                      Icons.volume_up,
                                      size: 14.ssp,
                                    ),
                              color: Colors.white,
                              onPressed: () {
                                ///改变音量
                                _isMuted = !_isMuted;
                                if (_isMuted) {
                                  _videoController.setVolume(0.0);
                                } else {
                                  _videoController
                                      .setVolume(_curVideoVolume);
                                }
                              },
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(100, 80, 80, 80),
                            ),
                          ),
                          Container(
                            width: 30.r,
                            height: 30.r,
                            margin: EdgeInsets.only(left: 5.w),
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: Icon(
                                Icons.download_rounded,
                                size: 14.ssp,
                              ),
                              color: Colors.white,
                              onPressed: () async {
                                ///下载视频
                                var appDocDir = await getTemporaryDirectory();
                                String savePath = appDocDir.path + widget.playUrl.substring(widget.playUrl.lastIndexOf("/"));
                                // print(widget.playUrl.substring(widget.playUrl.lastIndexOf("/")));
                                await Dio().download(widget.playUrl, savePath);
                                final result = await ImageGallerySaver.saveFile(savePath);
                                appShowToast(msg: '已保存，请查看手机相册');
                              },
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(100, 80, 80, 80),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        : Text('waiting for video to load');
  }
}
