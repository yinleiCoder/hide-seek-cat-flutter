import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/colors.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:flutter_hide_seek_cat/pages/chat/chat_message_page.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 聊天记录页
 * @author yinlei
 */
class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<Message> allMessages;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  _loadAllData() async {
    allMessages = await UserApi.allfriendLatestMessages(context: context, uid: AppGlobal.profile.user.uid);
    setState(() {});

    if(mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息列表'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //
      //   },
      //   backgroundColor: AppColors.ylPrimaryColor,
      //   child: Icon(Icons.person_add_alt_1, color: Colors.white,),
      // ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            color: AppColors.ylPrimaryColor,
          ),
          Expanded(
            child: allMessages == null ? appCardPageDarkSkeleton() : ListView.builder(
              itemCount: allMessages?.length,
              itemBuilder: (context, index) => ChatCard(
                chat: allMessages[index],
                onTap: () => Navigator.pushNamed(context, ChatMessagePage.routeName, arguments: allMessages[index].from),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  final Message chat;
  final GestureTapCallback onTap;
  const ChatCard({Key key, @required this.chat,@required this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
              chat.from.avatar_url,
            ),
          ),
          if(true)Positioned(
            left: -2,
            top: -2,
            child: Container(
              height: 16.r,
              width: 16.r,
              decoration: BoxDecoration(
                color: AppColors.ylPrimaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 3,
                )
              ),
            ),
          ),
        ],
      ),
      title: Text(
        chat.from.name,
      ),
      subtitle: Opacity(
        opacity: 0.7,
        child: Text(
          chat.content,
          style: TextStyle(color: Theme.of(context).textTheme.bodyText2.color,),
        ),
      ),
      trailing: Opacity(
        opacity: 0.64,
        child: Text(
          ylTimeFormat(DateTime.parse(chat.createdAt)),
        ),
      ),
    );
  }
}

