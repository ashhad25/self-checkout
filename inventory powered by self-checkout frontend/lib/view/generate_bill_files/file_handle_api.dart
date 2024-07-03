import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' as html;

class FileHandleApi {
  static Future saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    int dateTime = DateTime.now().millisecondsSinceEpoch;
    String filename = "$dateTime - invoice.pdf";
    if (!kIsWeb) {
      final bytes = await pdf.save();
      final dir = await getExternalStorageDirectory();
      print(dir);
      final file = File('${dir!.path}/$filename');
      await file.writeAsBytes(bytes);
      print(file);
      return file;
    } else {
      var savedFile = await pdf.save();
      List<int> fileInts = List.from(savedFile);
      var chk = html.AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
        ..setAttribute("download", filename)
        ..click();
      return filename;
    }
  }

  // open pdf file function
  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
