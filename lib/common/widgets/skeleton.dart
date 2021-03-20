import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
/**
 * 骨架屏
 * https://pub.dev/packages/pk_skeleton
 * @author yinlei
*/

Widget appSingleLightSkeleton() {
  return PKCardSkeleton(
    isCircularImage: true,
    isBottomLinesActive: true,
  );
}

/// 外界需要给定尺寸
Widget appListLightSkeleton() {
  return PKCardListSkeleton(
    isCircularImage: true,
    isBottomLinesActive: true,
    length: 10,
  );
}

/// 用于个人界面或者话题页面
Widget appCardProfileLightSkeleton() {
  return PKCardProfileSkeleton(
    isCircularImage: true,
    isBottomLinesActive: true,
  );
}

/// 用于展示文章等列表
Widget appCardPageLightSkeleton() {
  return PKCardPageSkeleton(
    totalLines: 5,
  );
}

/// 暗黑主题------------------------------------------------------

Widget appSingleDarkSkeleton() {
  return PKDarkCardSkeleton(
    isCircularImage: true,
    isBottomLinesActive: true,
  );
}

/// 外界需要给定尺寸
Widget appListDarkSkeleton() {
  return PKDarkCardListSkeleton(
    isCircularImage: true,
    isBottomLinesActive: true,
    length: 10,
  );
}

/// 用于个人界面或者话题页面
Widget appCardProfileDarkSkeleton() {
  return PKDarkCardProfileSkeleton(
    isCircularImage: true,
    isBottomLinesActive: true,
  );
}

/// 用于展示文章等列表
Widget appCardPageDarkSkeleton() {
  return PKDarkCardPageSkeleton(
    totalLines: 5,
  );
}

