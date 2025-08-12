import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/models/bottomNavItem.dart';
import 'package:flutter_getx_project/screens/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:flutter_getx_project/screens/chat/chat_user_list.dart';
import 'package:flutter_getx_project/screens/setting/setting_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_project/screens/home/home_screen.dart';
import 'package:flutter_getx_project/screens/profile/profile_scren.dart';
import 'package:flutter_getx_project/widgets/bottomNavItemContainer.dart';


class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  String userId="MT";

  int scanPageCount=0;

  getScanCount() async {
    final userDocRef = FirebaseFirestore.instance.collection('MTusers').doc(userId);
    final docSnapshot = await userDocRef.get();
    scanPageCount=docSnapshot["scanPageCount"]??0;
  }

  final List<BottomNavItem> _bottomNavItems = [
    BottomNavItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      title: AppStrings.homeKey,
    ),
    BottomNavItem(
      icon: Icons.chat_bubble_outline,
      selectedIcon: Icons.chat_bubble,
      title: AppStrings.chatKey,
    ),
    BottomNavItem(
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      title: AppStrings.profileKey,
    ),
    BottomNavItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      title: AppStrings.settingKey,
    ),
  ];

  final List<Widget> _screens = [
    HomeScreen(),
    ChatUserListScreen(),
    ProfileScreen(),
    SettingsScreen(), // You can change to SettingsScreen() later
  ];

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Obx(() {
      return Container(
        height: 85 + Get.mediaQuery.padding.bottom * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10,top: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.9),
              Theme.of(context).colorScheme.secondary.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            _bottomNavItems.length,
                (index) => BottomNavItemContainer(
              index: index,
              bottomNavItem: _bottomNavItems[index],
              onTap: controller.changeTab,
              selectedBottomNavIndex: controller.currentIndex.value,
            ),
          ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: _screens,
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }
}
