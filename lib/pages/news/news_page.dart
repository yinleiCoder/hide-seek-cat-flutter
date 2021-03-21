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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('时讯'),
        centerTitle: false,
      ),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.share),
          onPressed: (){
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
