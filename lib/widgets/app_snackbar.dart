import 'package:flutter/material.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';
import 'package:get/get.dart';


SnackbarController showSnackBar({
  String? message,
  Color backgroundColor = Colors.blue, // default is red for error
}) {
  return Get.showSnackbar(
    GetSnackBar(
      messageText: CustomTextWidget(
        text: message ?? AppStrings.somethingWrongTextKey,
        color: Colors.white,
        fontSize: 12,
      ),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      snackPosition: SnackPosition.TOP,
    ),
  );
}
