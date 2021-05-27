import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 视频聊天 采用webRTC
 * @author yinlei
 */
class ChatVideoCallPage extends StatefulWidget {
  static String routeName = '/chat_video_call_page';
  final User friend;
  const ChatVideoCallPage({Key key, this.friend}) : super(key: key);

  @override
  _ChatVideoCallPageState createState() => _ChatVideoCallPageState();
}

class _ChatVideoCallPageState extends State<ChatVideoCallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network('https://img.zcool.cn/community/014f9960ab524d11013f47202d4365.jpg@520w_390h_1c_1e_2o_100sh.jpg', fit: BoxFit.cover,),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: YlTips(tipContent: '对方可能无法接听，建议稍后再次尝试'),
          ),
          Positioned(
            bottom: 20.h,
            child: SafeArea(
              child: SizedBox(
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('00:22', style: TextStyle(color: Colors.white, fontSize: 18.ssp,),),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color.fromARGB(100, 80, 80, 80),
                                shape: CircleBorder(),
                              ),
                              onPressed: () {},
                              child: Icon(Icons.phone_callback, color: Colors.white,),
                            ),
                            Text('切到语音通话', style: TextStyle(color: Colors.white),),
                          ],
                        ),
                        Column(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: CircleBorder(),
                              ),
                              onPressed: () {},
                              child: Icon(Icons.call_end, color: Colors.white,),
                            ),
                            Text('挂断', style: TextStyle(color: Colors.white),),
                          ],
                        ),
                        Column(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color.fromARGB(100, 80, 80, 80),
                                shape: CircleBorder(),
                              ),
                              onPressed: () {},
                              child: Icon(Icons.camera_alt, color: Colors.white,),
                            ),
                            Text('转换摄像头', style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: SafeArea(
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.close_fullscreen, color: Colors.white,),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 5.w,
            child: SafeArea(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 0.42.sw,
                  height: 0.32.sh,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.friend.avatar_url,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
