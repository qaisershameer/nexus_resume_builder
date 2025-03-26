import 'dart:io';
import 'dart:math';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

const sep = 120.0;
const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

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

  // document title author name
  final doc = pw.Document(title: 'RESUME', author: name);

  // resume profile image
  final profileImage = pw.MemoryImage((await rootBundle.load(profileImagePath)).buffer.asUint8List(),);

  // Page theme
  final pageTheme = await _myPageTheme(format);

  // Multi Page // Theme // Partitions
  doc.addPage(pw.MultiPage(
    theme: pageTheme.theme,
    build: (context) => [

      // Partitions Starts
      pw.Partitions(children: [

        // FIRST PARTITION FOR PERSONAL INFO // INTERESTS // WORK-EXP // EDUCATION
        pw.Partition(
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.only(left: 50, bottom: 20),

                  // Personal Information
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Personal Information // Name
                        pw.Text(name,
                            textScaleFactor: 2,
                            style:
                                pw.Theme.of(context).defaultTextStyle.copyWith(
                                      fontWeight: pw.FontWeight.bold,
                                    )),
                        pw.SizedBox(height: 10.0),

                        // Personal Information // Job Title
                        pw.Text(jobTitle,
                            textScaleFactor: 1.2,
                            style:
                                pw.Theme.of(context).defaultTextStyle.copyWith(
                                      fontWeight: pw.FontWeight.bold,
                                      color: green,
                                    )),
                        pw.SizedBox(height: 10.0),

                        // Personal Information // Date of Birth
                        pw.Text(
                          'D.O.B: $dateOfBirth',
                        ),

                        // Personal Information // Gender
                        pw.Text(
                          'Gender: $gender',
                        ),
                        pw.SizedBox(height: 10.0),

                        // Personal Information // -Address -WhatsApp -Email -Website
                        pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    // Personal Information // Address
                                    pw.Text(address),
                                  ]),
                              pw.Column(children: [
                                // Personal Information // WhatsApp
                                pw.Text(whatsApp),

                                // Personal Information // Email
                                _UrlText(email, "mailto:$email"),

                                // Personal Information // WebSite
                                _UrlText(webSite, "https://$webSite"),
                              ]),
                            ]),
                      ]),
                ),

                // Interests
                _Category(title: 'Interests'),

                // Interests List Selected Check-Boxes Loop
                for (var interest in interests)

                  // Interests Data From Above Loop
                  pw.Text('- $interest'),

                // Work Experiences // Educations
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              // Work Experiences
                              _Category(title: 'Work Experience'),
                              for (var work in workExperiences)

                                // Work Experiences Block // Job Title // Job Description
                                _Block(
                                    title: work['jobTitle'] ?? '',
                                    description: '${work['jobCompany'] ?? ''} \n${work['jobDescription'] ?? ''}'),
                            ]),
                      ),
                    ]),

                // Educations Block Starting
                _Category(title: 'Education'),
                for (var edu in educations)

                  // Educations Block // Degree // Description // Level // Institute
                  _Block(
                      title: edu['eduDegree'] ?? '',
                      description:
                          'From: ${edu['eduInstitute']}\n${edu['eduDescription'] ?? ''} \nLevel: ${edu['eduLevel']}'),
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
                    // Profile Memory Image
                    pw.ClipOval(
                      child: pw.Container(
                        width: 100,
                        height: 100,
                        color: lightGreen,
                        child: pw.Image(profileImage),
                      ),
                    ),

                    // Skills
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          _Category(title: 'Skills'),
                          for (var skill in skills)

                            // Round Circle Widget with Value
                            _Percent(
                              size: 60,
                              value: skill['skillProficiency'],
                              title: pw.Center(
                                  child: pw.Text(skill['skill'] ?? '')),
                            ),
                        ]),

                    // Barcode
                    pw.BarcodeWidget(
                      data: webSite,
                      height: 60,
                      width: 60,
                      barcode: pw.Barcode.qrCode(),
                      drawText: false,
                    ),
                  ]),
            ),
          ]),
        ),
      ]),
    ],
  ));

  // App Directory // File Path -1st Step
  final outPutDirectory = await getApplicationCacheDirectory();

  // App Directory // File Name - File Object -2nd Step
  final file = File('${outPutDirectory.path}/resume.pdf');

  // App Directory // File Write-Save -3rd Step
  await file.writeAsBytes(await doc.save());

  // App Directory // File Open-Load-Return -4th Step
  return file;
}

// PDF Page Theme
Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {

  // PDF Page Theme // Background Border SVG File Path-Name
  final bgShape = await rootBundle.loadString('assets/images/resume.svg');

  // PDF Page Theme // Page Margins
  format = format.applyMargin(
      left: PdfPageFormat.cm * 2.0,
      top: 4.0,
      right: PdfPageFormat.cm * 2.0,
      bottom: PdfPageFormat.cm * 2.0);

  // PDF Page Theme // Return Theme
  return pw.PageTheme(
    pageFormat: format,

    // PDF Page Theme // Fonts Settings
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),

    // PDF Page Theme // Background Border SVG Apply Locations
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(children: [

          // top left side border svg
          pw.Positioned(top: 0, left: 0, child: pw.SvgImage(svg: bgShape)),

          // bottom right side border svg Transform Rotate
          pw.Positioned(
            bottom: 0,
            right: 0,
            child: pw.Transform.rotate(
              angle: pi,
              child: pw.SvgImage(svg: bgShape),
            ),
          ),

        ]),
      );
    },
  );
}

// Url Text Class for Website - Emails
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

// Category Class for Headings with Circle Bullet
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

// Block Class for Heading & Descriptions
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

// Percent Class for Round Circle of Skills with % Filling and Title
class _Percent extends pw.StatelessWidget {
  _Percent({required this.size, required this.value, required this.title});
  final double size;
  final double value;
  final pw.Widget title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(children: [
      // Container
      pw.Container(
        height: size,
        width: size,

        // Stack for Overlapping Values Display
        child: pw.Stack(children: [
          // %age Value
          pw.Center(
            child: pw.Text('${(value * 100).round()}%'),
          ),

          // Circle with Fill Value
          pw.CircularProgressIndicator(
            value: value,
            backgroundColor: PdfColors.grey300,
            color: green,
            strokeWidth: 5,
          ),
        ]),
      ),

      // Directly Display Title Widget after Round Circle with Value
      title,
    ]);
  }
}
