import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final double? height, width;
  const BasicAppButton({required this.onTap, this.title = '', this.height, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.theme.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: context.text.bodyMedium?.copyWith(),
        ),
      ),
    );
  }
}
