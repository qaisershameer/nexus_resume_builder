import 'package:flutter/material.dart';
import '../styles/text_style.dart';

class HeadingSection extends StatelessWidget {
  const HeadingSection({
    super.key,
    required this.heading,
    required this.subHeading,
  });

  final String heading;
  final String subHeading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: headingTextStyles,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          subHeading,
          style: subHeadingTextStyles,
        ),
      ],
    );
  }
}
