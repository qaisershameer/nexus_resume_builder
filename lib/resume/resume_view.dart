import 'package:flutter/material.dart';
import 'package:nexus_resumate/resume/resume_pdf.dart';
import 'package:pdf/pdf.dart';
import '../custom_widgets/my_app_button_icon.dart';
import '../styles/app_constants.dart';
import '../styles/text_style.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen(
      {super.key,
      required this.name,
      required this.jobTitle,
      required this.whatsApp,
      required this.email,
      required this.webSite,
      required this.address,
      required this.dateOfBirth,
      required this.gender,
      required this.profileImage,
      required this.workExperiences,
      required this.educations,
      required this.skills,
      required this.selectedInterests,
      required this.degreeList});

  // Personal Information
  final String name;
  final String jobTitle;
  final String whatsApp;
  final String email;
  final String webSite;
  final String address;
  final String dateOfBirth;
  final String gender;
  final String profileImage;

  // Work Experience , Education , Skills , Interests
  final List<Map<String, String>> workExperiences;
  final List<Map<String, String>> educations;
  final List<Map<String, dynamic>> skills;
  final List<String> selectedInterests;
  final List<String> degreeList;

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  bool isGenerating = false;

  Future<void> _generateResumePdf() async {
    setState(() {
      isGenerating = true;
    });

    try {
      final file = await generateResume(
          PdfPageFormat.letter,
          name: widget.name,
          jobTitle: widget.jobTitle,
          whatsApp: widget.whatsApp,
          email: widget.email,
          webSite: widget.webSite,
          address: widget.address,
          dateOfBirth: widget.dateOfBirth,
          gender: widget.gender,
          profileImagePath: widget.profileImage,
          workExperiences: widget.workExperiences,
          educations: widget.educations,
          skills: widget.skills,
          interests: widget.selectedInterests);
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.mainScreenHeading,
          style: appBarTextStyles,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        color: const Color.fromARGB(255, 15, 15, 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // profile image
              const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/qaiser20.jpg'),
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              // Divider Line 1
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),

              // Personal Information
              Text(
                'Name: ${widget.name}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Job Title: ${widget.jobTitle}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'WhatsApp: ${widget.whatsApp}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Email: ${widget.email}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Website: ${widget.webSite}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Address: ${widget.address}',
                style: labelTextStyles,
              ),

              // Divider Line 2
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),

              // Working Experience
              Text(
                'Designation: ${widget.workExperiences[0]['jobTitle']}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Company: ${widget.workExperiences[0]['jobCompany']}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Work Details: ${widget.workExperiences[0]['jobDescription']}',
                style: labelTextStyles,
              ),

              // Divider Line 3
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),

              // Education Details
              Text(
                'Degree: ${widget.educations[0]['eduDegree']}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Institute: ${widget.educations[0]['eduInstitute']}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Details: ${widget.educations[0]['eduDescription']}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Level: ${widget.educations[0]['eduLevel']}',
                style: labelTextStyles,
              ),

              // Divider Line 4
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),

              // Skills
              Text(
                'Skills: ${widget.skills[0]['skill']}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Proficiency: ${(widget.skills[0]['skillProficiency'] * 100).round()}%',
                style: labelTextStyles,
              ),

              // Divider Line 5
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Edit Resume Button
                  MyAppButtonIcon(myOnPressed: () => Navigator.of(context).pop(), buttonText: 'Edit Resume', buttonIcon: const Icon(Icons.note_alt_rounded)),

                  const SizedBox(
                    width: 32,
                  ),

                  // Print PDF Resume Button
                  MyAppButtonIcon(myOnPressed: () => Navigator.of(context).pop(), buttonText: 'PDF Print', buttonIcon: const Icon(Icons.print)),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
