import 'package:flutter/material.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? color;

  const SettingsTile({super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.white),
      title: CustomTextWidget(
        text: title,
        color: color ?? Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.white.withOpacity(0.1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}