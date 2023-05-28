// create an app that will take user details such as name,
// profile, experience, jobs, and education as input and then
// generate a resume
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<Uint8List> generateResume(data) async {
  print(data);
  final doc = pw.Document();

  final profileImage = pw.MemoryImage(
    (await rootBundle.load('assets/images/profile.png')).buffer.asUint8List(),
  );

  final pageTheme = await _myPageTheme(PdfPageFormat.a4);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        orientation: pw.PageOrientation.portrait,
        pageFormat: PdfPageFormat.a4.portrait,
      ),
      build: (pw.Context context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Text(
                          data['generalInfo'].name ?? "",
                          textScaleFactor: 2,
                          style: pw.Theme.of(context)
                              .defaultTextStyle
                              .copyWith(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 10),
                        ),

                        //Role
                        pw.Text(
                          '${data['generalInfo'].role}',
                          textScaleFactor: 1.2,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                              fontWeight: pw.FontWeight.bold, color: green),
                        ),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                        //Address
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text('${data['generalInfo'].address}'),
                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text('${data['generalInfo'].phoneNo}'),
                                pw.Text(
                                  '${data['generalInfo'].email}',
                                ),
                              ],
                            ),
                            pw.Padding(padding: pw.EdgeInsets.zero)
                          ],
                        ),
                      ],
                    ),
                  ),
                  _Category(title: 'Work Experience'),
                  pw.Column(
                    children: data['experiences'].map<pw.Widget>((experience) {
                      return _Block(
                          experience.experienceName,
                          experience.experienceDescription,
                          const pw.IconData(0xe88a),
                          context);
                    }).toList(),
                  ),

                  pw.SizedBox(height: 20),

                  /* Education */
                  _Category(title: 'Education'),
                  pw.Column(
                    children: data['education'].map<pw.Widget>((education) {
                      return _Block(
                          education.educationName,
                          education.educationDescription,
                          const pw.IconData(0xe88a),
                          context);
                    }).toList(),
                  ),

                  pw.SizedBox(height: 20),

                  /* JOBS */
                  _Category(title: 'Jobs'),
                  pw.Column(
                    children: data['jobs'].map<pw.Widget>((job) {
                      return _Block(job.jobsName, job.jobsDescription,
                          const pw.IconData(0xe88a), context);
                    }).toList(),
                  ),
                  // _Block(title: 'Bachelor Of Commerce'),
                  // _Block(title: 'Bachelor Interior Design'),
                ],
              ),
            ),
            pw.Partition(
              width: sep,
              child: pw.Column(
                children: [
                  pw.Container(
                    height: pageTheme.pageFormat.availableHeight,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.ClipOval(
                          child: pw.Container(
                            width: 100,
                            height: 100,
                            color: lightGreen,
                            child: pw.Image(profileImage),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  // final bgShape = await rootBundle.loadString('assets/resume.svg');

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            // pw.Positioned(
            //   child: pw.SvgImage(svg: bgShape),
            //   left: 0,
            //   top: 0,
            // ),
            // pw.Positioned(
            //   child: pw.Transform.rotate(
            //       angle: pi, child: pw.SvgImage(svg: bgShape)),
            //   right: 0,
            //   bottom: 0,
            // ),
          ],
        ),
      );
    },
  );
}

pw.Widget _Block(title, description, icon, context) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: <pw.Widget>[
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Container(
            width: 6,
            height: 6,
            margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
            decoration: const pw.BoxDecoration(
              color: green,
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.Text(title,
              style: pw.Theme.of(context)
                  .defaultTextStyle
                  .copyWith(fontWeight: pw.FontWeight.bold)),
          pw.Spacer(),
          if (icon != null) pw.Icon(icon!, color: lightGreen, size: 18),
        ],
      ),
      pw.Container(
        decoration: const pw.BoxDecoration(
          border: pw.Border(
            left: pw.BorderSide(color: green, width: 2),
          ),
        ),
        padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
        margin: const pw.EdgeInsets.only(left: 5),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            //Description
            // pw.Lorem(length: 5),
            pw.Text('${description}'),
          ],
        ),
      ),
    ],
  );
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: lightGreen,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}
