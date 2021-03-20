import 'package:flutter/material.dart';

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
    return Center(
      child: Text('时讯'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
