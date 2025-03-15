import 'package:flutter/material.dart';
import '../custom_widgets/heading_section.dart';
import '../screens/multi_step_form.dart';
import '../styles/app_constants.dart';
import '../styles/text_style.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key, required this.email, required this.password});
  final String email;
  final String password;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.mainScreenHeading,
          style: appBarTextStyles,
        ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 16,
              // ),

              const CircleAvatar(
                radius: 95,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage('assets/images/qaiser24.jpg'),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              const HeadingSection(
                heading: AppStrings.welcomeText,
                subHeading: AppStrings.resumeText,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),

              Text(
                'Email: ${widget.email}',
                style: labelTextStyles,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Password: ${widget.password}',
                style: labelTextStyles,
              ),

              const SizedBox(
                height: 16,
              ),

              FilledButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MultiStepForm(),
                  ));
                },
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                    minimumSize:
                        Size(MediaQuery.sizeOf(context).width / 2, 55)),
                child: const Text(
                  'CLICK TO CONTINUE',
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 72, vertical: 16),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
