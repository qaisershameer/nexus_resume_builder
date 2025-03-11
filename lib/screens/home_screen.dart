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
        title: Text(AppStrings.mainScreenHeading, style: appBarTextStyles,),
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
                  backgroundImage: NetworkImage(
                      "https://scontent.fmux3-1.fna.fbcdn.net/v/t39.30808-6/430040626_7215015261939972_8046632099632684340_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=RFymx1iqKXoQ7kNvgEExSs-&_nc_oc=AdgAPp9nPWGoX7WRH3LhHoN5OwHRndWKyMxXO0JVfvoX0WyGBlJZ5YQMND27lNjjdCE&_nc_zt=23&_nc_ht=scontent.fmux3-1.fna&_nc_gid=A8JAbWptkOUCmC7YfBqwPGR&oh=00_AYHm-sC1YfHem3M_TMbsCRYRLLwKA-QyXlnLCutn-K9vsA&oe=67D4626E"),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 72, vertical: 32),
                child: Divider(color: Colors.white, thickness: 1.0,),
              ),


              Text('already have an Account? Click here', style: TextStyle(
                color: Colors.green.shade500, fontSize: 14,
              ),),

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
                padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 32),
                child: Divider(color: Colors.green.shade200, thickness: 1.0,),
              ),

              const Text('don\'t have an Account? Click here', style: TextStyle(
                color: Colors.deepOrange, fontSize: 14,
              ),),


              FilledButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignupScreen()));
                },
                style: FilledButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: const Text(
                  'Sign Up / REGISTER',
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 32),
                child: Divider(color: Colors.deepOrange.shade200, thickness: 1.0,),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
