import 'package:flutter/material.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';
import 'package:flutter_getx_project/widgets/gradient_background.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_project/controller/theme_controller.dart';

class ThemeSwitcherScreen extends StatelessWidget {
  ThemeSwitcherScreen({super.key});

  static Widget getRouteInstance() => ThemeSwitcherScreen();

  final List<Color> colorOptions = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    const Color(0xff6dca95),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(AppStrings.chooseThemeKey),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: GradientBackground(
        child: SafeArea(
          child: GetBuilder<ThemeController>(
            builder: (controller) {
              final selectedColor = controller.lightTheme.primaryColor;
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                      text: AppStrings.themeNoteKey,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: colorOptions.map((color) {
                          final isSelected = color.value == selectedColor.value;
                          return GestureDetector(
                            onTap: () {
                              controller.changePrimaryColor(color);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(16),
                                border: isSelected
                                    ? Border.all(color: Colors.white, width: 3)
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: const Offset(2, 2),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: CustomTextWidget(
                        text: AppStrings.themeTapKey,
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        )
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
