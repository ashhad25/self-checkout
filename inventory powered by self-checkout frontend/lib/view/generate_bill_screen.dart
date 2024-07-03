import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sql_inventory_2_frontend/view/generate_bill_files/file_handle_api.dart';
import 'package:sql_inventory_2_frontend/view/generate_bill_files/pdf_invoice_api.dart';

class GenerateBillScreen extends StatefulWidget {
  final orderId;
  final dataList;
  final total;
  const GenerateBillScreen(
      {super.key,
      required this.orderId,
      required this.dataList,
      required this.total});

  @override
  State<GenerateBillScreen> createState() => _GenerateBillScreenState();
}

class _GenerateBillScreenState extends State<GenerateBillScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateBill(widget.orderId, widget.dataList, widget.total);
    Timer(const Duration(seconds: 5), () {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  generateBill(var userId, var dataList, var total) async {
    print({
      "dataList": dataList,
      "msg": "generate bill running",
      "type": dataList.runtimeType
    });
    final pdfFile = await PdfInvoiceApi.generate(userId, dataList, total);

    // opening the pdf file
    if (!kIsWeb) {
      FileHandleApi.openFile(pdfFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Please wait, file saved on downloads folder'),
      ),
    );
  }
}
