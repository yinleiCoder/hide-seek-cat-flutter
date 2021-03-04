import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_screenutil/size_extension.dart';

/**
 * 广场中的动态tab页
 * @author yinlei
*/
class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  Widget _buildRecommendTopics({topicImg, userAvatar, userName}) {
    return AspectRatio(
      aspectRatio: 2 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(
              topicImg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.1),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white, width: 3.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor,
                          offset: Offset(5, 10),
                          blurRadius: 16,
                        )
                      ],
                      image: DecorationImage(
                        image: NetworkImage(userAvatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    userName,
                    style: ylCommonTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtherUsersPuslishedPost({userName, userAvatar, publishTime, publishText, publishImage}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(userAvatar, width: 48.r, height: 48.r, fit: BoxFit.cover,
                      ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          userName,
                          style: ylCommonTextStyle.copyWith(
                            fontSize: 16.ssp,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                          publishTime,
                          style: ylCommonTextStyle.copyWith(
                            color: Colors.grey,
                          ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.more_horiz, size: 30.ssp,),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(publishText),
          SizedBox(
            height: 20.h,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(publishImage, height: 200.h,width: 1.sw, fit: BoxFit.cover,),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 25.r,
                    height: 25.r,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(Icons.favorite, size: 12.ssp, color: Colors.white,),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-5,0),
                    child: Container(
                      width: 25.r,
                      height: 25.r,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(Icons.thumb_up, size: 12.ssp, color: Colors.white,),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  Text(
                    '2.1w'
                  ),
                ],
              ),
              Text(
                  '821条评论'
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAreaTitle({areaTitle, moreDetail, isSqure=false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Container(
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Row(
              children: [
                Text(
                  areaTitle,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.ssp,
                    letterSpacing: 1.2,
                  ),
                ),
                isSqure ? Icon(AppIconfont.square, color: AppColors.primaryColor,) : Container(),
              ],
            ),
            moreDetail != null ? FlatButton.icon(
              icon: Icon(Icons.more_horiz),
              onPressed: (){},
              label: Text(moreDetail),
            ) : Container(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAreaTitle(areaTitle: '每日躲猫猫话题精选', moreDetail: '更多话题'),
          Container(
            height: 180.h,
            width: 1.sw,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: PageController(
                keepPage: true,
                viewportFraction: 0.9,
              ),
              children: [
                _buildRecommendTopics(topicImg: 'https://img.zcool.cn/community/017a1f600e370b11013f7928ee1196.jpg@1280w_1l_2o_100sh.jpg', userAvatar: 'https://img.zcool.cn/community/0133995c63a554a801203d223f3f17.jpg@520w_390h_1c_1e_1o_100sh.jpg', userName: '尹哥'),
                _buildRecommendTopics(topicImg: 'https://img.zcool.cn/community/01fb0060137f3811013f79281d481f.jpg@1280w_1l_2o_100sh.jpg', userAvatar: 'https://img.zcool.cn/community/0133995c63a554a801203d223f3f17.jpg@520w_390h_1c_1e_1o_100sh.jpg', userName: '张明'),
                _buildRecommendTopics(topicImg: 'https://img.zcool.cn/community/0100bb5fa3aeb911013fdcc78b065a.jpg@1280w_1l_2o_100sh.jpg', userAvatar: 'https://img.zcool.cn/community/0133995c63a554a801203d223f3f17.jpg@520w_390h_1c_1e_1o_100sh.jpg', userName: '宋阳'),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          _buildAreaTitle(areaTitle: '广场', isSqure: true),
          ListView.separated(
            itemCount: 20,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            separatorBuilder: (context, position) => Divider(),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return   _buildOtherUsersPuslishedPost(userName: '尹哥', userAvatar: 'https://img.zcool.cn/community/0133995c63a554a801203d223f3f17.jpg@520w_390h_1c_1e_1o_100sh.jpg', publishTime: '1小时前', publishText: '美女作为礼物给你🎁，你喜欢吗？', publishImage: 'https://img.zcool.cn/community/01fb0060137f3811013f79281d481f.jpg@1280w_1l_2o_100sh.jpg');
            },
          ),
        ],
      ),
    );
  }
}
