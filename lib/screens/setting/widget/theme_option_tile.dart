import 'package:flutter/material.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';

class ThemeOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final ThemeMode themeMode;
  final ThemeMode selectedTheme;
  final VoidCallback onTap;

  const ThemeOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.themeMode,
    required this.selectedTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedTheme == themeMode;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? Colors.white.withOpacity(0.1) : Colors.white10,
          border: Border.all(
            color: isSelected ? Colors.white70 : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 3),
            )
          ]
              : [],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextWidget(
                text: title,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }
}
