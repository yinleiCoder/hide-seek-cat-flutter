import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/global.dart';

/**
 * 时讯页
 */
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with AutomaticKeepAliveClientMixin<NewsPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('时讯'),
        centerTitle: false,
      ),
      body: Center(
        child: Text(
          AppGlobal.profile.user.avatar_url,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
