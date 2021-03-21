import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/chat_message.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/values/colors.dart';
import 'package:flutter_screenutil/size_extension.dart';

/**
 * 和好友即时通讯页
 * @author yinlei
 */
class ChatMessagePage extends StatefulWidget {
  static String routeName = '/chat_with_friend';

  @override
  _ChatMessagePageState createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            BackButton(),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://img.zcool.cn/community/0103a15d70b2b6a801202f17a508ee.jpg@1280w_1l_2o_100sh.jpg'
              ),
            ),
            SizedBox(width: 15.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '陈爽(媳妇儿)',
                  style: TextStyle(
                    fontSize: 16.ssp,
                  ),
                ),
                Text(
                  '3分钟前在线',
                  style: TextStyle(
                    fontSize: 12.ssp,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.local_phone),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.videocam),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: ListView.builder(
                itemCount: demeChatMessages.length,
                itemBuilder: (context, index) => Message(
                  message: demeChatMessages[index],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            decoration: ShapeDecoration(
              shadows: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 32,
                    color: Color(0xFF087949).withOpacity(0.3),
                  ),
              ],
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(14.r), topRight: Radius.circular(14.r)),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Icon(Icons.mic, color: AppColors.ylPrimaryColor,),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Container(
                      height: 50.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: AppColors.ylPrimaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.sentiment_satisfied_alt_outlined, color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8),),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Type message',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Icon(Icons.attach_file, color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8),),
                          SizedBox(width: 10.w,),
                          Icon(Icons.camera_alt_outlined, color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  final ChatMessage message;

  const Message({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget messageTypeChoose(ChatMessage message) {
      switch(message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
          break;
        case ChatMessageType.audio:
          return AudioMessage(message: message);
          break;
        case ChatMessageType.video:
          return VideoMessage(message: message);
          break;
        case ChatMessageType.image:
          return ImageMessage(message: message);
          break;
        default:
          return SizedBox();
      }
    }
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(!message.isSender) ...{
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://img.zcool.cn/community/0103a15d70b2b6a801202f17a508ee.jpg@1280w_1l_2o_100sh.jpg'
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          },
          messageTypeChoose(message),
          if(message.isSender) MessageStatusDot(status: message.messageStatus,),
        ],
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  final ChatMessage message;

  const TextMessage({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.ylPrimaryColor.withOpacity(message.isSender ? 1 : 0.1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: message.isSender ? Colors.white : Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
    );
  }
}

class AudioMessage extends StatelessWidget {
  final ChatMessage message;

  const AudioMessage({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.ylPrimaryColor.withOpacity(message.isSender ? 1 : 0.1),
      ),
      child: Row(
        children: [
          Icon(Icons.play_arrow, color: message.isSender ? Colors.white : AppColors.ylPrimaryColor,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2.h,
                    color: message.isSender ? Colors.white : AppColors.ylPrimaryColor.withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        color: message.isSender ? Colors.white : AppColors.ylPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
              '0.37',
            style: TextStyle(
              fontSize: 12.ssp,
              color: message.isSender ? Colors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoMessage extends StatelessWidget {
  final ChatMessage message;

  const VideoMessage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network("https://img.zcool.cn/community/01dbf75f36974ca80120a8214358d2.jpg@1280w_1l_2o_100sh.jpg", fit: BoxFit.cover,),
            ),
          ),
          Container(
            width: 30.r,
            height: 30.r,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_arrow, size: 18.ssp, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class ImageMessage extends StatelessWidget {
  final ChatMessage message;

  const ImageMessage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusDot({Key key, @required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch(status) {
        case MessageStatus.not_sent:
          return AppColors.ylErrorColor;
          break;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1.color.withOpacity(0.1);
          break;
        case MessageStatus.viewed:
          return AppColors.ylPrimaryColor;
          break;
        default:
          return Colors.transparent;
      }
    }
    return Container(
      margin: EdgeInsets.only(left: 10.w),
      width: 12.r,
      height: 12.r,
      decoration: BoxDecoration(
        color: dotColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8.ssp,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}




