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

  GlobalKey<FormState> formKey = GlobalKey();
  List<UserModel> users = [];

  bool obscureStatus = true;
  bool isEightCharacter = false;
  bool hasSymbol = false;
  bool hasOneDigit = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;

  RegExp symbolRegEx = RegExp(r'[~`!@#$%^&*()_+=/]');
  RegExp numericRegEx = RegExp(r'[0-9]');
  RegExp upperRegEx = RegExp(r'[A-Z]');
  RegExp lowerRegEx = RegExp(r'[a-z]');

  void passwordValidator(String password) {
    setState(() {
      isEightCharacter = false;
      if (password.length >= 8) {
        isEightCharacter = true;
      }

      hasSymbol = false;
      if (symbolRegEx.hasMatch(password)) {
        hasSymbol = true;
      }

      hasOneDigit = false;
      if (numericRegEx.hasMatch(password)) {
        hasOneDigit = true;
      }

      hasUpperCase = false;
      if (upperRegEx.hasMatch(password)) {
        hasUpperCase = true;
      }

      hasLowerCase = false;
      if (lowerRegEx.hasMatch(password)) {
        hasLowerCase = true;
      }
    });
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is require';
    }
    passwordValidator(value);
    if (!isEightCharacter ||
        !hasSymbol ||
        !hasOneDigit ||
        !hasUpperCase ||
        !hasLowerCase) {
      return 'Password does not match the Password Criteria';
    }
    return null;
  }

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
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                const HeadingSection(
                  heading: AppStrings.signUpHeadingText,
                  subHeading: AppStrings.signUpSubHeadingText,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This Field is required.';
                    }
                    return null;
                  },
                  style: hintTextStyles,
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
                  height: 12,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  height: 12,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  validator: (value) => validator(value),
                  onChanged: (value) {
                    passwordValidator(value);
                    // setState(() {});
                  },
                  style: hintTextStyles,
                  obscureText: obscureStatus,
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
                  height: 12,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This Field is required.';
                    }
                    return null;
                  },
                  style: hintTextStyles,
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
                  height: 12,
                ),
                CheckingTile(
                  isCheck: isEightCharacter,
                  title: 'Is Eight Character',
                ),
                const SizedBox(
                  height: 10,
                ),
                CheckingTile(
                  isCheck: hasSymbol,
                  title: 'Contain Symbol (~`!@#\$%^&*()_+=/)',
                ),
                const SizedBox(
                  height: 10,
                ),
                CheckingTile(
                  isCheck: hasOneDigit,
                  title: 'Contain one Digit',
                ),
                const SizedBox(
                  height: 10,
                ),
                CheckingTile(
                  isCheck: hasUpperCase,
                  title: 'Contains Lower Case',
                ),
                const SizedBox(
                  height: 10,
                ),
                CheckingTile(
                  isCheck: hasLowerCase,
                  title: 'Contain Upper Case',
                ),
                const SizedBox(
                  height: 10,
                ),
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // print('Strong Password Entered');

                      addNewUser();

                      // Navigate to Main Screen
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen(
                              // phone: emailController.text,
                              // password: passwordController.text
                              )));
                    }
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
      ),
    );
  }
}

class CheckingTile extends StatelessWidget {
  const CheckingTile({
    super.key,
    required this.isCheck,
    required this.title,
  });

  final bool isCheck;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: 10,
        ),
        AnimatedContainer(
          duration: const Duration(microseconds: 800),
          decoration: BoxDecoration(
              color: isCheck ? Colors.green : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: isCheck ? Colors.transparent : Colors.green)),
          child: Icon(
            Icons.check,
            size: 15,
            color: isCheck ? Colors.white : Colors.grey.shade500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: labelTextStyles,
        ),
      ],
    );
  }
}
