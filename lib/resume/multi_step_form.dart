import 'package:flutter/material.dart';
import 'package:nexus_resumate/styles/app_constants.dart';
import '../custom_widgets/app_text_form_field.dart';
import 'resume_view.dart';
import '../styles/app_theme.dart';
import '../styles/text_style.dart';

class MultiStepForm extends StatefulWidget {
  const MultiStepForm({super.key});

  @override
  State<MultiStepForm> createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  int _currentStep = 0;
  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final List<bool> _completedSteps = [false, false, false, false];

  // Personal Information Fields
  String name = '';
  String jobTitle = '';
  String whatsApp = '';
  String address = '';
  String email = '';
  String webSite = '';
  // String profileImage = 'https://scontent.fmux3-1.fna.fbcdn.net/v/t1.6435-9/103950851_3022651741176366_2111611552960664682_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=a5f93a&_nc_ohc=q8Bw8n4PVZUQ7kNvgFjh5kY&_nc_oc=AdghKKFctfcK3GpWYq2ywiYWmPBb6Ky_PnB2dbiY-naLoCnCEYezEf5aHhMO56U-Z-Q&_nc_zt=23&_nc_ht=scontent.fmux3-1.fna&_nc_gid=Aa9JqPCngI6IhaZVwFFlEiH&oh=00_AYEj46Tb-aKh-E3kyaT9wsyiyy7gew5ySqkjOi_IFAxttw&oe=67F9DA31';
  String profileImage = 'assets/images/qaiser20.jpg';
  DateTime? dateOfBirth;
  String? gender;

  // Work Experience , Education , Skills , Interests
  List<Map<String, String>> workExperiences = [];
  List<Map<String, String>> educations = [];

  // Add Multi Skills Working
  List<Map<String, dynamic>> skills = [];
  // List<TextEditingController> skillControllers = [];
  // List<double> proficiencyValues = [];

  List<String> selectedInterests = [];
  List<String> degreeList = [
    'Matriculation',
    'Intermediate',
    'Bachelors',
    'Graduate',
    'Masters',
    'P.H.D'
  ];

  // Temporary Variables for Step Inputs
  String tempJobTitle = '';
  String tempJobCompany = '';
  String tempJobDescription = '';

  String tempEducationDegree = '';
  String tempEducationInstitute = '';
  String tempEducationDescription = '';
  String? tempEducationLevel;

  String tempSkill = '';
  double tempSkillProficiency = 0.5;

  void _onStepContinue() {

    final isValid = _formKeys[_currentStep].currentState?.validate() ?? false;
    if (isValid) {
      _formKeys[_currentStep].currentState?.save();

      if (_currentStep == 1) {

        // first clear list WORK EXPERIENCES
        workExperiences.clear();

        // add values list WORK EXPERIENCES
        workExperiences.add({
          'jobTitle': tempJobTitle,
          'jobCompany': tempJobCompany,
          'jobDescription': tempJobDescription,
        });

        tempJobTitle = '';
        tempJobCompany = '';
        tempJobDescription = '';

      } else if (_currentStep == 2) {

        // first clear list EDUCATION
        educations.clear();

        // add values list EDUCATION
        educations.add({
          'eduDegree': tempEducationDegree,
          'eduInstitute': tempEducationInstitute,
          'eduDescription': tempEducationDescription,
          'eduLevel': tempEducationLevel ?? 'Unknown',
        });

        tempEducationDegree = '';
        tempEducationInstitute = '';
        tempEducationDescription = '';
        tempEducationLevel = null;

      } else if (_currentStep == 3) {

        // first clear list SKILLS
        skills.clear();

        // add values list SKILLS
        skills.add({
          'skill': tempSkill,
          'skillProficiency': tempSkillProficiency,
        });

        tempSkill = '';
        tempSkillProficiency = 0.5;

        // // Add each skill and its proficiency value to the list
        // for (int i = 0; i < skillControllers.length; i++) {
        //   String skillName = skillControllers[i].text;
        //   double skillProficiency = proficiencyValues[i];
        //
        //   if (skillName.isNotEmpty) {
        //     skills.add({
        //       'skill': skillName,
        //       'skillProficiency': skillProficiency,
        //     });
        //   }
        // }
        //
        // // Reset fields for next step
        // skillControllers.clear();
        // proficiencyValues.clear();

      }

      setState(() {
        _completedSteps[_currentStep] = true;
        if (_currentStep < 3) {
          _currentStep += 1;
        } else {
          // we are on last state // view resume here below
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ResumeView(
                name: name,
                jobTitle: jobTitle,
                whatsApp: whatsApp,
                email: email,
                webSite: webSite,
                address: address,
                // dateOfBirth: '${dateOfBirth!.day}/${dateOfBirth!.month}/${dateOfBirth!.year}',
                dateOfBirth: dateOfBirth != null ? '${dateOfBirth!.day}/${dateOfBirth!.month}/${dateOfBirth!.year}' : 'Not Provided',
                gender: gender ?? 'Male',
                profileImage: profileImage,
                workExperiences: workExperiences,
                educations: educations,
                skills: skills,
                interests: selectedInterests,
                degreeList: degreeList),
          ));

        }
      });
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  // @override
  // void dispose() {
  //   // Dispose all controllers to free up resources
  //   for (var controller in skillControllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Header Top Banner Background
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(65)),
                  gradient: LinearGradient(
                    colors: [AppTheme.primary, AppTheme.secondary],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // Header Image
              const Positioned(
                bottom: -50,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(AppStrings.image20),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Stepper Section
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              type: StepperType.vertical,
              onStepContinue: _onStepContinue,
              onStepCancel: _onStepCancel,
              steps: [
                // Personal Information
                Step(
                  isActive: _currentStep >= 0,
                  state: _completedSteps[0]
                      ? StepState.complete
                      : StepState.indexed,
                  title: Text(
                    'Personal Information',
                    style: myTextStyles,
                  ),
                  content: Form(
                    key: _formKeys[0],
                    child: Column(
                      children: [
                        // Name
                        AppTextFormField(
                          hintText: 'Full Name',
                          prefixIcon: Icons.person,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => name = value ?? '',
                        ),
                        // Job Title
                        AppTextFormField(
                          hintText: 'Job Title',
                          prefixIcon: Icons.work,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => jobTitle = value ?? '',
                        ),
                        // WhatsApp
                        AppTextFormField(
                          keyboardType: TextInputType.phone,
                          hintText: 'Phone Number',
                          prefixIcon: Icons.phone_in_talk,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => whatsApp = value ?? '',
                        ),
                        // Email
                        AppTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => email = value ?? '',
                        ),
                        // Website
                        AppTextFormField(
                          keyboardType: TextInputType.url,
                          hintText: 'Website',
                          prefixIcon: Icons.web,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => webSite = value ?? '',
                        ),
                        // Address
                        AppTextFormField(
                          hintText: 'Address',
                          prefixIcon: Icons.home,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => address = value ?? '',
                        ),
                        // Date of Birth
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date of Birth',
                              style: myTextStyles,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(1990),
                                    firstDate: DateTime(1971),
                                    lastDate: DateTime(2020));
                                if (pickedDate != null) {
                                  setState(() {
                                    dateOfBirth = pickedDate;
                                  });
                                }
                              },
                              child: Card(
                                color: AppTheme.primary,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_month,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            dateOfBirth == null
                                                ? 'Select Date of Birth'
                                                : '${dateOfBirth!.day}/${dateOfBirth!.month}/${dateOfBirth!.year}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // Gender
                        Row(
                          children: [
                            Text(
                              'Gender',
                              style: myTextStyles,
                            ),
                          ],
                        ),
                        // Gender: Male
                        ListTile(
                          title: const Text('Male'),
                          leading: Radio(
                            value: 'Male',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                        ),
                        // Gender: Female
                        ListTile(
                          title: const Text('Female'),
                          leading: Radio(
                            value: 'Female',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Work Experience
                Step(
                  isActive: _currentStep >= 2,
                  state: _completedSteps[1]
                      ? StepState.complete
                      : StepState.indexed,
                  title: Text(
                    'Work Experience',
                    style: myTextStyles,
                  ),
                  content: Form(
                    key: _formKeys[1],
                    child: Column(
                      children: [
                        // Job Title
                        AppTextFormField(
                          hintText: 'Job Title',
                          prefixIcon: Icons.work,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => tempJobTitle = value ?? '',
                        ),
                        // Company Name
                        AppTextFormField(
                          hintText: 'Company Name',
                          prefixIcon: Icons.business,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => tempJobCompany = value ?? '',
                        ),
                        // Job Description
                        AppTextFormField(
                          hintText: 'Job Description',
                          prefixIcon: Icons.description_outlined,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => tempJobDescription = value ?? '',
                        ),
                      ],
                    ),
                  ),
                ),

                // Education
                Step(
                  isActive: _currentStep >= 2,
                  state: _completedSteps[2]
                      ? StepState.complete
                      : StepState.indexed,
                  title: Text(
                    'Education',
                    style: myTextStyles,
                  ),
                  content: Form(
                    key: _formKeys[2],
                    child: Column(
                      children: [
                        // Eduction Degree
                        AppTextFormField(
                          hintText: 'Degree',
                          prefixIcon: Icons.history_edu,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => tempEducationDegree = value ?? '',
                        ),
                        // Education Institute Name
                        AppTextFormField(
                          hintText: 'Institute',
                          prefixIcon: Icons.business,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) =>
                              tempEducationInstitute = value ?? '',
                        ),
                        // Education Description
                        AppTextFormField(
                          hintText: 'Education Description',
                          prefixIcon: Icons.description,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) =>
                              tempEducationDescription = value ?? '',
                        ),
                        // Education Level -- Degree List --
                        DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                labelText: 'Education Level',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            items: degreeList
                                .map(
                                  (level) => DropdownMenuItem(
                                      value: level, child: Text(level)),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                tempEducationLevel = value;
                              });
                            })
                      ],
                    ),
                  ),
                ),

                // Skills
                Step(
                  isActive: _currentStep >= 3,
                  state: _completedSteps[3]
                      ? StepState.complete
                      : StepState.indexed,
                  title: Text(
                    'Skills',
                    style: myTextStyles,
                  ),
                  content: Form(
                    key: _formKeys[3],
                    child: Column(
                      children: [

                        // Skill Name
                        AppTextFormField(
                          hintText: 'Skill Name',
                          prefixIcon: Icons.description_sharp,
                          // keyboardType: TextInputType.multiline,
                          // maxLines: 2,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => tempSkill = value ?? '',
                        ),
                        // Skill Proficiency Slider
                        Slider(
                          value: tempSkillProficiency,
                          min: 0,
                          max: 1,
                          divisions: 10,
                          label: '${(tempSkillProficiency * 100).round()}%',
                          onChanged: (value) {
                            setState(() {
                              tempSkillProficiency = value;
                            });
                          },
                        ),

                        // // Display skill input fields
                        // ListView.builder(
                        //   itemCount: skillControllers.length,
                        //   itemBuilder: (context, index) {
                        //     return Column(
                        //       children: [
                        //         // Skill Name Input
                        //         AppTextFormField(
                        //           controller: skillControllers[index],
                        //           hintText: 'Skill Name',
                        //           prefixIcon: Icons.description_sharp,
                        //           validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                        //         ),
                        //         // Skill Proficiency Slider
                        //         Slider(
                        //           value: proficiencyValues[index],
                        //           min: 0,
                        //           max: 1,
                        //           divisions: 10,
                        //           label: '${(proficiencyValues[index] * 100).round()}%',
                        //           onChanged: (value) {
                        //             setState(() {
                        //               proficiencyValues[index] = value;
                        //             });
                        //           },
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // ),
                        // // Add Skill Button
                        // IconButton(
                        //   icon: const Icon(Icons.add),
                        //   onPressed: () {
                        //     setState(() {
                        //       skillControllers.add(TextEditingController());
                        //       proficiencyValues.add(0.5); // Default proficiency
                        //     });
                        //   },
                        // ),

                        // Interests
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text('Field of Interests', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primary),),

                            CheckboxListTile(title: const Text('Arts Designing'), value: selectedInterests.contains('Arts Designing'), onChanged: (value) {
                              setState(() {
                                if (value == true){
                                  selectedInterests.add('Arts Designing');
                                } else {
                                  selectedInterests.remove('Arts Designing');
                                }
                              });
                            },),
                            CheckboxListTile(title: const Text('App Development'), value: selectedInterests.contains('App Development'), onChanged: (value) {
                              setState(() {
                                if (value == true){
                                  selectedInterests.add('App Development');
                                } else {
                                  selectedInterests.remove('App Development');
                                }
                              });
                            },),
                            CheckboxListTile(title: const Text('Desktop Apps Dev'), value: selectedInterests.contains('Desktop Business Apps'), onChanged: (value) {
                              setState(() {
                                if (value == true){
                                  selectedInterests.add('Desktop Business Apps');
                                } else {
                                  selectedInterests.remove('Desktop Business Apps');
                                }
                              });
                            },),
                            CheckboxListTile(title: const Text('Web Laravel Apps'), value: selectedInterests.contains('Web Development'), onChanged: (value) {
                              setState(() {
                                if (value == true){
                                  selectedInterests.add('Web Development');
                                } else {
                                  selectedInterests.remove('Web Development');
                                }
                              });
                            },),
                            CheckboxListTile(title: const Text('Technology Gossips'), value: selectedInterests.contains('Technology Gossips'), onChanged: (value) {
                              setState(() {
                                if (value == true){
                                  selectedInterests.add('Technology Gossips');
                                } else {
                                  selectedInterests.remove('Technology Gossips');
                                }
                              });
                            },),
                            CheckboxListTile(title: const Text('Sports -Cricket -Football'), value: selectedInterests.contains('Sports -Cricket -Football'), onChanged: (value) {
                              setState(() {
                                if (value == true){
                                  selectedInterests.add('Sports -Cricket -Football');
                                } else {
                                  selectedInterests.remove('Sports -Cricket -Football');
                                }
                              });
                            },),
                            CheckboxListTile(title: const Text('Extras -Swimming -Reading'), value: selectedInterests.contains('Extras -Swimming -Reading'), onChanged: (value) {
                              setState(() {
                                if (value == true){
                                  selectedInterests.add('Extras -Swimming -Reading');
                                } else {
                                  selectedInterests.remove('Extras -Swimming -Reading');
                                }
                              });
                            },),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          //Continue Here From Stepper
        ],
      ),
    );
  }
}
