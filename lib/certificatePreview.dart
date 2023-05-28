import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:printing/printing.dart';
import 'package:task1/certificates.dart';

class CertificatePreview extends StatelessWidget {
  const CertificatePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Certificate Preview"),
        ),
        body: PdfPreview(
          build: (context) => Certificate().makePdf("name", 12),
        ));
  }
}
