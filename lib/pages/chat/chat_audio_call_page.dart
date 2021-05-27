import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 音频聊天 采用webRTC
 * @author yinlei
 */
class ChatAudioCallPage extends StatefulWidget {
  static String routeName = '/chat_audio_call_page';
  final User friend;

  const ChatAudioCallPage({Key key, this.friend}) : super(key: key);

  @override
  _ChatAudioCallPageState createState() => _ChatAudioCallPageState();
}

class _ChatAudioCallPageState extends State<ChatAudioCallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image.network(widget.friend.avatar_url, fit: BoxFit.cover,),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            child: SafeArea(
              child: SizedBox(
                width: 1.sw,
                child: Row(
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
                          child: Icon(Icons.keyboard_voice, color: Colors.white,),
                        ),
                        Text('静音', style: TextStyle(color: Colors.white),),
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
                          child: Icon(Icons.volume_up, color: Colors.white,),
                        ),
                        Text('免提', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 192.r,
                    height: 192.r,
                    padding: EdgeInsets.all(25.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.09),
                          Colors.white.withOpacity(0.12),
                        ],
                        stops: [0.5, 1],
                      ),
                    ),
                    child: ClipOval(child: Image.network(widget.friend.avatar_url, fit: BoxFit.cover,)),
                  ),
                  SizedBox(height: 15.h,),
                  Text(widget.friend.name, style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white, fontWeight: FontWeight.bold,),),
                  SizedBox(height: 10.h,),
                  Text('通话时长 00:01', style: TextStyle(color: Colors.white60, fontFamily: 'YinLei'),),
                ],
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
        ],
      ),
    );
  }
}
