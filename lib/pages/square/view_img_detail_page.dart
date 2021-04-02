import 'package:flutter/material.dart';

/**
 * 查看图片详情，通过缩放的方式InteractiveViewer
 * 类似photo_viewer包
 * [注意]： Android模拟器模拟双指手势通过ctrl + 鼠标
 * @author yinlei
*/
class ViewDetailPage extends StatelessWidget {
  static String routeName = '/view_img_detail_page';
  final String imgUrl;

  const ViewDetailPage({Key key, this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
            boundaryMargin: EdgeInsets.zero,
            minScale: 0.8,
            maxScale: 2.5,
            onInteractionStart: (ScaleStartDetails details) {
              print(details.toString());
            },
            onInteractionUpdate: (ScaleUpdateDetails details){
              print(details.toString());
            },
            onInteractionEnd: (ScaleEndDetails details) {
              print(details.toString());
            },
            child: Image.network(
              imgUrl,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                if (loadingProgress == null)
                  return child;
                return Center(
                  child: LinearProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            ),
        ),
      ),
    );
  }
}

