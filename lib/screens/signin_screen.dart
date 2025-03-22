import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../screens/second_screen.dart';
import '../screens/signup_screen.dart';
import '../styles/app_constants.dart';
import '../styles/text_style.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureStatus = true;
  GlobalKey<FormState> formKey = GlobalKey();

  // // Users list
  List<UserModel> users = [];

  // Method to validate user credentials
  bool validateUser(String email, String password) {
    // Check if any user in the list matches the email and password
    for (var user in users) {
      if (user.email == email && user.password == password) {
        return true; // User is valid
      }
    }
    return false; // Invalid credentials
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.signInText,
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
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/qaiser21.jpg'),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  // initialValue: AppStrings.signInEmail??'',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This Field is required.';
                    }
                    return null;
                  },
                  style: hintTextStyles,
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
                      borderSide:
                          const BorderSide(color: Colors.deepOrange, width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.deepOrange, width: 3),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  // initialValue: AppStrings.signInPass??'',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This Field is required.';
                    }
                    return null;
                  },
                  style: hintTextStyles,
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
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.grey.shade500,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.grey.shade500,
                            ),
                    ),
                    labelText: 'Password',
                    labelStyle: labelTextStyles,
                    hintText: 'Enter your Password',
                    hintStyle: hintTextStyles,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.deepOrange, width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.deepOrange, width: 3),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      ));

                      // // Validate user credentials
                      // if (validateUser(
                      //     emailController.text, passwordController.text)) {
                      //   // Navigate to the SecondScreen if valid credentials
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => SecondScreen(
                      //       email: emailController.text,
                      //       password: passwordController.text,
                      //     ),
                      //   ));
                      // } else {
                      //   // Show error message if invalid credentials
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //         duration: Duration(seconds: 2),
                      //         behavior: SnackBarBehavior.floating,
                      //         backgroundColor: Colors.red,
                      //         content: Text('Invalid email or password')),
                      //   );
                      // }
                    }
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.green.shade500,
                      minimumSize:
                          Size(MediaQuery.sizeOf(context).width / 2, 55)),
                  child: const Text(
                    'SIGN IN',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignupScreen()));
                  },
                  child: const Text(
                    'Don\'t have an Account? Click here to REGISTER',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 4),
                  child: Divider(
                    color: Colors.orange.shade200,
                    thickness: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
