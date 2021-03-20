import 'package:flutter/material.dart';

/**
 * 时讯页
 */
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with AutomaticKeepAliveClientMixin<NewsPage> {
  int a;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: IconButton(
        icon: Icon(Icons.share),
        onPressed: (){
          a++;
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
