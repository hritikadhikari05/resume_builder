import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:task1/resume.dart';
import 'package:task1/pages/resumeInput.dart';
import 'package:task1/routes/routes.dart';

Future<void> main() async {
  runApp(const MyApp('Printing Demo'));
}

class MyApp extends StatelessWidget {
  const MyApp(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: ResumeInput(),
      getPages: appRoutes(),
      initialRoute: "/resume-input",
    );
  }
}


// PdfPreview(
//           build: (format) => generateResume(
//             PdfPageFormat.a4,
//             CustomData(
//               name: "Sai Pranav",
//             ),
//           ),
//         )