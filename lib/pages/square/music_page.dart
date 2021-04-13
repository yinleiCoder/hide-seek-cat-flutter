import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 音乐专区
 * @author yinlei
 */
class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: ListView(
        children: [
          Text('热门音乐推荐', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5, color: AppColors.ylPrimaryColor, fontSize: 20.ssp,),),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network('https://img.zcool.cn/community/017f7260574f8411013e87f4fb0fab.jpg@1280w_1l_2o_100sh.jpg')),
                Text(' 啊啊'),
                Text('作者'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('热门音乐列表', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5, color: AppColors.ylPrimaryColor, fontSize: 20.ssp,),),
              Icon(Icons.local_fire_department, color: Colors.redAccent,),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 16 / 9,
            children: [
              Container(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network('https://img.zcool.cn/community/017f7260574f8411013e87f4fb0fab.jpg@1280w_1l_2o_100sh.jpg'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        '啦啊啊',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.favorite,),
                          Spacer(),
                          Icon(Icons.more_horiz,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
