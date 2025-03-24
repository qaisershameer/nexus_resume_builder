import 'package:flutter/material.dart';
import '../resume/resume_pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import '../custom_widgets/my_app_button_icon.dart';
import '../styles/app_constants.dart';
import '../styles/text_style.dart';

class ResumeView extends StatefulWidget {
  const ResumeView(
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
      required this.interests,
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
  final List<String> interests;
  final List<String> degreeList;

  @override
  State<ResumeView> createState() => _ResumeViewState();
}

class _ResumeViewState extends State<ResumeView> {
  bool isGenerating = false;

  Future<void> _generateResumePdf() async {
    setState(() {
      isGenerating = true;
    });

    try {
      // Print PDF Generating
      final file = await generateResume(
          PdfPageFormat.letter,
          name: widget.name,
          jobTitle: widget.jobTitle,
          whatsApp: widget.whatsApp,
          email: widget.email,
          webSite: widget.webSite,
          address: widget.address,
          dateOfBirth: widget.dateOfBirth.toString(),
          gender: widget.gender,
          profileImagePath: widget.profileImage,
          workExperiences: widget.workExperiences,
          educations: widget.educations,
          skills: widget.skills,
          interests: widget.interests);

      // Success Message Show in Status Bar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Text('Resume Generated Successfully.')));

      await OpenFile.open(file.path);

    } catch (e) {
      debugPrint('Error $e');
      // Error Message Show in Status Bar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text('Resume Not Generated.')));

    } finally {
      setState(() {
        isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundImage: AssetImage('assets/images/qaiser20.jpg'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16,),
                      // Personal Information
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [Text(
                            widget.name,
                            style: myHeadingTextStyles,
                          ),],
                          ),
                          Row(children: [Text(
                            '${widget.jobTitle}\n${widget.whatsApp}\n${widget.webSite}\n${widget.email}',
                            style: labelTextStyles,
                          ),],),
                        ],
                      ),
                    ],
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

                  // Working Experience // Job Title
                  if (widget.workExperiences.isNotEmpty)
                  Text(
                    'Designation: ${widget.workExperiences[0]['jobTitle']}',
                    style: labelTextStyles,
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  // Working Experience // Job Company
                  if (widget.workExperiences.isNotEmpty)
                  Text(
                    'Company: ${widget.workExperiences[0]['jobCompany']}',
                    style: labelTextStyles,
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  // Working Experience // Job Description
                  if (widget.workExperiences.isNotEmpty)
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

                  // Education Details // Edu Degree
                  if (widget.educations.isNotEmpty)
                  Text(
                    'Degree: ${widget.educations[0]['eduDegree']}',
                    style: labelTextStyles,
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  // Education Details // Edu Institute
                  if (widget.educations.isNotEmpty)
                  Text(
                    'Institute: ${widget.educations[0]['eduInstitute']}',
                    style: labelTextStyles,
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  // Education Details // Edu Description
                  if (widget.educations.isNotEmpty)
                  Text(
                    'Details: ${widget.educations[0]['eduDescription']}',
                    style: labelTextStyles,
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  // Education Details // Edu Level
                  if (widget.educations.isNotEmpty)
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

                  // Skills // Skill
                  if (widget.skills.isNotEmpty)
                  Text(
                    'Skills: ${widget.skills[0]['skill']}',
                    style: labelTextStyles,
                  ),
                  const SizedBox(
                    height: 4,
                  ),

                  // Skills // Skill Proficiency
                  Text(
                    'Proficiency: ${(widget.skills[0]['skillProficiency'] * 100).round()}%',
                    style: labelTextStyles,
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  // Interests
                  Text(
                    'Interests: ${widget.interests.join(', ')}',
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
                      MyAppButtonIcon(
                          myOnPressed: () {

                            // // Before navigating back, clear any previous data in the lists
                            // widget.workExperiences.clear();
                            // widget.educations.clear();
                            // widget.skills.clear();

                            Navigator.of(context).pop();},
                          buttonText: 'Edit Resume',
                          buttonIcon: const Icon(Icons.note_alt_rounded)),

                      const SizedBox(
                        width: 32,
                      ),

                      // Print PDF Button
                      MyAppButtonIcon(
                          myOnPressed: _generateResumePdf,
                          buttonText: 'PDF Print',
                          buttonIcon: const Icon(Icons.print)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if(isGenerating)

          Positioned.fill(child: Container(
            height: 50,
            width: 50,
            color: Colors.teal.withAlpha(50),
            child: const Center(
              child: CircularProgressIndicator(
                value: 50,
                strokeWidth: 5,
              ),
            ),
          ),
          ),
      ],
    );
  }
}
