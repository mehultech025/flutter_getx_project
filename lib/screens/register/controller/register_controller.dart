import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_project/api/api_urls.dart';
import 'package:flutter_getx_project/api/repo/auth_repo.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/models/sign_up_res_model.dart';
import 'package:flutter_getx_project/utils/app_routes.dart';
import 'package:flutter_getx_project/widgets/app_snackbar.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
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

  // @override
  // void onInit() {
  //   super.onInit();
  //   emailController.clear();
  //   passController.clear();
  // }

  /// SIGN UP METHOD
  Future<void> onSignUpMethod() async {
    isLoading = true;
    update();

    final result = await AuthRepo.register(
      body: {
        "email": emailController.text.trim(),
        "password": passController.text.trim(),
      },
    );

    try {
      if (result.status && result.data != null) {
        final resModel = SignUpResModel.fromJson(result.data);

        if (resModel.token != null && resModel.id != null) {
          createUserIfNotExists(nameController.text.trim());
          ApiUrls.defaultName = nameController.text.trim();
          showSnackBar(message: AppStrings.signUpSuccessKey);
          Get.offAllNamed(Routes.bottomNavigation);
        } else {
          // Error or incomplete data
          showSnackBar(message: resModel.error ?? AppStrings.unexpectedTextKey,backgroundColor: Colors.red);
        }
      } else {
        showSnackBar(message: result.message ?? AppStrings.signUpFailedKey,backgroundColor: Colors.red);
      }
    } catch (e) {
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
