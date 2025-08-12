import 'package:flutter/material.dart';

class BottomNavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String title;

  BottomNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.title,
  });
}