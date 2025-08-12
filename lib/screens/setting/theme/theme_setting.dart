import 'package:flutter/material.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/screens/setting/theme/custom_theme.dart';
import 'package:flutter_getx_project/screens/setting/widget/theme_option_tile.dart';
import 'package:flutter_getx_project/utils/app_routes.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';
import 'package:flutter_getx_project/widgets/gradient_background.dart';
import 'package:get/get.dart';

class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({super.key});

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  ThemeMode _selectedTheme = Get.theme.brightness == Brightness.dark
      ? ThemeMode.dark
      : ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(AppStrings.themeSettingsKey),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ThemeOptionTile(
                icon: Icons.wb_sunny_outlined,
                title: AppStrings.lightThemeKey,
                themeMode: ThemeMode.light,
                selectedTheme: _selectedTheme,
                onTap: () {
                  setState(() {
                    _selectedTheme = ThemeMode.light;
                  });
                },
              ),
              ThemeOptionTile(
                icon: Icons.dark_mode_outlined,
                title: AppStrings.darkThemeKey,
                themeMode: ThemeMode.dark,
                selectedTheme: _selectedTheme,
                onTap: () {
                  setState(() {
                    _selectedTheme = ThemeMode.dark;
                  });

                },
              ),
              ThemeOptionTile(
                icon: Icons.settings_suggest,
                title:AppStrings.customThemeKey,
                themeMode: ThemeMode.system,
                selectedTheme: _selectedTheme,
                onTap: () {
                  setState(() {
                    _selectedTheme = ThemeMode.system;
                  });
                  Get.toNamed(Routes.themeSwitcher);
                },
              ),
              const Spacer(),
              const Center(
                child: CustomTextWidget(
                  text: "Choose your vibe ✨",
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

}
