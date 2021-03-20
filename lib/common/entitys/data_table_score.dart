import 'package:flutter/cupertino.dart';

/**
 * 模拟我的成绩【后面用接口】
*/
class Semester {
  final List<Score> eachSemesterScores;

  Semester(this.eachSemesterScores);

}
class Score {
  final String courseName;
  final String courseNature;
  final num credit;
  final String grade;
  final num gradePoint;

  bool selected;

  Score({this.courseName, this.courseNature, this.credit, this.grade, this.gradePoint,this.selected = false, });
}


final List<Semester> semesters = [
  Semester([
    Score(
      courseName: "大学英语I-1",
      courseNature: "必修",
      credit: 3.0,
      grade: "77",
      gradePoint: 2.70,
    ),
    Score(
      courseName: "高级语言程序设计",
      courseNature: "必修",
      credit: 4.0,
      grade: "90",
      gradePoint: 4.00,
    ),
    Score(
      courseName: "军事理论",
      courseNature: "必修",
      credit: 1.0,
      grade: "优秀",
      gradePoint: 4.00,
    ),
    Score(
      courseName: "军训",
      courseNature: "必修",
      credit: 1.0,
      grade: "通过",
      gradePoint: 3.00,
    ),
    Score(
      courseName: "礼仪与口才",
      courseNature: "必修",
      credit: 1.0,
      grade: "优秀",
      gradePoint: 4.00,
    ),
    Score(
      courseName: "思想道德修养与法律基础",
      courseNature: "必修",
      credit: 3.0,
      grade: "92",
      gradePoint: 4.20,
    ),
    Score(
      courseName: "跆拳道俱乐部-1",
      courseNature: "必修",
      credit: 1.0,
      grade: "82",
      gradePoint: 3.20,
    ),
    Score(
      courseName: "微积分(I)-1",
      courseNature: "必修",
      credit: 4.5,
      grade: "92",
      gradePoint: 4.20,
    ),
    Score(
      courseName: "形势与政策",
      courseNature: "必修",
      credit: 0.0,
      grade: "75",
      gradePoint: 2.50,
    ),
  ]),

  Semester([
    Score(
      courseName: "晨练",
      courseNature: "必修",
      credit: 1.0,
      grade: "通过",
      gradePoint: 3.00,
    ),
    Score(
      courseName: "大学生心理健康教育",
      courseNature: "必修",
      credit: 1.0,
      grade: "良好",
      gradePoint: 3.00,
    ),
    Score(
      courseName: "大学生职业发展与学业管理",
      courseNature: "必修",
      credit: 1.0,
      grade: "优秀",
      gradePoint: 4.00,
    ),
    Score(
      courseName: "大学英语I-2",
      courseNature: "必修",
      credit: 3.0,
      grade: "76",
      gradePoint: 2.60,
    ),
    Score(
      courseName: "面向对象程序设计",
      courseNature: "必修",
      credit: 4.0,
      grade: "98",
      gradePoint: 4.80,
    ),
    Score(
      courseName: "数字电路与数字逻辑",
      courseNature: "必修",
      credit: 3.0,
      grade: "86",
      gradePoint: 3.60,
    ),
    Score(
      courseName: "跆拳道俱乐部-2",
      courseNature: "必修",
      credit: 1.0,
      grade: "87",
      gradePoint: 3.70,
    ),
    Score(
      courseName: "微积分(I)-2",
      courseNature: "必修",
      credit: 5.5,
      grade: "86",
      gradePoint: 3.60,
    ),
    Score(
      courseName: "线性代数(I)",
      courseNature: "必修",
      credit: 3.0,
      grade: "92",
      gradePoint: 4.20,
    ),
    Score(
      courseName: "形式与政策-2",
      courseNature: "必修",
      credit: 0.0,
      grade: "73",
      gradePoint: 2.30,
    ),
    Score(
      courseName: "中国近现代史纲要",
      courseNature: "必修",
      credit: 2.0,
      grade: "84",
      gradePoint: 3.40,
    ),
    Score(
      courseName: "创业创新领导力",
      courseNature: "任修",
      credit: 2.0,
      grade: "97",
      gradePoint: 4.70,
    ),
    Score(
      courseName: "魅力科学",
      courseNature: "任修",
      credit: 1.0,
      grade: "95",
      gradePoint: 4.50,
    ),
  ]),

  Semester([
    Score(
      courseName: "程序设计C(数据结构)",
      courseNature: "必修",
      credit: 4.0,
      grade: "92",
      gradePoint: 4.20,
    ),
    Score(
      courseName: "程序设计D(Java程序设计)",
      courseNature: "必修",
      credit: 3.0,
      grade: "87",
      gradePoint: 3.70,
    ),
    Score(
      courseName: "大学英语I-3",
      courseNature: "必修",
      credit: 3.0,
      grade: "71",
      gradePoint: 2.10,
    ),
    Score(
      courseName: "概率统计(I)",
      courseNature: "必修",
      credit: 3.0,
      grade: "78",
      gradePoint: 2.80,
    ),
    Score(
      courseName: "离散数学",
      courseNature: "必修",
      credit: 2.0,
      grade: "88",
      gradePoint: 3.80,
    ),
    Score(
      courseName: "逻辑思维",
      courseNature: "必修",
      credit: 1.0,
      grade: "良好",
      gradePoint: 3.00,
    ),
    Score(
      courseName: "马克思注意基本原理",
      courseNature: "必修",
      credit: 3.0,
      grade: "88",
      gradePoint: 3.80,
    ),
    Score(
      courseName: "数据库原理及应用",
      courseNature: "必修",
      credit: 3.0,
      grade: "86",
      gradePoint: 3.60,
    ),
    Score(
      courseName: "武术俱乐部-3",
      courseNature: "必修",
      credit: 1.0,
      grade: "88",
      gradePoint: 3.80,
    ),
    Score(
      courseName: "形式与政策-3",
      courseNature: "必修",
      credit: 0.0,
      grade: "91",
      gradePoint: 4.10,
    ),
    Score(
      courseName: "中外名著导读",
      courseNature: "必修",
      credit: 1.0,
      grade: "中等",
      gradePoint: 2.00,
    ),
    Score(
      courseName: "专业导论",
      courseNature: "必修",
      credit: 2.0,
      grade: "92",
      gradePoint: 4.20,
    ),
    Score(
      courseName: "计算机绘图",
      courseNature: "任修",
      credit: 1.0,
      grade: "99",
      gradePoint: 4.90,
    ),
    Score(
      courseName: "信息系统与数据库技术",
      courseNature: "任修",
      credit: 1.0,
      grade: "98",
      gradePoint: 4.80,
    ),
  ]),

  Semester([
    Score(
      courseName: "操作系统原理",
      courseNature: "必修",
      credit: 2.0,
      grade: "74",
      gradePoint: 2.40,
    ),
    Score(
      courseName: "计算机网络I",
      courseNature: "必修",
      credit: 4.0,
      grade: "85",
      gradePoint: 3.50,
    ),
    Score(
      courseName: "计算机组成原理",
      courseNature: "必修",
      credit: 3.0,
      grade: "76",
      gradePoint: 2.60,
    ),
    Score(
      courseName: "大学英语I-4",
      courseNature: "必修",
      credit: 3.0,
      grade: "67",
      gradePoint: 1.70,
    ),
    Score(
      courseName: "毛泽东思想和中国特色社会主义理论体系概论",
      courseNature: "必修",
      credit: 6.0,
      grade: "81",
      gradePoint: 3.10,
    ),
    Score(
      courseName: "前端设计与开发",
      courseNature: "必修",
      credit: 4.0,
      grade: "91",
      gradePoint: 4.10,
    ),
    Score(
      courseName: "实用文书与公文处理",
      courseNature: "必修",
      credit: 2.0,
      grade: "82",
      gradePoint: 3.20,
    ),
    Score(
      courseName: "武术俱乐部-2",
      courseNature: "必修",
      credit: 1.0,
      grade: "85",
      gradePoint: 3.50,
    ),
    Score(
      courseName: "现代软件工程I",
      courseNature: "必修",
      credit: 2.0,
      grade: "86",
      gradePoint: 3.60,
    ),
    Score(
      courseName: "形式与政策-4",
      courseNature: "必修",
      credit: 0.0,
      grade: "87",
      gradePoint: 3.70,
    ),
  ]),

  Semester([
    Score(
      courseName: "HTML5应用开发",
      courseNature: "必修",
      credit: 4.0,
      grade: "94",
      gradePoint: 4.40,
    ),
    Score(
      courseName: "Python程序设计",
      courseNature: "必修",
      credit: 4.0,
      grade: "82",
      gradePoint: 3.20,
    ),
    Score(
      courseName: "软件质量与软件测试I",
      courseNature: "必修",
      credit: 3.0,
      grade: "86",
      gradePoint: 3.60,
    ),
    Score(
      courseName: "形式与政策-5",
      courseNature: "必修",
      credit: 0.0,
      grade: "87",
      gradePoint: 3.70,
    ),
    Score(
      courseName: "专业英语I",
      courseNature: "必修",
      credit: 2.0,
      grade: "79",
      gradePoint: 2.90,
    ),
    Score(
      courseName: "软件项目管理",
      courseNature: "选修",
      credit: 2.0,
      grade: "良好",
      gradePoint: 3.00,
    ),
    Score(
      courseName: "大数据技术及应用",
      courseNature: "选修",
      credit: 2.0,
      grade: "93",
      gradePoint: 4.30,
    ),
    Score(
      courseName: "多媒体技术I",
      courseNature: "选修",
      credit: 2.0,
      grade: "79",
      gradePoint: 2.90,
    ),
    Score(
      courseName: "图形与图像处理II",
      courseNature: "选修",
      credit: 2.0,
      grade: "84",
      gradePoint: 3.40,
    ),
    Score(
      courseName: "云计算",
      courseNature: "选修",
      credit: 2.0,
      grade: "95",
      gradePoint: 4.0,
    ),
  ]),

  Semester([
    Score(
      courseName: "Android高级应用开发",
      courseNature: "必修",
      credit: 4.0,
      grade: "93",
      gradePoint: 4.30,
    ),
    Score(
      courseName: "混合框架开发",
      courseNature: "必修",
      credit: 4.0,
      grade: "98",
      gradePoint: 4.80,
    ),
    Score(
      courseName: "就业与创业指导",
      courseNature: "必修",
      credit: 1.0,
      grade: "87",
      gradePoint: 3.70,
    ),
    Score(
      courseName: "形式与政策-6",
      courseNature: "必修",
      credit: 0.0,
      grade: "92",
      gradePoint: 4.20,
    ),
    Score(
      courseName: "电子商务概论",
      courseNature: "选修",
      credit: 2.0,
      grade: "80",
      gradePoint: 3.00,
    ),
    Score(
      courseName: "对日软件服务包概论",
      courseNature: "选修",
      credit: 2.0,
      grade: "79",
      gradePoint: 2.90,
    ),
    Score(
      courseName: "信息安全技术",
      courseNature: "选修",
      credit: 2.0,
      grade: "83",
      gradePoint: 3.30,
    ),
  ]),

  Semester([
    Score(
      courseName: "毕业实习",
      courseNature: "必修",
      credit: 2.0,
      grade: "81",
      gradePoint: 3.10,
    ),
    Score(
      courseName: "创新教育(必修)",
      courseNature: "必修",
      credit: 2.0,
      grade: "通过",
      gradePoint: 3.00,
    ),
    Score(
      courseName: "五大素质养成计划",
      courseNature: "必修",
      credit: 2.0,
      grade: "84",
      gradePoint: 3.00,
    ),
    Score(
      courseName: "形式与政策-7",
      courseNature: "必修",
      credit: 0.0,
      grade: "84",
      gradePoint: 3.40,
    ),
    Score(
      courseName: "综合应用开发实践",
      courseNature: "必修",
      credit: 4.0,
      grade: "85",
      gradePoint: 3.50,
    ),
    Score(
      courseName: "创新教育-1",
      courseNature: "任修",
      credit: 1.0,
      grade: "通过",
      gradePoint: 3.00,
    ),
    Score(
      courseName: "科技论文协作",
      courseNature: "选修",
      credit: 2.0,
      grade: "84",
      gradePoint: 3.40,
    ),
  ]),
];