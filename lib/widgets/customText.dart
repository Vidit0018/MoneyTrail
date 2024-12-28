import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text; // Input text
  final bool isBig; // Flag to determine if the font should be big or small
  final bool isSmall;
  const CustomText({
    Key? key,
    required this.text, // Require only the text
    this.isBig = false,
    this.isSmall= false, // Default to small size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the font size based on `isBig`
    double fontSize = isBig ? 30.0 : (isSmall? 12.0: 16.0); // Big font size: 30, small font size: 16

    return Text(
      text,
      style: TextStyle(
        fontFamily: 'fredoka', // Custom font
        fontSize: fontSize, // Use dynamic font size
        fontWeight:FontWeight.w900, // Fixed font weight
        color: const Color.fromARGB(255, 14, 62, 62),
// Fixed text color
      ),
    );
  }
}
