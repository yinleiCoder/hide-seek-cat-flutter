import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/pages/square/post_detail_page.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 帖子卡片
 * @author yinlei
*/
Widget ylPostCard({context, uid, userName, userAvatar, publishTime, publishTitle, publishText, publishImage, List<Topic> topics}) {
  return GestureDetector(
    onTap: () => Navigator.of(context).pushNamed(PostDetailPage.routeName, arguments: uid),
    child: Card(
      margin: EdgeInsets.only(bottom: 22.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                publishImage,
                width: 1.sw,
                fit: BoxFit.cover,
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
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Text(
                        publishTitle,
                        style: Theme.of(context).textTheme.headline6.copyWith(letterSpacing: 1.5, height: 1.5, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.local_fire_department, color: Colors.redAccent,)
                    ],
                  ),
                ),
                Text(
                  publishText,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 1.5, height: 1.5, color: Colors.grey,),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Wrap(
              spacing: 5.0,
              children: topics.map((tag) {
                return Chip(
                  label: Text(tag.name, style: TextStyle(color: AppColors.ylPrimaryColor),),
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                    color: AppColors.ylPrimaryColor,
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        userAvatar,
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Text(
                      userName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.5, color: AppColors.ylPrimaryColor, fontSize: 20.ssp, fontFamily: 'YinLei'),
                    ),
                  ],
                ),
                Opacity(
                  opacity: 0.65,
                  child: Text(
                    ylTimeFormat(DateTime.parse(publishTime)),
                    style: Theme.of(context).textTheme.bodyText1.copyWith(letterSpacing: 1.5, height: 1.5,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}