// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-23
// @desc [Widget for individual annotation tool button]

import 'package:flutter/material.dart';
import 'package:image_annotation/core/app_enums.dart';

class AnnotationToolButton extends StatelessWidget {
  final AnnotationToolType tool;
  final bool isSelected;
  final VoidCallback onPressed;

  const AnnotationToolButton({
    super.key,
    required this.tool,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tool.displayName,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade400,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
          color: isSelected ? Colors.blue.shade50 : Colors.white,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(8.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                tool.icon,
                color: isSelected ? Colors.blue : Colors.grey.shade700,
                size: 24.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
