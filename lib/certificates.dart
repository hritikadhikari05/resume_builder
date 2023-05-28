import 'dart:io';
import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';

class Certificate {
  final pdf = pw.Document();
  Uint8List? logobytes;
  PdfImage? _logoImage;

  Future<Uint8List> makePdf(String name, int points) async {
    List<String> splitted = [];
    final font = await rootBundle.load("fonts/OpenSans-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    // final image = pw.MemoryImage(
    //     (await rootBundle.load('assets/images/cert.png')).buffer.asUint8List());
    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          orientation: pw.PageOrientation.portrait,
          pageFormat: PdfPageFormat.a4.portrait,
        ),
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Container(
                width: double.infinity,
                height: 50,
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey,
                ))
            // pw.Container(
            //     width: double.infinity,
            //     height: double.infinity,
            //     decoration: pw.BoxDecoration(
            //         // image: _logoImage!
            //         ),
            //     margin: pw.EdgeInsets.symmetric(vertical: 15),
            //     alignment: pw.Alignment.center,
            //     child: pw.Image(image,
            //         height: PdfPageFormat.a4.width,
            //         width: PdfPageFormat.a4.height)),
            // pw.Positioned(
            //     left: 200,
            //     bottom: 150,
            //     //margin: pw.EdgeInsets.all(70),
            //     child: pw.Text(name.toUpperCase(),
            //         style: pw.TextStyle(
            //           fontSize: 40,
            //           font: ttf,
            //         ))),
            // pw.Positioned(
            //     left: 80,
            //     bottom: 50,
            //     //margin: pw.EdgeInsets.all(70),
            //     child: pw.Text(
            //         "On Successful Completion of ${(points / 5).toInt()} Donations!!",
            //         style: pw.TextStyle(fontSize: 30, font: ttf)))
          ],
        ),
      ),
    );
    return pdf.save();
  }
}
