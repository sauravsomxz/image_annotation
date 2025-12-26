// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-23
// @desc [ViewModel for managing annotation tools state and functionality]

import 'package:flutter/material.dart';
import 'package:image_annotation/core/app_enums.dart';
import 'package:image_annotation/models/drawable_shape.dart';

class AnnotationToolsVM extends ChangeNotifier {
  AnnotationToolType? _selectedTool;
  final List<DrawableShape> _shapes = [];
  DrawableShape? _currentShape;
  Color _drawingColor = Colors.red;
  final double _strokeWidth = 2.0;

  AnnotationToolType? get selectedTool => _selectedTool;
  List<DrawableShape> get shapes => _shapes;
  DrawableShape? get currentShape => _currentShape;
  Color get drawingColor => _drawingColor;
  double get strokeWidth => _strokeWidth;

  /// Get all available annotation tools
  List<AnnotationToolType> get availableTools => AnnotationToolType.values;

  /// Set the drawing color
  void setDrawingColor(Color color) {
    _drawingColor = color;
    notifyListeners();
  }

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

  /// Handle pan start for drawing
  void onDrawStart(Offset position) {
    if (_selectedTool == null) return;

    switch (_selectedTool!) {
      case AnnotationToolType.freehand:
        _currentShape = FreehandShape(
          points: [position],
          color: _drawingColor,
          strokeWidth: _strokeWidth,
        );
      case AnnotationToolType.rectangle:
        _currentShape = RectangleShape(
          topLeft: position,
          bottomRight: position,
          color: _drawingColor,
          strokeWidth: _strokeWidth,
        );
      case AnnotationToolType.circle:
        _currentShape = CircleShape(
          center: position,
          radius: 0,
          color: _drawingColor,
          strokeWidth: _strokeWidth,
        );
    }
    notifyListeners();
  }

  /// Handle pan update for drawing
  void onDrawUpdate(Offset position) {
    if (_currentShape == null) return;

    if (_currentShape is FreehandShape) {
      final shape = _currentShape as FreehandShape;
      shape.points.add(position);
    } else if (_currentShape is CircleShape) {
      final shape = _currentShape as CircleShape;
      _currentShape = CircleShape.fromDragPoints(
        shape.center,
        position,
        color: shape.color,
        strokeWidth: shape.strokeWidth,
      );
    } else if (_currentShape is RectangleShape) {
      final shape = _currentShape as RectangleShape;
      _currentShape = RectangleShape(
        topLeft: shape.topLeft,
        bottomRight: position,
        color: shape.color,
        strokeWidth: shape.strokeWidth,
      );
    }
    notifyListeners();
  }

  /// Handle pan end for drawing
  void onDrawEnd() {
    if (_currentShape == null) return;
    _shapes.add(_currentShape!);
    _currentShape = null;
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
    _shapes.clear();
    _currentShape = null;
    _drawingColor = Colors.red;
    notifyListeners();
  }

  /// Undo the last shape
  void undo() {
    if (_shapes.isNotEmpty) {
      _shapes.removeLast();
      notifyListeners();
    }
  }
}
