import 'package:flutter/material.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/screens/setting/widget/settings_tile.dart';
import 'package:flutter_getx_project/utils/app_routes.dart';
import 'package:flutter_getx_project/widgets/gradient_background.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _logout() {
    // You can add actual logout logic here (e.g., clearing tokens, session, etc.)
    Get.offAllNamed(Routes.login);
  }

  void _openThemeSettings() {
    Get.toNamed(Routes.themeSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.only(top: kToolbarHeight + 20),
          children: [
            SettingsTile(
              icon: Icons.color_lens_outlined,
              title: AppStrings.themeSettingsKey,
              color: Colors.redAccent,
              onTap: _openThemeSettings,
            ),
            const SettingsTile(
              icon: Icons.lock_outline,
              title: AppStrings.changePasswordsKey,
              onTap: null, // You can link to a password screen
            ),
            const SettingsTile(
              icon: Icons.notifications_none,
              title: AppStrings.notificationKey,
              onTap: null,
            ),
            const SettingsTile(
              icon: Icons.privacy_tip_outlined,
              title: AppStrings.privacyPolicyKey,
              onTap: null,
            ),
            const SettingsTile(
              icon: Icons.info_outline,
              title:AppStrings.aboutUsKey,
              onTap: null,
            ),
            SettingsTile(
              icon: Icons.logout,
              title: AppStrings.logoutKey,
              color: Colors.redAccent,
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}
