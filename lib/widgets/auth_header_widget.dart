import 'package:flutter/material.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String title;

  const AuthHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Center(
        child: CustomTextWidget(
          text: title,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
