import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 开支助手小卡片
 * @author yinlei
*/
class CardView extends StatefulWidget {
  final CardModel card;

  const CardView({Key key, this.card}) : super(key: key);
  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.only(right: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage('https://img.zcool.cn/community/01506f606431ab11013fb11722cf96.jpg@1280w_1l_2o_100sh.jpg')
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent.withOpacity(.6),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(-15, 0),
                          child: Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.withOpacity(.6),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(widget.card.available.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 30.ssp,),),
                        Text('￥', style: TextStyle(color: Colors.white, letterSpacing: 1.5,)),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(widget.card.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5,)),
                    ),
                    SizedBox(height: 10.h,),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(widget.card.number, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,letterSpacing: 10, fontSize: 20.ssp,),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
