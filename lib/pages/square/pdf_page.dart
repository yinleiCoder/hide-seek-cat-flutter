import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_screenutil/size_extension.dart';

/**
 * https://yinlei-hide-seek-cat.oss-cn-chengdu.aliyuncs.com/flutter-cat/%E5%B0%B9%E7%A3%8A%E7%AE%80%E5%8E%86.pdf
 * PDF预览：展示论文或者简历
 * @author yinlei
 * https://pub.dev/packages/pdf
 * https://pub.dev/packages/printing
 * https://pub.dev/packages/open_file
 */
class PdfPage extends StatefulWidget {
  const PdfPage({Key key}) : super(key: key);

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {

  File _pdfFile;
  String _pdfUrl = 'https://yinlei-hide-seek-cat.oss-cn-chengdu.aliyuncs.com/flutter-cat/%E5%B0%B9%E7%A3%8A_1705200120_%E5%9F%BA%E4%BA%8EFlutter%E7%9A%84%E5%8D%B3%E6%97%B6%E9%80%9A%E8%AE%AFAPP.pdf';

  @override
  void initState() {
    super.initState();

    _init();
  }

  _init() async {
      _pdfFile = await _loadPDFContent(_pdfUrl);
      if(mounted) {
        setState(() {});
      }
  }

  Future<File> _loadPDFContent(String fileUrl) async {
    Dio dio = new Dio(
      BaseOptions(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) => status < 500,
      ),
    );
    Response response = await dio.get(fileUrl);

    return _storeFile(fileUrl, response.data);
  }

  Future<File> _storeFile(String fileUrl, List<int> bytes) async {
    final filename = path.basename(fileUrl);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/${filename}');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<void> _saveAsFile(
      BuildContext context,
      LayoutCallback build,
      PdfPageFormat pageFormat,
      ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File(appDocPath + '/' + 'document.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  Future<Uint8List> _handlePdfContent() async {
    return await _pdfFile.readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(
          icon: const Icon(Icons.save),
          onPressed: _saveAsFile,
        ),
    ];
    return Scaffold(
      body: _pdfFile == null ? Center(child: CircularProgressIndicator()) : PdfPreview(
        maxPageWidth: 700,
        build: (format) => _handlePdfContent(),
        actions: actions,
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
    );
  }

}
