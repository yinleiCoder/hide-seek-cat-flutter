
/**
 * Intl https://pub.dev/packages/intl
 * This package provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.
 */
import 'package:intl/intl.dart';

/// format date.
String ylTimeFormat(DateTime dt) {
  var now = DateTime.now();
  var difference = now.difference(dt);

  // 1天内
  if (difference.inHours < 24) {
    return "${difference.inHours}小时前";
  }
  // 30天内
  else if (difference.inDays < 30) {
    return "${difference.inDays}天前";
  }
  // MM-dd
  else if (difference.inDays < 365) {
    final dtFormat = new DateFormat('MM-dd');
    return dtFormat.format(dt);
  }
  // yyyy-MM-dd
  else {
    final dtFormat = new DateFormat('yyyy-MM-dd');
    var str = dtFormat.format(dt);
    return str;
  }
}
