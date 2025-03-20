import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppButtonIcon extends StatelessWidget {
  const MyAppButtonIcon({
    super.key,
    required this.myOnPressed,
    required this.buttonText,
    required this.buttonIcon,
  });

  final void Function() myOnPressed;
  final String buttonText;
  final Icon buttonIcon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: buttonIcon,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
      ),
      label: Text(
        buttonText,
        style: GoogleFonts.lato(),
      ),
      onPressed:
          // screen switching
          myOnPressed,
    );
  }
}
