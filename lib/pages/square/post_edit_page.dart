import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/values/colors.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/toast.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:image_picker/image_picker.dart';

/**
 * 用户创建帖子
 * image_picker:
 * https://pub.dev/packages/image_picker
 */
class PostEditPage extends StatefulWidget {
  static String routeName = '/post_edit_page';

  @override
  _PostEditPageState createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {

  List<Topic> allTopics = [];
  num currentPage = 1;
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _loadAllData();
  }

  _loadAllData() async {
    allTopics = await PostApi.allUsersTopics(context: context, per_page: 3);

    if(mounted) {
      setState(() {});
    }
  }

  Future _handleSelectImg() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile!=null) {
        _image = File(pickedFile.path);
      }else {
        appShowToast(msg: "躲猫猫官方：您未选择任何图片哦~");
      }
    });
  }

  _handlePublishPost() async {
    if(_titleController.value.text.trim().isNotEmpty && _descriptionController.value.text.trim().isNotEmpty && _image != null) {
      /// 发布
      await PostApi.publishPost(context: context, params: {
        'title': _titleController.value.text.trim(),
        'description': _descriptionController.value.text.trim(),
        'topics': allTopics.map((topic) => topic.tid).toList(),
        'file': await MultipartFile.fromFile(_image.path, filename: _image.path.split('/').last),
      });
      appShowToast(msg: '躲猫猫官方：投稿成功啦！');
      Navigator.pop(context);
    } else {
      appShowToast(msg: '躲猫猫官方：稿件必须填写完整后才能公开发布分享给朋友们哦~');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            stretch: true,
            expandedHeight: 200.h,
            actions: [
              UnconstrainedBox(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: GestureDetector(
                    onTap: _handlePublishPost,
                    child: ClipOval(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                        color: AppColors.ylSecondaryColor,
                        child: Text(
                          '发布',
                          style: TextStyle(
                            letterSpacing: 1.5,
                            wordSpacing: 2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            leading: YlBackButton(context),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Image.asset(
                'assets/images/post_edit_bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10.r),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  YlTips(tipContent: '躲猫猫官方：让我看看是哪个少女/美男在投稿❤'),
                  TextField(
                    style: TextStyle(letterSpacing: 1.2,),
                    maxLines: 1,
                    maxLength: 40,
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: '标题',
                      icon: Icon(Icons.color_lens),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  TextField(
                    maxLines: 10,
                    controller: _descriptionController,
                    style: TextStyle(letterSpacing: 1.2),
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText: '写点什么内容好呢？',
                      labelText: '记录这一刻，晒给懂你的人',
                      border: OutlineInputBorder(),
                  ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            sliver: SliverGrid.count(
              crossAxisCount: 1,
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0,
              childAspectRatio: 16 / 9,
              children: [
                if(_image != null)Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: FileImage(_image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _image = null;
                        });
                      },
                      child: ClipOval(
                        child: Container(
                          width: 20.r,
                          height: 20.r,
                          color: AppColors.ylPrimaryColor,
                          child: Icon(Icons.close, color: Colors.white, size: 16.ssp,),
                        ),
                      ),
                    ),
                  ),
                ),
                if(_image == null)GestureDetector(
                  onTap: _handleSelectImg,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.ylPrimaryColor,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(Icons.add, size: 50.ssp, color: AppColors.ylPrimaryColor,),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 10.r),
            sliver: SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.topLeft,
                child: Chip(
                  backgroundColor: AppColors.ylSecondaryBgColor,
                  label: Text(
                      '暂未支持定位功能',
                      style: TextStyle(
                        letterSpacing: 1.2,
                        color: AppColors.ylPrimaryColor,
                      ),
                  ),
                  elevation: 3.0,
                  avatar: Icon(Icons.location_on, size: 22.ssp, color: AppColors.ylPrimaryColor,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10.r),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('选择下方话题获得更多曝光', style: TextStyle(color: AppColors.ylPrimaryColor, letterSpacing: 1.2,),),
                  TextButton.icon(
                    onPressed: () async {
                      allTopics = await PostApi.allUsersTopics(context: context,page: ++currentPage, per_page: 3);
                      setState(() {
                        allTopics = allTopics;
                      });
                    },
                    icon: Icon(Icons.refresh,),
                    label: Text('换一批'),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10.r),
            sliver: SliverToBoxAdapter(
              child: Wrap(
                spacing: 5.0,
                children: allTopics.map((topic) {
                  return Chip(
                    avatar: ClipOval(child: Image.network(topic.avatar_url, fit: BoxFit.cover,)),
                    label: Text(topic.name),
                    onDeleted: () {
                      setState(() {
                        allTopics.remove(topic);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

}
