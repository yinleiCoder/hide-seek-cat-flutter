import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/toast.dart';
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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile!=null) {
        _image = File(pickedFile.path);
      }else {
        appShowToast(msg: "No image selected");
      }
    });
  }


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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 80.h,
            actions: [
              UnconstrainedBox(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: GestureDetector(
                    onTap: () async {
                      if(_titleController.value.text.trim().isNotEmpty && _descriptionController.value.text.trim().isNotEmpty && _image != null) {
                        /// 发布
                        await PostApi.publishPost(context: context, params: {
                          'title': _titleController.value.text.trim(),
                          'description': _descriptionController.value.text.trim(),
                          'topics': allTopics.map((topic) => topic.tid).toList(),
                          'file': await MultipartFile.fromFile(_image.path, filename: _image.path.split('/').last),
                        });
                        appShowToast(msg: '投稿成功！');
                        Navigator.pop(context);
                      } else {
                        appShowToast(msg: '将稿件填写完整后才能发布哦！');
                      }
                    },
                    child: ClipOval(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                        color: AppColors.ylSecondaryColor,
                        child: Text(
                          '发布',
                          style: TextStyle(
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Image.asset(
                'assets/images/cat_bg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10.r),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(letterSpacing: 1.2, fontFamily: 'YinLei'),
                    maxLines: 1,
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: '标题',
                      counterText: "20/20字",
                    ),
                  ),
                  TextField(
                    maxLines: 5,
                    controller: _descriptionController,
                    style: TextStyle(letterSpacing: 1.2, fontFamily: 'YinLei'),
                    decoration: InputDecoration(
                      hintText: '记录这一刻，晒给懂你的人',
                      counterText: "100/100字",
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10.r),
            sliver: SliverGrid.count(
              crossAxisCount: 1,
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0,
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
                          color: Colors.black45,
                          child: Icon(Icons.close, color: Colors.white, size: 16.ssp,),
                        ),
                      ),
                    ),
                  ),
                ),
                if(_image == null)GestureDetector(
                  onTap: getImage,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColors.ylSecondaryBgColor,
                    ),
                    child: Center(
                      child: Icon(Icons.add, size: 35.ssp,),
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
                      '绵阳市',
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
}
