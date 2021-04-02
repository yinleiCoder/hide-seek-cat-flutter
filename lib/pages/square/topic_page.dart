import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/apis/apis.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/colors.dart';
import 'package:flutter_hide_seek_cat/common/widgets/skeleton.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 话题页
 * @author yinlei
 */
class TopicPage extends StatefulWidget {
  static String routeName = '/topic_page';

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> with AutomaticKeepAliveClientMixin<TopicPage> {

  StateManager _stateManager;

  @override
  void initState() {
    super.initState();
    _stateManager = StateManager();
    _loadData();
  }

  @override
  void dispose() {
    _stateManager.dispose();
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

  Future<List<Topic>> _loadAllData() async {
    /// TODO: 下拉分页加载更多
    return await PostApi.allUsersTopics(context: context, per_page: 10);
  }


  Widget _buildTopicCard({topicBg, topicName, topicCreatedTime}) {
    return Container(
      height: 150.h,
      margin: EdgeInsets.only(top: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(topicBg),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              stops: [0.3, 0.9],
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2),
              ]
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(topicName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                Text(
                  ylTimeFormat(DateTime.parse(topicCreatedTime)),
                  style: TextStyle(
                    color: Colors.grey,
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return YlStreamBuilder<List<Topic>>(
      streamController: _stateManager.streamController,
      builder: (context, data) {
        return ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/cat_bg.png'),
                  colorFilter: ColorFilter.mode(
                    Colors.black12.withOpacity(0.3),
                    BlendMode.srcOver,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('这里有大家', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white.withOpacity(0.6)),),
                  SizedBox(height: 5.h,),
                  Text('感兴趣的话题', style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2,),),
                  Padding(
                    padding: EdgeInsets.all(5.r),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                      onChanged: (curVal) async {
                        _stateManager.content(await PostApi.allUsersTopics(context: context, q: curVal));
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,),
                        hintText: '搜索感兴趣的话题名',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.r, top: 8.0.r),
              child: Text('所有话题', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5, color: AppColors.ylPrimaryColor, fontSize: 20.ssp,),),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return _buildTopicCard(
                    topicBg: data[index].avatar_url,
                    topicName: data[index].name,
                    topicCreatedTime: data[index].createdAt,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
