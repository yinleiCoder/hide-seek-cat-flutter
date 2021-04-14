import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/widgets/toast.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
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
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          InteractiveViewer(
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
          Positioned(
            right: 10.w,
            bottom: 22.h,
            child: Container(
              width: 50.r,
              height: 50.r,
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.download_rounded,
                  size: 20.ssp,
                ),
                color: Colors.white,
                onPressed: () async {
                  ///下载图片
                  var response = await Dio().get(imgUrl, options: Options(responseType: ResponseType.bytes));
                  final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 60, name: imgUrl.substring(imgUrl.lastIndexOf("/") + 1));
                  appShowToast(msg: "保存成功，请到相册查看");
                },
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(100, 80, 80, 80),
              ),
            ),
          ),
          Positioned(
            left: 10.w,
            top: 22.h,
            child: IconButton(
              icon: Icon(Icons.arrow_drop_down_circle_rounded, color: Colors.white,),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

