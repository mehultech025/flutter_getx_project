import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final double fontSize;
  final bool underline;
  final FontWeight fontWeight;
  final TextAlign alignment;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = const Color(0xFF0083B0),
    this.fontSize = 16,
    this.underline = false,
    this.fontWeight = FontWeight.w500,
    this.alignment = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: alignment,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: underline ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}
