import 'package:flutter/material.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';


class CustomTextFieldWidget extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? keyboardType;
  String? hintText;
  String text;
  Widget? suffixIcon;
  bool readOnly;
  String? fontFamily;
  void Function()? onTap;
  FontWeight? fontWeight;
  bool obscureText;
  bool isBorder;
  FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  String? Function(String?)? validator;

  CustomTextFieldWidget(
      {super.key,
      this.controller,
      this.hintText,
      this.keyboardType,
      required this.text,
      this.suffixIcon,
      this.fontWeight,
      this.fontFamily,
      this.readOnly = false,
      this.obscureText = false,
      this.isBorder = false,
        this.onChanged,
        this.validator,
        this.focusNode,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: text,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          focusNode: focusNode,
          autofocus: false,
          controller: controller,
          onTap: onTap,
          readOnly: readOnly ?? false,
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            filled: true,
            // Adjust vertical padding
            fillColor: Colors.white,
            hintText: hintText ?? "",
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.blue, width: 1.5),
            ),
            suffixIcon: suffixIcon, // Added trailing widget
          ),
        )
      ],
    );
  }
}
