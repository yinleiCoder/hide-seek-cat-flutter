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

class _ChatPageState extends State<ChatPage> with AutomaticKeepAliveClientMixin {

  Future _future;
  String dropdownValue = '添加朋友';
  List<String> avaiableMenuItems = ['添加朋友', '扫一扫',];
  List<Message> allMessages = [];


  @override
  void initState() {
    super.initState();
    _future = _loadAllData();
  }

  Future<List<Message>> _loadAllData() async {
    return await UserApi.allfriendLatestMessages(context: context, uid: AppGlobal.profile.user.uid);
    // if(mounted) {
    //   setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('叮叮叮,恋爱铃为您敲响🔔'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: DropdownButton(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              underline: null,
              onChanged: (String newValue) {
                switch(avaiableMenuItems.indexOf(newValue)){
                  case 0:
                    appShowToast(msg: '添加好友');
                    break;
                  case 1:
                    appShowToast(msg: '扫一扫');
                    break;
                }
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: avaiableMenuItems
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                .toList(),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          Widget child;
          if(snapshot.hasData) {
            allMessages = snapshot.data;
            child = ReorderableListView(
              header: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 5.r),
                child: Text('好友消息', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.ssp,),),),
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final Message item = allMessages.removeAt(oldIndex);
                  allMessages.insert(newIndex, item);
                });
              },
              children: [
                for(final item in allMessages)
                    ChatCard(
                      key: ValueKey(item),
                      chat: item,
                      onTap: () => Navigator.pushNamed(context, ChatMessagePage.routeName, arguments: item.from),
                    ),
              ],
            );
          }else if(snapshot.hasError) {
            child = Text('发生未知出错啦！');
          }else {
            child = Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 40.r,
                height: 40.r,
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: child,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// 聊天人卡片
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

