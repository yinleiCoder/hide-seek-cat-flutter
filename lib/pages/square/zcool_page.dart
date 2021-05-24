import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/values/colors.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/pages/square/zcool_detail_page.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 站酷图集
 * @author yinlei
 */
class ZcoolPage extends StatefulWidget {
  @override
  _ZcoolPageState createState() => _ZcoolPageState();
}

class _ZcoolPageState extends State<ZcoolPage> with AutomaticKeepAliveClientMixin<ZcoolPage> {

  StateManager _stateManager;
  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _stateManager = StateManager();
    _searchController = TextEditingController();
    _loadData();
  }

  @override
  void dispose() {
    _stateManager.dispose();
    _searchController.dispose();
    super.dispose();
  }

  _loadData() {
    _stateManager.loading();
    _loadAllData().then((val) {
      _stateManager.content(val);
    }).catchError((e) {
      _stateManager.error();
    });
  }

  Future<List<ZcoolSearch>> _loadAllData() async {
    return await UserApi.zcoolSearch(context: context,);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return YlStreamBuilder<List<ZcoolSearch>>(
      streamController: _stateManager.streamController,
      builder: (context, data) {
        List<ZcoolSearch> newData = data as List<ZcoolSearch>;
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h,),
                    Text('Find awesome photos\nplease visit zcool.com.cn', style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 20.h,),
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                letterSpacing: 1.2,
                              ),
                              controller: _searchController,
                              onSubmitted: (curVal) async {
                                _stateManager.content(await UserApi.zcoolSearch(context: context, keyword: curVal));
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '搜索想要找的图片关键词',
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                              ),
                            ),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onPressed: () async {
                              _stateManager.content(await UserApi.zcoolSearch(context: context, keyword: _searchController.value.text.trim()));
                            },
                            minWidth: 50.w,
                            color: AppColors.ylPrimaryColor,
                            child: Icon(Icons.search, color: Colors.white,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '您搜索的',
                        style: Theme.of(context).textTheme.headline6.copyWith(letterSpacing: 1.2, fontWeight: FontWeight.bold,),
                        children: <TextSpan>[
                          TextSpan(
                            text: _searchController.value.text.trim(),
                            style: Theme.of(context).textTheme.headline6.copyWith(letterSpacing: 1.2, fontWeight: FontWeight.bold, color: AppColors.ylPrimaryColor),
                          ),
                          TextSpan(
                            text: ',共找到${newData.length}个结果',
                            style: Theme.of(context).textTheme.headline6.copyWith(letterSpacing: 1.2, fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h,),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                itemCount: newData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () =>Navigator.of(context).pushNamed(ZcoolDetailPage.routeName, arguments: '${newData[index].id}'),
                    child: _buildZcoolSearchResultCard(
                      cover: newData[index].cover,
                      title: newData[index].title,
                      cateStr: newData[index].cateStr,
                      subCateStr: newData[index].subCateStr,
                      publishTimeDiffStr: newData[index].publishTimeDiffStr,
                      viewCountStr: newData[index].viewCountStr,
                      recommendCountStr: newData[index].recommendCountStr,
                      creatorObj: newData[index].creatorObj,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildZcoolSearchResultCard({
    cover,
    title,
    cateStr,
    subCateStr,
    publishTimeDiffStr,
    viewCountStr,
    recommendCountStr,
    creatorObj,
}) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 10.0,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 20,
                  backgroundImage: NetworkImage(creatorObj.avatar),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        creatorObj.username,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2,),
                      ),
                      SizedBox(height: 5.w,),
                      Wrap(
                        runSpacing: 5.0,
                        children: [
                            Opacity(
                              opacity: 0.65,
                              child: Text(
                                title,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          Opacity(
                            opacity: 0.65,
                            child: Text(
                              publishTimeDiffStr,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h,),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(cover),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 55.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r),
                      ),
                       child: BackdropFilter(
                         filter: ImageFilter.blur(
                           sigmaX: 10.0,
                           sigmaY: 10.0,
                         ),
                         child: Container(
                           alignment: Alignment.center,
                           child: Column(
                             children: [
                               SizedBox(height: 5.h,),
                               RichText(
                                 text: TextSpan(
                                     text: cateStr,
                                     style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                                     children: <TextSpan>[
                                       TextSpan(
                                         text: '——',
                                         style: Theme.of(context).textTheme.bodyText1,
                                       ),
                                       TextSpan(
                                         text: subCateStr,
                                         style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                                       ),
                                     ]
                                 ),
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                   Row(
                                     children: [
                                       Icon(Icons.favorite, color: Colors.red,),
                                       SizedBox(width: 5.w,),
                                       Text(recommendCountStr,),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       Icon(Icons.visibility),
                                       SizedBox(width: 5.w,),
                                       Text(viewCountStr),
                                     ],
                                   ),
                                 ],
                               ),
                             ],
                           )
                         ),
                       ),
                     ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
