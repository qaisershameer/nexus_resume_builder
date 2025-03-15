import 'package:flutter/material.dart';
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
                height: 8,
              ),
              Text(
                'Proficiency: ${(widget.skills[0]['skillProficiency'] * 100).round()}%',
                style: labelTextStyles,
              ),

              // Divider Line 5
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),

              // Back Button
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.orange.shade500,
                    minimumSize:
                        Size(MediaQuery.sizeOf(context).width / 2, 35)),
                child: const Text(
                  'BACK TO RESUME',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
