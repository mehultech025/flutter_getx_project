import 'package:flutter/material.dart';


class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? decorationColor;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final double? fontSize;
  final int? maxLines;
  final double? minFontSize;
  final double? maxFontSize;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

   const CustomTextWidget({
    required this.text,
    this.color,
    this.decorationColor,
    this.fontFamily,
    this.fontWeight,
    this.decoration,
    this.fontSize,
    this.maxLines,
    this.minFontSize,
    this.maxFontSize,
    this.textAlign,
    this.overflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Text(
      text,
      style: TextStyle(
         color: color ?? Colors.black,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: decorationColor,
        fontSize: fontSize??16,
        overflow: overflow
      ),
      maxLines: maxLines,
      textAlign: textAlign,

    );
  }
}
