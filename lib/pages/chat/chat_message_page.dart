import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/colors.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/chat/chat_audio_call_page.dart';
import 'package:flutter_hide_seek_cat/pages/chat/chat_video_call_page.dart';
import 'package:flutter_hide_seek_cat/pages/videos/video_player_page.dart';
import 'package:flutter_screenutil/size_extension.dart';


/**
 * 和好友即时通讯页
 * @author yinlei
 */
class ChatMessagePage extends StatefulWidget {
  static String routeName = '/chat_with_friend';
  final User friend;

  const ChatMessagePage({Key key, @required this.friend}) : super(key: key);

  @override
  _ChatMessagePageState createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> with TickerProviderStateMixin{

  List<Message> allHistoryMessages;
  TextEditingController _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = TextEditingController();
    _loadAllData();
    AppSocketIo().socket.on('chat_text', _handleReceiveMsg);
  }

  _loadAllData() async {
    allHistoryMessages = await UserApi.historyChatMessages(context: context, uid: AppGlobal.profile.user.uid, fid: widget.friend.uid);
    for(int i =0; i< allHistoryMessages.length;i++) {
      allHistoryMessages[i].animationController = AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      );
      allHistoryMessages[i].animationController.forward();
    }
    allHistoryMessages.add(Message(
      from: AppGlobal.profile.user,
      to: widget.friend,
      type: 1,
      state: 1,
      messageStatus: MessageStatus.not_view,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
    ));
    allHistoryMessages.add(Message(
      from: AppGlobal.profile.user,
      to: widget.friend,
      type: 2,
      state: 1,
      messageStatus: MessageStatus.not_view,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
    ));
    setState(() {});

    if(mounted) {
      setState(() {});
    }
  }

  _handleSubmitted(String text){
    _chatController.clear();
    Message message = Message(
      from: AppGlobal.profile.user,
      to: widget.friend,
      content: text,
      type: 0,
      state: 1,
      messageStatus: MessageStatus.not_view,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      allHistoryMessages.insert(0, message);
    });
    message.animationController.forward();
    AppSocketIo().socket.emit('chat_text', [text, AppGlobal.profile.user.uid, widget.friend.uid]);
  }

  _handleReceiveMsg(data) {
    print('接收到了：${data} ');
    print('来自：${widget.friend.uid} 接收者：${AppGlobal.profile.user.uid} ');
    Message message = Message(
      from: widget.friend,
      to: AppGlobal.profile.user,
      content: data[0],
      type: 0,
      state: 1,
      messageStatus: MessageStatus.viewed,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    if (!mounted) return;
    setState(() {
      allHistoryMessages.insert(0, message);
    });
    message.animationController.forward();
  }

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
                  widget.friend.avatar_url,
              ),
            ),
            SizedBox(width: 15.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.friend.name,
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
            onPressed: () => Navigator.pushNamed(context, ChatAudioCallPage.routeName, arguments: widget.friend),
            icon: Icon(Icons.local_phone),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, ChatVideoCallPage.routeName, arguments: widget.friend),
            icon: Icon(Icons.videocam),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: allHistoryMessages == null ? Text('load....') : Scrollbar(
              isAlwaysShown: true,
              showTrackOnHover: true,
              child: ListView.builder(
                itemCount: allHistoryMessages?.length,
                reverse: true,
                itemBuilder: (context, index) => MessageCard(
                  message: allHistoryMessages[index],
                  isSender: allHistoryMessages[index].from.uid == AppGlobal.profile.user.uid,
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
                    color: Color(0xFFFF59B2).withOpacity(0.3),
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
                                hintText: '',
                                border: InputBorder.none,
                              ),
                              controller: _chatController,
                              textInputAction: TextInputAction.send,
                              onSubmitted: _handleSubmitted,
                            ),
                          ),
                          Icon(Icons.attach_file, color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8),),
                          SizedBox(width: 10.w,),
                          IconButton(
                            icon: Icon(Icons.camera_alt_outlined, color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.8),),
                            onPressed: (){

                            },
                          ),
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

  @override
  void dispose() {
    _chatController.dispose();
    for(Message message in allHistoryMessages) {
      message.animationController?.dispose();
    }
    super.dispose();
  }

}

/**
 * 聊天消息卡片
 */
class MessageCard extends StatelessWidget {
  final Message message;
  final isSender;

  const MessageCard({Key key, @required this.message, @required this.isSender}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget messageTypeChoose(Message message, bool isSender) {
      switch(message.type) {
        case 0:
          return TextMessage(message: message, isSender: isSender);
          break;
        case 1:
          return AudioMessage(message: message, isSender: isSender);
          break;
        case 2:
          return VideoMessage(message: message, isSender: isSender);
          break;
        case 3:
          return ImageMessage(message: message, isSender: isSender);
          break;
        default:
          return SizedBox();
      }
    }
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(message.from.uid != AppGlobal.profile.user.uid) ...{
            SizedBox(width: 10.w,),
            CircleAvatar(
              backgroundImage: NetworkImage(
                message.from.avatar_url,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          },
          messageTypeChoose(message, isSender),
          if(isSender) MessageStatusDot(status: message.messageStatus,),
          SizedBox(width: 10.w,),
        ],
      ),
    );
  }
}

/// 普通文本消息
class TextMessage extends StatelessWidget {
  final Message message;
  final bool isSender;

  const TextMessage({Key key, @required this.message, this.isSender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: message.animationController,
        curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 0.65.sw,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.ylPrimaryColor.withOpacity(isSender ? 1 : 0.1),
          ),
          child: SelectableText(
            message.content,
            showCursor: true,
            onTap: () => appShowToast(msg: '您拍了拍"${message.content}"'),
            style: TextStyle(
              color: isSender ? Colors.white : Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
        ),
      ),
    );
  }
}

/// 语音消息
class AudioMessage extends StatelessWidget {
  final Message message;
  final bool isSender;

  const AudioMessage({Key key, @required this.message, this.isSender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 0.65.sw,
      ),
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.ylPrimaryColor.withOpacity(isSender ? 1 : 0.1),
      ),
      child: Row(
        children: [
          Icon(Icons.play_arrow, color: isSender ? Colors.white : AppColors.ylPrimaryColor,),
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
                    color: isSender ? Colors.white : AppColors.ylPrimaryColor.withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        color: isSender ? Colors.white : AppColors.ylPrimaryColor,
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
              color: isSender ? Colors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}

/// 视频消息
class VideoMessage extends StatelessWidget {
  final Message message;
  final bool isSender;

  const VideoMessage({Key key, this.message, this.isSender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(VideoPlayerPage.routeName, arguments: 'http://oss-cn-beijing.aliyuncs.com/static-thefair-bj/eyepetizer/pgc_video/video_summary/213190.mp4'),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  "https://img.zcool.cn/community/0116bd60ad246211013f4720455937.jpg@1280w_1l_2o_100sh.jpg",
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null)
                      return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                  },
                ),
              ),
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

/// 图片消息
class ImageMessage extends StatelessWidget {
  final Message message;
  final bool isSender;

  const ImageMessage({Key key, this.message, this.isSender}) : super(key: key);

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




