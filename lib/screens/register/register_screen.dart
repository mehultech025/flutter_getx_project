import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/constant/app_validation.dart';
import 'package:flutter_getx_project/screens/register/controller/register_controller.dart';
import 'package:flutter_getx_project/widgets/app_conditional_widget.dart';
import 'package:flutter_getx_project/widgets/app_loader.dart';
import 'package:flutter_getx_project/widgets/custom_button.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';
import 'package:flutter_getx_project/widgets/custonm_text_button.dart';
import 'package:flutter_getx_project/widgets/gradient_background.dart';
import 'package:flutter_getx_project/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(
        initState: (state) {
          final controller = Get.find<RegisterController>();
          controller.focusNode.addListener(() {
            if (controller.focusNode.hasFocus) {
              // Show message when user taps on the text field
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.mockAPiKey),
                  duration: Duration(seconds: 5),
                ),
              );
            }
          });
        },
        builder: (controller) {
          return GradientBackground(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.person_add_alt_1_rounded, size: 60, color: Colors.white),
                  const SizedBox(height: 12),
                   CustomTextWidget(text:
                    AppStrings.createAccountTextKey,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                  ),
                  const SizedBox(height: 32),

                  // Glass Card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              CustomTextFieldWidget(
                                controller: controller.nameController,
                                text: AppStrings.nameKey,
                                hintText: AppStrings.hNameKey,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) return AppStrings.hNameKey;
                                  return null;
                                },
                                onChanged: (_) => controller.update(),
                              ),
                              const SizedBox(height: 16),
                              CustomTextFieldWidget(
                                controller: controller.emailController,
                                text: AppStrings.emailKey,
                                focusNode: controller.focusNode,
                                readOnly:  true,
                                hintText: AppStrings.hEmailKey,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                value!.isEmpty ? AppStrings.emailKey : null,
                                onChanged: (_) => controller.update(),
                              ),
                              const SizedBox(height: 16),
                              CustomTextFieldWidget(
                                controller: controller.passController,
                                text: AppStrings.passwordKey,
                                focusNode: controller.focusNode,
                                readOnly:  true,
                                hintText: AppStrings.hPasswordKey,
                                obscureText: controller.isVisible,
                                keyboardType: TextInputType.text,
                                suffixIcon: InkWell(
                                  onTap: controller.changeVisible,
                                  child: Icon(
                                    controller.isVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white70,
                                  ),
                                ),
                                validator: validatePassword,
                                onChanged: (_) => controller.update(),
                              ),
                              const SizedBox(height: 24),

                              // Register Button
                              If(
                                condition: !controller.isLoading,
                                child: (_) => CustomButton(
                                  text: AppStrings.signUpKey,
                                  onPressed: () {
                                    if (controller.formKey.currentState!.validate()) {
                                      controller.onSignUpMethod();
                                    }
                                  },
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white,
                                ),
                                replacement: (_) => const AppBoxLoader(top: 5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       CustomTextWidget(
                        text: AppStrings.alreadyAccountKey,
                        color: Colors.white70,
                      ),
                      CustomTextButton(
                        text: AppStrings.loginKey,
                        textColor: Colors.amber,
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
