import 'package:flutter/material.dart';
import '../custom_widgets/heading_section.dart';
import '../styles/app_constants.dart';
import '../styles/text_style.dart';
import '../models/user_model.dart';
import '../screens/home_screen.dart';
import '../screens/signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool obscureStatus = true;

  GlobalKey<FormState> formKey = GlobalKey();
  List<UserModel> users = [];

  void addNewUser() {
    // Collect data from controllers and create a new user
    UserModel newUser = UserModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      phone: phoneController.text,
    );

    // Add new user to the users list
    setState(() {
      users.add(newUser);
    });

    // Message Show in Status Bar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        content: Text('New User Added Successfully.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.registrationText,
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
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const HeadingSection(
                heading: AppStrings.signUpHeadingText,
                subHeading: AppStrings.signUpSubHeadingText,
              ),
              const SizedBox(
                height: 16,
              ),

              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(

                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey.shade500,
                  ),
                  labelText: 'Name',
                  labelStyle: labelTextStyles,
                  hintText: 'Enter your Name',
                  hintStyle: hintTextStyles,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 3),
                  ),
                ),
              ),

              const SizedBox(height: 12,),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.grey.shade500,
                  ),
                  labelText: 'Email',
                  labelStyle: labelTextStyles,
                  hintText: 'Enter your Email',
                  hintStyle: hintTextStyles,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 3),
                  ),
                ),
              ),

              const SizedBox(height: 12,),

              TextField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white),
                obscureText: obscureStatus,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey.shade500,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      obscureStatus = !obscureStatus;
                    }),
                    icon: obscureStatus
                        ? Icon(Icons.visibility_off, color: Colors.grey.shade500,)
                        : Icon(Icons.visibility, color: Colors.grey.shade500,),
                  ),
                  labelText: 'Password',
                  labelStyle: labelTextStyles,
                  hintText: 'Enter your Password',
                  hintStyle: hintTextStyles,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 3),
                  ),
                ),
              ),

              const SizedBox(height: 12,),


              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_in_talk,
                    color: Colors.grey.shade500,
                  ),
                  labelText: 'Phone Number',
                  labelStyle: labelTextStyles,
                  hintText: 'Enter your Phone Number',
                  hintStyle: hintTextStyles,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 3),
                  ),
                ),
              ),

              const SizedBox(height: 12,),


              FilledButton(
                onPressed: () {
                  addNewUser();

                  // Navigate to Main Screen
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                          // phone: emailController.text,
                          // password: passwordController.text
                          )));
                },
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    minimumSize:
                        Size(MediaQuery.sizeOf(context).width / 2, 55)),
                child: const Text(
                  'REGISTER',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SigninScreen()));
                },
                child: Text(
                  'already have an Account? Click here to LOGIN',
                  style: TextStyle(
                    color: Colors.green.shade500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
