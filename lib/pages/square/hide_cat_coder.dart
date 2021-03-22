import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/entitys/entitys.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 躲猫猫APP开发者
 * @author yinlei
 */
class HideCatCoder extends StatefulWidget {
  static String routeName = '/hide_cat_coder';

  @override
  _HideCatCoderState createState() => _HideCatCoderState();
}

class _HideCatCoderState extends State<HideCatCoder> {

  int _sortColumnIndex;
  bool _sortAscending = true;
  final ScoresDataSource _scoresDataSource = ScoresDataSource();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400.h,
                backgroundColor: Colors.white,
                stretch: true,
                pinned: true,
                onStretchTrigger: (){print("啊");},
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('YinLei', style: TextStyle(color: AppColors.ylSecondaryColor),),
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/hide-cat-coder.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black,
                            Colors.black.withOpacity(.3),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                YlFadeIn(
                                  delay: 1200,
                                  child: Text('3次国家励志奖学金',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.ssp,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                YlFadeIn(
                                  delay: 1300,
                                  child: Text('躲猫猫APP社交平台',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.ssp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.only(top: 20.h,bottom: 90.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YlFadeIn(
                          delay: 1500,
                          child: Opacity(
                            opacity: 0.6,
                            child: Text(
                              '实践是指人类有目的地能动地改造和探索现实世界的社会性的客观物质活动。实践的观点是辩证唯物主义认识论的首要的观点，它认为实践是认识的基础。而认识是在实践基础上主体对客体的能动反映。真理是人们对客观事物及其规律的正确反映。实践是检验真理的唯一标准，这是由真理的本性和实践的特点决定的。',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                                fontSize: 14.ssp,
                                height: 1.5,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h,),
                        YlFadeIn(
                          delay: 1400,
                          child: Text('生日',
                            style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold,)
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        YlFadeIn(
                          delay: 1400,
                          child: Text('待做',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        YlFadeIn(
                          delay: 1400,
                          child: Text('大学4年',
                              style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold,)
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        PaginatedDataTable(
                          header: Text('成绩单'),
                          source: _scoresDataSource,
                          sortColumnIndex: _sortColumnIndex,
                          sortAscending: _sortAscending,
                          rowsPerPage: 5,
                          columns: [
                            DataColumn(
                              label: Text('课程名称'),
                              onSort: (int columnIndex, bool ascending) {
                                  setState(() {
                                    _sortColumnIndex = columnIndex;
                                    _sortAscending = ascending;
                                    _scoresDataSource._sort((score) => score.courseName.length, ascending);
                                  });
                              },
                            ),
                            DataColumn(
                              label: Text('性质'),
                            ),
                            DataColumn(
                              label: Text('学分'),
                            ),
                            DataColumn(
                              label: Text('成绩'),
                            ),
                            DataColumn(
                              label: Text('绩点'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Positioned.fill(
            bottom: 30.h,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: YlFadeIn(
                  delay: 1500,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.ylPrimaryColor.withOpacity(.9),
                    ),
                    child: Align(
                      child: Text(
                          "Follow",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoresDataSource extends DataTableSource{
  int _selectedCount = 0;
  List<Score> _scores = [];

  ScoresDataSource(){
    semesters.forEach((semester) => _scores.addAll(semester.eachSemesterScores));
  }

  void _sort(getField(score), bool ascending) {
    _scores.sort((a,b) {
      if(!ascending) {
        final temp = a;
        a = b;
        b = temp;
      }
      final aValue = getField(a);
      final bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    final Score score = _scores[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
          DataCell(Text(score.courseName)),
          DataCell(Text(score.courseNature)),
          DataCell(Text("${score.credit}")),
          DataCell(Text(score.grade)),
          DataCell(Text("${score.gradePoint}")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _scores.length;

  @override
  int get selectedRowCount => _selectedCount;

}