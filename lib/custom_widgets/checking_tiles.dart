import 'package:flutter/material.dart';
import '../styles/text_style.dart';

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
