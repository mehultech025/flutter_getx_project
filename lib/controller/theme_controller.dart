import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Reactive ThemeMode and Color
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;
  final Rx<Color> _primaryColor = const Color(0xFF2196F3).obs;

  // Getters
  ThemeMode get themeMode => _themeMode.value;
  ThemeData get lightTheme => _buildTheme(_primaryColor.value, Brightness.light);
  ThemeData get darkTheme => _buildTheme(_primaryColor.value, Brightness.dark);

  // Toggle between light and dark
  void toggleTheme() {
    _themeMode.value =
    _themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    update();
  }

  void changePrimaryColor(Color newColor) {
    _primaryColor.value = newColor;
    update();
  }

  // Constants
  static const Color secondaryColor = Color(0xff1A1C1D);
  static const Color backgroundColor = Color(0xffFFFFFF);
  static const Color pageBackgroundColor = Color(0xffF7F9FF);
  static const Color errorColor = Color(0xffBA1A1A);
  static const Color tertiaryColor = Color(0xffEBEEF3);

  // Build Theme
  static ThemeData _buildTheme(Color primaryColor, Brightness brightness) {
    final bool isLightColor =
        ThemeData.estimateBrightnessForColor(primaryColor) == Brightness.light;
    final Color contrastText = isLightColor ? Colors.black : Colors.white;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
    ).copyWith(
      primary: primaryColor,
      onPrimary: contrastText,
      secondary: secondaryColor,
      surface: backgroundColor,
      error: errorColor,
      tertiary: tertiaryColor,
    );

    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor:
      brightness == Brightness.light ? pageBackgroundColor : Colors.black,
      colorScheme: colorScheme,
      textTheme: ThemeData(brightness: brightness).textTheme, // ✅ no GoogleFonts
      useMaterial3: true,
    );
  }
}
