import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hide_seek_cat/common/values/colors.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'dart:ui' as ui;

/// define a point touched at canvas
class TouchPoints{
  Paint paint;
  Offset points;
  TouchPoints({this.points, this.paint});
}

/**
 * 涂鸦
 * 权限处理：https://pub.dev/packages/permission_handler
 * 保存图片到相册：https://pub.dev/packages/image_gallery_saver
 * @author yinlei
 */
class GraffitiPage extends StatefulWidget {
  @override
  _GraffitiPageState createState() => _GraffitiPageState();
}

class _GraffitiPageState extends State<GraffitiPage> with AutomaticKeepAliveClientMixin<GraffitiPage> {
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();

  /// graffit
  File _image;
  final picker = ImagePicker();
  List<TouchPoints> _points = [];
  double _opacity = 1.0;
  StrokeCap _strokeType = StrokeCap.round;
  double _strokeWidth = 3.0;
  GlobalKey _repaintKey = GlobalKey();
  /// color filter
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  /// 解决setstate不能及时刷新的问题
  PersistentBottomSheetController _controller;
  Color _paintColor = Colors.black;
  List<Color> _allPaintColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.white,
    Colors.black,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.brown,
    Colors.transparent,
    Colors.grey,
  ];

  Future _handleSelectImg() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        appShowToast(msg: "No image selected");
      }
    });
  }

  handleSavePaintToImg() async {
    RenderRepaintBoundary boundary = _repaintKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(pngBytes),
      name: "${DateTime.now().millisecondsSinceEpoch}",
    );
    appShowToast(msg: "保存成功，请到相册查看");
  }

  Widget _buildPaintFloatActionButton() {
    return AnimatedFloatingActionButton(
      key: fabKey,
      fabButtons: <Widget>[
        FloatActionButtonText(
          onPressed: () {
            fabKey.currentState.animate();
            showDialog<void>(
              context: context,
              barrierDismissible: true, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.settings_backup_restore,
                        ),
                        onPressed: () {
                          _strokeWidth = 3.0;
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.brush,
                          size: 24,
                        ),
                        onPressed: () {
                          _strokeWidth = 10.0;
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.brush,
                          size: 40,
                        ),
                        onPressed: () {
                          _strokeWidth = 20.0;
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.brush,
                          size: 60,
                        ),
                        onPressed: () {
                          _strokeWidth = 30.0;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: Icons.brush,
          text: "画笔",
        ),
        FloatActionButtonText(
          onPressed: () {
            fabKey.currentState.animate();
            showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.rounded_corner,
                          size: 40,
                        ),
                        onPressed: () {
                          _strokeType = StrokeCap.round;
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.crop_square,
                          size: 40,
                        ),
                        onPressed: () {
                          _strokeType = StrokeCap.square;
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.square_foot,
                          size: 40,
                        ),
                        onPressed: () {
                          _strokeType = StrokeCap.butt;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: Icons.carpenter,
          text: "画笔笔头形状",
        ),
        FloatActionButtonText(
          onPressed: () async {
            fabKey.currentState.animate();
            _controller = _scaffoldKey.currentState.showBottomSheet(
                  (context) {
                return Container(
                  width: 1.sw,
                  height: 350.h,
                  color: Colors.white54,
                  padding: EdgeInsets.all(10.r),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50.h,
                              width: 200.w,
                              color: _paintColor,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => _controller.close(),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _allPaintColors.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 5.0,
                        ),
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: () {
                              _controller.setState((){
                                _paintColor = _allPaintColors[index];
                              });
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: _allPaintColors[index],
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _allPaintColors[index],
                                      offset: Offset(5, 6),
                                      blurRadius: 16,
                                    ),
                                  ]
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            );
          },
          childBgColor: _paintColor,
          text: "颜色选择",
        ),
        FloatActionButtonText(
          onPressed: () {
            fabKey.currentState.animate();
            showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                //Clips its child in a oval shape
                return AlertDialog(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.opacity,
                          size: 24,
                        ),
                        onPressed: () {
                          //most transparent
                          _opacity = 0.1;
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.opacity,
                          size: 40,
                        ),
                        onPressed: () {
                          _opacity = 0.5;
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.opacity,
                          size: 60,
                        ),
                        onPressed: () {
                          //not transparent at all.
                          _opacity = 1.0;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: Icons.opacity,
          text: "透明度",
        ),
        FloatActionButtonText(
          onPressed: () {
            fabKey.currentState.animate();
            setState(() {
              _points.clear();
              _image = null;
            });
          },
          icon: Icons.cleaning_services_rounded,
          text: "清除画布",
        ),
        FloatActionButtonText(
          onPressed: () {
            fabKey.currentState.animate();
            setState(() {
              if(_points.length > 10){
                _points.removeRange(_points.length - 11, _points.length - 1);
              } else if(_points.length > 0) {
                _points.removeLast();
              }
            });
          },
          icon: Icons.redo_rounded,
          text: "撤销到上一步",
        ),
        FloatActionButtonText(
          onPressed: () async {
            fabKey.currentState.animate();
            await _handleSelectImg();
          },
          icon: Icons.photo,
          text: "从相册中选择图片涂鸦",
        ),
        FloatActionButtonText(
          onPressed: () {
            fabKey.currentState.animate();
            setState(() {
              handleSavePaintToImg();
            });
          },
          icon: Icons.save,
          text: "保存为图片到相册",
        ),
      ],
      colorStartAnimation: Colors.deepPurpleAccent,
      colorEndAnimation: AppColors.ylPrimaryColor,
      animatedIconData: AnimatedIcons.menu_close,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onPanUpdate: (details) {
          // print(_points.length);
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            _points.add(TouchPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = _strokeType
                  ..isAntiAlias = true
                  ..color = _paintColor.withOpacity(_opacity)
                  ..strokeWidth = _strokeWidth));
          });
        },
        onPanStart: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            _points.add(TouchPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = _strokeType
                  ..isAntiAlias = true
                  ..color = _paintColor.withOpacity(_opacity)
                  ..strokeWidth = _strokeWidth));
          });
        },
        onPanEnd: (details) {
          setState(() {
            _points.add(null);
          });
        },
        child: RepaintBoundary(
          key: _repaintKey,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              _image == null ?
                  Container(
                      color: Colors.white,
                  )
                : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(_image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              CustomPaint(
                size: Size.infinite,
                painter: MyPainter(
                  pointsList: _points,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildPaintFloatActionButton(),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }

}

/// 自定义涂鸦画笔
class MyPainter extends CustomPainter {
  /// 追踪触摸屏幕的点
  List<TouchPoints> pointsList;

  List<Offset> offsetPoints = [];

  MyPainter({this.pointsList});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        //Drawing line when two consecutive points are available
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));

        //Draw points when two points are not next to each other
        canvas.drawPoints(
            ui.PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}
