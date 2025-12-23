// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-23
// @desc [ViewModel for managing annotation tools state and functionality]

import 'package:flutter/material.dart';
import 'package:image_annotation/core/app_enums.dart';

class AnnotationToolsVM extends ChangeNotifier {
  AnnotationToolType? _selectedTool;

  AnnotationToolType? get selectedTool => _selectedTool;

  /// Get all available annotation tools
  List<AnnotationToolType> get availableTools => AnnotationToolType.values;

  /// Select an annotation tool
  /// If the same tool is selected again, it will be deselected
  void selectTool(AnnotationToolType tool) {
    if (_selectedTool == tool) {
      _selectedTool = null;
    } else {
      _selectedTool = tool;
    }
    notifyListeners();
  }

  /// Clear the selected tool
  void clearSelection() {
    _selectedTool = null;
    notifyListeners();
  }

  /// Check if a tool is currently selected
  bool isToolSelected(AnnotationToolType tool) {
    return _selectedTool == tool;
  }

  /// Reset to initial state
  void reset() {
    _selectedTool = null;
    notifyListeners();
  }
}
