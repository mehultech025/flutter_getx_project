import 'package:flutter/material.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';
import '../models/bottomNavItem.dart';

class BottomNavItemContainer extends StatelessWidget {
  final int selectedBottomNavIndex;
  final int index;
  final Function(int) onTap;
  final BottomNavItem bottomNavItem;

  const BottomNavItemContainer({
    super.key,
    required this.index,
    required this.bottomNavItem,
    required this.onTap,
    required this.selectedBottomNavIndex,
  });

  bool get isSelected => index == selectedBottomNavIndex;

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.primary;
    final unselectedColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.6);

    return GestureDetector(
      onTap: () => onTap.call(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 2.5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: isSelected
                    ? Theme.of(context).colorScheme.surface
                    : null,
              ),
              child: SizedBox(
                height: 30,
                width: 30,
                child: Icon(
                  isSelected ? bottomNavItem.selectedIcon : bottomNavItem.icon,
                  color: isSelected ? selectedColor : unselectedColor,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 5),
            CustomTextWidget(
              text:bottomNavItem.title,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? selectedColor
                    : unselectedColor,
            ),
          ],
        ),
      ),
    );
  }
}
