import 'package:flutter/material.dart';
import '../screens/signin_screen.dart';
import '../screens/signup_screen.dart';
import '../styles/app_constants.dart';
import '../styles/text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        color: const Color.fromARGB(255, 15, 15, 15),
        // padding: const EdgeInsets.all(8),
        // margin:  const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 95,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage('assets/images/qaiser20.jpg'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 72, vertical: 32),
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),
              Text(
                'already have an Account? Click here',
                style: TextStyle(
                  color: Colors.green.shade500,
                  fontSize: 14,
                ),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SigninScreen()));
                },
                style: FilledButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  'Sign In / LOGIN',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 72, vertical: 32),
                child: Divider(
                  color: Colors.green.shade200,
                  thickness: 1.0,
                ),
              ),
              const Text(
                'don\'t have an Account? Click here',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 14,
                ),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignupScreen()));
                },
                style:
                    FilledButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: const Text(
                  'Sign Up / REGISTER',
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 72, vertical: 32),
                child: Divider(
                  color: Colors.deepOrange.shade200,
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
