import 'dart:io';
import 'dart:math';
// import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
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
    required List<String> interests}) async {
  final doc = pw.Document(title: 'RESUME', author: name);
  final profileImage = pw.MemoryImage(
    (await rootBundle.load(profileImagePath)).buffer.asUint8List(),
  );

  // Page theme
  final pageTheme = await _myPageTheme(format);

  doc.addPage(pw.MultiPage(
    theme: pageTheme.theme,
    build: (context) => [
      pw.Partition(
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.only(left: 50, bottom: 20),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(name,
                          textScaleFactor: 2,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              )),
                      pw.SizedBox(height: 10.0),
                      pw.Text(jobTitle,
                          textScaleFactor: 1.2,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                                color: green,
                              )),
                      pw.SizedBox(height: 10.0),
                      pw.Text(
                        'Date of Birth: $dateOfBirth',
                      ),
                      pw.Text(
                        'Gender: $gender',
                      ),
                      pw.SizedBox(height: 10.0),
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(address),
                                ]),
                            pw.Column(children: [
                              pw.Text(whatsApp),
                              _UrlText(email, "mailto:$email"),
                              _UrlText(webSite, "https://$webSite"),
                              pw.Text(webSite),
                            ]),
                          ]),
                    ]),
              ),

              // Interests
              _Category(title: 'Interests'),
              for (var interest in interests) pw.Text('- $interest'),

              // Work Experiences
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            _Category(title: 'Work Experience'),
                            for (var work in workExperiences)
                              _Block(
                                  title: work['jobTitle'] ?? '',
                                  description: work['jobDescription'] ?? ''),
                          ]),
                    ),
                  ]),

              // Educations
              _Category(title: 'Education'),
              for (var edu in educations)
                _Block(
                    title: edu['eduDegree'] ?? '',
                    description:
                        '${edu['eduDescription'] ?? ''}\n Level: ${edu['eduLevel']}'),
            ]),
      ),

      // SECOND PARTITION FOR IMAGE // SKILLS // BARCODE
      pw.Partition(
        width: sep,
        child: pw.Column(children: [
          pw.Container(
            height: pageTheme.pageFormat.availableHeight,
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.ClipOval(
                    child: pw.Container(
                      width: 100,
                      height: 100,
                      color: lightGreen,
                      child: pw.Image(profileImage),
                    ),
                  ),
                  pw.Column(children: [
                    _Category(title: 'Skills'),
                    for (var skill in skills)
                      _Percent(
                          size: 60,
                          // value: 60.0,
                          // value: double.parse(skill['skillProficiency'].toString()),
                          value: skill['skillProficiency'],
                          // title: skill['skill'] ?? ''),
                          title: pw.Text(skill['skill'] ?? ''),
                      ),
                  ]),
                  pw.BarcodeWidget(
                    data: 'https://qrdpro.com',
                    height: 60,
                    width: 60,
                    barcode: pw.Barcode.qrCode(),
                    drawText: false,
                  ),
                ]),
          ),
        ]),
      ),
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
  // final outputFile = File('${Directory.systemTemp.path}/resume.pdf');
  // await outputFile.writeAsBytes(await doc.save());
  // return outputFile;

  final outPutDirectory = await getApplicationCacheDirectory();
  final file = File('${outPutDirectory.path}/resume.pdf');
  await file.writeAsBytes(await doc.save());
  return file;

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

class _UrlText extends pw.StatelessWidget {
  _UrlText(this.text, this.url);
  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
        child: pw.Text(text,
            style: const pw.TextStyle(
              decoration: pw.TextDecoration.underline,
              color: PdfColors.blue,
            )),
        destination: url);
  }
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});
  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        color: lightGreen,
        borderRadius: pw.BorderRadius.circular(6),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: pw.Text(title, textScaleFactor: 1.2),
    );
  }
}

class _Block extends pw.StatelessWidget {
  _Block({required this.title, required this.description});
  final String title;
  final String description;
  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(children: [
            pw.Container(
              width: 6,
              height: 6,
              margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
              decoration: const pw.BoxDecoration(
                color: green,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.Text(
              title,
              style: pw.Theme.of(context)
                  .defaultTextStyle
                  .copyWith(fontWeight: pw.FontWeight.bold),
            ),
          ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(
                  color: green,
                  width: 2,
                ),
              ),
            ),
            margin: const pw.EdgeInsets.only(left: 5),
            padding: const pw.EdgeInsets.only(left: 5, top: 5),
            child: pw.Text(description),
          ),
        ]);
  }
}

class _Percent extends pw.StatelessWidget {
  _Percent({required this.size, required this.value, required this.title});
  final double size;
  final double value;
  final pw.Widget title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(children: [
      pw.Container(
        height: size,
        width: size,
        child: pw.Stack(children: [
          pw.Center(
            child: pw.Text('${(value * 100).round()}%'),
          ),
          pw.CircularProgressIndicator(
            value: value,
            backgroundColor: PdfColors.grey300,
            color: green,
            strokeWidth: 5,
          ),
        ]),
      ),
    ]);
  }
}
