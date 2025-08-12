import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final IconData? icon;
  final double borderRadius;
  final bool isUpperCase;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF0083B0),
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.icon,
    this.borderRadius = 12.0,
    this.isUpperCase = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: icon != null ? Icon(icon, color: textColor) : const SizedBox(),
        label: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 4,
          shadowColor: Colors.black45,
        ),
      ),
    );
  }
}
