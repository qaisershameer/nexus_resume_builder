import 'package:flutter/material.dart';
import 'package:nexus_resumate/custom_widgets/app_text_form_field.dart';
import 'package:nexus_resumate/styles/app_theme.dart';

import '../styles/text_style.dart';

class MultiStepForm extends StatefulWidget {
  const MultiStepForm({super.key});

  @override
  State<MultiStepForm> createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  final int _currentStep = 0;
  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final List<bool> _completed = [false, false, false, false];

  // Personal Information Fields
  String name = '';
  String jobTitle = '';
  String whatsApp = '';
  String address = '';
  String email = '';
  String webSite = '';
  String profileImage =
      'https://scontent.fmux3-1.fna.fbcdn.net/v/t1.6435-9/103950851_3022651741176366_2111611552960664682_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=a5f93a&_nc_ohc=q8Bw8n4PVZUQ7kNvgFjh5kY&_nc_oc=AdghKKFctfcK3GpWYq2ywiYWmPBb6Ky_PnB2dbiY-naLoCnCEYezEf5aHhMO56U-Z-Q&_nc_zt=23&_nc_ht=scontent.fmux3-1.fna&_nc_gid=Aa9JqPCngI6IhaZVwFFlEiH&oh=00_AYEj46Tb-aKh-E3kyaT9wsyiyy7gew5ySqkjOi_IFAxttw&oe=67F9DA31';
  DateTime? dateOfBirth;
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(65)),
                    gradient: LinearGradient(
                      colors: [AppTheme.primary, AppTheme.secondary],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: -50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 45,
                      // backgroundImage: AssetImage("assets/profile.png"),
                      backgroundImage: NetworkImage(
                          "https://scontent.fmux3-1.fna.fbcdn.net/v/t1.6435-9/103950851_3022651741176366_2111611552960664682_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=a5f93a&_nc_ohc=q8Bw8n4PVZUQ7kNvgFjh5kY&_nc_oc=AdghKKFctfcK3GpWYq2ywiYWmPBb6Ky_PnB2dbiY-naLoCnCEYezEf5aHhMO56U-Z-Q&_nc_zt=23&_nc_ht=scontent.fmux3-1.fna&_nc_gid=Aa9JqPCngI6IhaZVwFFlEiH&oh=00_AYEj46Tb-aKh-E3kyaT9wsyiyy7gew5ySqkjOi_IFAxttw&oe=67F9DA31"),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 16,
            ),

            Stepper(
              type: StepperType.vertical,
              steps: [
                Step(
                  title: Text(
                    'Personal Information',
                    style: myTextStyles,
                  ),
                  content: Form(
                    child: Column(
                      children: [
                        AppTextFormField(
                          hintText: 'Full Name',
                          prefixIcon: Icons.person,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => name = value ?? '',
                        ),
                        AppTextFormField(
                          hintText: 'Job Title',
                          prefixIcon: Icons.work,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => jobTitle = value ?? '',
                        ),
                        AppTextFormField(
                          hintText: 'WhatsApp Number',
                          prefixIcon: Icons.phone_in_talk,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => whatsApp = value ?? '',
                        ),
                        AppTextFormField(
                          hintText: 'Address',
                          prefixIcon: Icons.home,
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                          onSaved: (value) => address = value ?? '',
                        ),
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
                                    initialDate: DateTime(2000),
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
                          height: 16,
                        ),
                        Row(
                          children: [
                            Text(
                              'Gender',
                              style: myTextStyles,
                            ),
                          ],
                        ),
                        ListTile(
                          title: Text('Male'),
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
                        ListTile(
                          title: Text('Female'),
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
                Step(title: Text('Work Experience'), content: Text('data')),
              ],
            ),

            //Continue Here From Stepper
          ],
        ),
      ),
    );
  }
}
