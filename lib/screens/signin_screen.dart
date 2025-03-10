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
        title: Text(AppStrings.signInText, style: appBarTextStyles,),
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
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        "https://scontent.fmux3-1.fna.fbcdn.net/v/t39.30808-6/430040626_7215015261939972_8046632099632684340_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=RFymx1iqKXoQ7kNvgEExSs-&_nc_oc=AdgAPp9nPWGoX7WRH3LhHoN5OwHRndWKyMxXO0JVfvoX0WyGBlJZ5YQMND27lNjjdCE&_nc_zt=23&_nc_ht=scontent.fmux3-1.fna&_nc_gid=A8JAbWptkOUCmC7YfBqwPGR&oh=00_AYHm-sC1YfHem3M_TMbsCRYRLLwKA-QyXlnLCutn-K9vsA&oe=67D4626E"),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

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


                const SizedBox(
                  height: 12,
                ),
                FilledButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()){
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
                  height: 16,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
