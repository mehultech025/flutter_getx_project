import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_project/api/api_urls.dart';
import 'package:flutter_getx_project/api/repo/auth_repo.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/models/sign_in_res_model.dart';
import 'package:flutter_getx_project/utils/app_routes.dart';
import 'package:flutter_getx_project/widgets/app_snackbar.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  ///TextEditing Controller
  TextEditingController emailController = TextEditingController(
    text: ApiUrls.defaultEmail,
  );
  TextEditingController passController = TextEditingController(
    text: ApiUrls.defaultPassword,
  );
  TextEditingController nameController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  Future<void> createUserIfNotExists(String userName) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(userName);

    final doc = await docRef.get();
    if (!doc.exists) {
      await docRef.set({
        'name': userName,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }


  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  /// Password Visibility
  bool isVisible = true;

  changeVisible() {
    isVisible = !isVisible;
    update();
  }

  @override
  void onInit() {
    super.onInit();

  }

  /// LOGIN METHOD
  Future<void> onLoginMethod() async {
    isLoading = true;
    update();

    final result = await AuthRepo.login(

      body: {
        "email": emailController.text.trim(),
        "password": passController.text.trim(),
      },
    );

    try {
      if (result.status && result.data != null) {
        final resModel = SignInResModel.fromJson(result.data);

        if (resModel.token != null) {
          createUserIfNotExists(nameController.text.trim());
          ApiUrls.defaultName = nameController.text.trim();
          Get.offAllNamed(Routes.bottomNavigation);
        } else {
          // Error or incomplete data
          showSnackBar(message: resModel.error ?? AppStrings.unexpectedTextKey,backgroundColor: Colors.red);
        }
      } else {
        showSnackBar(message: result.message ?? AppStrings.loginFailedKey,backgroundColor: Colors.red);
      }
    } catch (e) {
          showSnackBar(message: AppStrings.loginSuccessKey);
      showSnackBar(message: "${AppStrings.somethingWrongTextKey}: $e",backgroundColor: Colors.red);
    }

    isLoading = false;
    update();
  }

  @override
  void onClose() {
    focusNode.dispose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }
}
