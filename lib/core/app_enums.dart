// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-23
// @desc [File holds all enums used in-app]

import 'package:flutter/material.dart';

/// Enum representing different annotation tool types
enum AnnotationToolType {
  freehand,
  rectangle,
  circle;

  /// Get display name for the tool
  String get displayName {
    switch (this) {
      case AnnotationToolType.freehand:
        return 'Freehand';
      case AnnotationToolType.rectangle:
        return 'Rectangle';
      case AnnotationToolType.circle:
        return 'Circle';
    }
  }

  /// Get icon data for the tool
  IconData get icon {
    switch (this) {
      case AnnotationToolType.freehand:
        return Icons.edit;
      case AnnotationToolType.rectangle:
        return Icons.rectangle_outlined;
      case AnnotationToolType.circle:
        return Icons.circle_outlined;
    }
  }
}
