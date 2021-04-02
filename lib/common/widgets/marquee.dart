
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

/**
 * 跑马灯Marquee
 * https://pub.dev/packages/marquee
 */
Widget appMarquee({
  String text,
  TextStyle customStyle,
}) {
  return Marquee(
    text: text,
    style: customStyle?? TextStyle(fontWeight: FontWeight.normal),
    scrollAxis: Axis.horizontal,
    crossAxisAlignment: CrossAxisAlignment.start,
    blankSpace: 20.0,
    velocity: 100.0,
    pauseAfterRound: Duration(seconds: 1),
    startPadding: 10.0,
    accelerationDuration: Duration(seconds: 1),
    accelerationCurve: Curves.linear,
    decelerationDuration: Duration(milliseconds: 500),
    decelerationCurve: Curves.easeOut,
  );
}