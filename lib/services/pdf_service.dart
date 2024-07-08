import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFService {

  // create pdf 
  static Future<Uint8List> createPDFReport(data, pageTittle) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(children: [
              pw.Text(
                pageTittle,
                style: pw.TextStyle(fontSize: 18),
              ),
              pw.SizedBox(height: 20),
              // ignore: deprecated_member_use
              pw.Table.fromTextArray(
                context: context,
                data: data,
              ),
            ]),
          ); // Center
        }));

    return pdf.save();
  }

  // download pdf file
  static Future savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    final filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}
