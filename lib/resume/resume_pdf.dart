import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:printing/printing.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<File> generateResume(PdfPageFormat format,
    {required String name,
    required String jobTitle,
    required String whatsApp,
    required String email,
    required String webSite,
    required String address,
    required String dateOfBirth,
    required String gender,
    required String profileImagePath,
    required List<Map<String, String>> workExperiences,
    required List<Map<String, String>> educations,
    required List<Map<String, dynamic>> skills,
    required List<String> interest}) async {
  final doc = pw.Document(title: 'RESUME', author: name);
  final profileImage = pw.MemoryImage((await rootBundle.load(profileImagePath))
      .buffer
      .asInt8List() as Uint8List);

  // Page theme
  final pageTheme = await _myPageTheme(format);

  doc.addPage(pw.MultiPage(
    build: (context) => [
      pw.Partition(
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
            pw.Container(
                padding: pw.EdgeInsets.only(left: 50, bottom: 20),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(name,
                          textScaleFactor: 2,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              )
                      ),
                        pw.SizedBox(height: 10.0),
                        pw.Text(jobTitle,
                            textScaleFactor: 1.2,
                            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                                color: green,
                            )
                        ),


                        // Video 40 minutes...



                    ]))
          ])),
      pw.Partition(child: pw.Column()),
    ],
  ));

  // doc.addPage(pw.Page(
  //     theme: pageTheme,
  //     build: (context) {
  //       return pw.Column(
  //         crossAxisAlignment: pw.CrossAxisAlignment.start,
  //         children: [
  //           // Header with profile image and name
  //           pw.Row(
  //             children: [
  //               pw.Image(profileImage, width: 100, height: 100),
  //               pw.SizedBox(width: 20),
  //               pw.Column(
  //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                 children: [
  //                   pw.Text(name,
  //                       style: pw.TextStyle(
  //                           fontSize: 24, fontWeight: pw.FontWeight.bold)),
  //                   pw.Text(jobTitle, style: const pw.TextStyle(fontSize: 18)),
  //                   pw.Text('WhatsApp: $whatsApp'),
  //                   pw.Text('Email: $email'),
  //                   pw.Text('Website: $webSite'),
  //                   pw.Text('Address: $address'),
  //                   pw.Text('Date of Birth: $dateOfBirth'),
  //                   pw.Text('Gender: $gender'),
  //                 ],
  //               ),
  //             ],
  //           ),
  //
  //           // Separator line
  //           pw.Divider(),
  //
  //           // Work Experience
  //           pw.Text('Work Experience',
  //               style:
  //                   pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
  //           ...workExperiences.map((experience) {
  //             return pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 pw.Text(experience['jobTitle'] ?? '',
  //                     style: const pw.TextStyle(fontSize: 16)),
  //                 pw.Text(experience['companyName'] ?? '',
  //                     style: const pw.TextStyle(fontSize: 14)),
  //                 pw.Text(experience['duration'] ?? '',
  //                     style: const pw.TextStyle(fontSize: 12)),
  //                 pw.Text(experience['description'] ?? '',
  //                     style: const pw.TextStyle(fontSize: 12)),
  //               ],
  //             );
  //           }),
  //
  //           // Separator line
  //           pw.Divider(),
  //
  //           // Education
  //           pw.Text('Education',
  //               style:
  //                   pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
  //           ...educations.map((education) {
  //             return pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 pw.Text(education['degree'] ?? '',
  //                     style: const pw.TextStyle(fontSize: 16)),
  //                 pw.Text(education['institution'] ?? '',
  //                     style: const pw.TextStyle(fontSize: 14)),
  //                 pw.Text(education['duration'] ?? '',
  //                     style: const pw.TextStyle(fontSize: 12)),
  //               ],
  //             );
  //           }),
  //
  //           // Separator line
  //           pw.Divider(),
  //
  //           // Skills
  //           pw.Text('Skills',
  //               style:
  //                   pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
  //           pw.Wrap(
  //             children: skills.map((skill) {
  //               return pw.Container(
  //                 margin: const pw.EdgeInsets.only(right: 8, bottom: 8),
  //                 padding: const pw.EdgeInsets.all(8),
  //                 decoration: pw.BoxDecoration(
  //                   border: pw.Border.all(
  //                       color: const PdfColor.fromInt(0xffcccccc)),
  //                   borderRadius: pw.BorderRadius.circular(5),
  //                 ),
  //                 child: pw.Text(skill['name'] ?? '',
  //                     style: const pw.TextStyle(fontSize: 12)),
  //               );
  //             }).toList(),
  //           ),
  //
  //           // Separator line
  //           pw.Divider(),
  //
  //           // Interests
  //           pw.Text('Interests',
  //               style:
  //                   pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
  //           pw.Text(interest.join(', '),
  //               style: const pw.TextStyle(fontSize: 14)),
  //         ],
  //       );
  //     }));

  // Save to file
  final outputFile = File('${Directory.systemTemp.path}/resume.pdf');
  await outputFile.writeAsBytes(await doc.save());
  return outputFile;
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/images/resume.svg');
  format = format.applyMargin(
      left: PdfPageFormat.cm * 2.0,
      top: 4.0,
      right: PdfPageFormat.cm * 2.0,
      bottom: PdfPageFormat.cm * 2.0);
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
          child: pw.Stack(children: [
            pw.Positioned(top: 0, left: 0, child: pw.SvgImage(svg: bgShape)),
            pw.Positioned(
                bottom: 0,
                right: 0,
                child: pw.Transform.rotate(
                    angle: pi, child: pw.SvgImage(svg: bgShape))),
          ]));
    },
  );
}
