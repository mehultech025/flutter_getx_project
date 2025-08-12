import 'package:flutter/material.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';

class TagChip extends StatelessWidget {
  final String text;
  final Color color;
  final bool bold;

  const TagChip({
    super.key,
    required this.text,
    required this.color,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
      ),
      child: CustomTextWidget(
        text: text,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontSize: 13,
      ),
    );
  }
}
