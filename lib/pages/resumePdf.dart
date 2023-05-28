import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:task1/resume.dart';

class ResumePDF extends StatelessWidget {
  const ResumePDF({super.key});

  @override
  Widget build(BuildContext context) {
    final argumentData = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume Preview"),
      ),
      body: PdfPreview(
        build: (context) => generateResume(argumentData),
      ),
    );
  }
}
