import 'package:share/share.dart';
/**
 * 分享
 * https://pub.dev/packages/share
*/
Future appShareText({
  String text = "http://yinleilei.com/",
}) async {
  return await Share.share("向您分享了一个内容，请查看: $text");
}

Future appShareEmail({
  String email,
  String subject = "邮件主题",
}) async {
  return await Share.share(email, subject: subject);
}

Future appShareFile({
  List<String> filePaths,
  String title = "分享文件",
}) async {
  return await Share.shareFiles(
    filePaths,
    text: title,
  );
}
