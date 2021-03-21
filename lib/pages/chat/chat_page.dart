import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/values/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('躲猫猫'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: AppColors.ylPrimaryColor,
        child: Icon(Icons.person_add_alt_1, color: Colors.white,),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            color: AppColors.ylPrimaryColor,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ChatCard(
                chat: chatsData[index],
                onTap: () => Navigator.pushNamed(context, ChatMessagePage.routeName),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  final Chat chat;
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
              chat.avatar_url,
            ),
          ),
          if(chat.isActive)Positioned(
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
        chat.name,
      ),
      subtitle: (MediaQuery.of(context).platformBrightness == Brightness.light) ? Text(
        chat.lastMessage,
      ) : Text(
        chat.lastMessage,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: Opacity(
        opacity: 0.64,
        child: Text(
          chat.time,
        ),
      ),
    );
  }
}

