import 'package:flutter/material.dart';
import 'package:flutter_getx_project/models/home_list_res_model.dart';
import 'package:flutter_getx_project/screens/home/widget/tag_chip.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';

class ResourceCard extends StatelessWidget {
  final Data resData;
  final int Function(String) hexToInt;

  const ResourceCard({
    super.key,
    required this.resData,
    required this.hexToInt,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = Color(hexToInt(resData.color!));
    final secondaryColor = Theme.of(context).colorScheme.secondary.withOpacity(0.7);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            bgColor.withOpacity(0.15),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: CustomTextWidget(
                    text: resData.name?.toUpperCase() ?? '',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: bgColor,
                  radius: 16,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Tags
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                TagChip(text: "Year: ${resData.year}", color: secondaryColor),
                TagChip(text: "Pantone: ${resData.pantoneValue}", color: secondaryColor),
                TagChip(text: "Code: ${resData.color}", color: bgColor, bold: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
