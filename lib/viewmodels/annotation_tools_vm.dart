// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-23
// @desc [ViewModel for managing annotation tools state and functionality]

import 'package:flutter/material.dart';
import 'package:image_annotation/core/app_enums.dart';
import 'package:image_annotation/models/drawable_shape.dart';
import 'package:image_annotation/helpers/shape_helpers.dart';

/// ViewModel for managing annotation tool state and drawing logic.
/// Handles tool selection, color, and shape creation for annotation.
class AnnotationToolsVM extends ChangeNotifier {
  /// Currently selected annotation tool (null if none selected)
  AnnotationToolType? _selectedTool;

  /// List of all completed annotation shapes
  final List<DrawableShape> _shapes = [];

  /// The shape currently being drawn (in-progress)
  DrawableShape? _currentShape;

  /// The color used for drawing new shapes
  Color _drawingColor = Colors.red;

  /// The stroke width for all shapes
  final double _strokeWidth = 2.0;

  /// Returns the currently selected tool
  AnnotationToolType? get selectedTool => _selectedTool;

  /// Returns the list of completed shapes
  List<DrawableShape> get shapes => _shapes;

  /// Returns the current in-progress shape
  DrawableShape? get currentShape => _currentShape;

  /// Returns the current drawing color
  Color get drawingColor => _drawingColor;

  /// Returns the stroke width for shapes
  double get strokeWidth => _strokeWidth;

  /// Returns all available annotation tools
  List<AnnotationToolType> get availableTools => AnnotationToolType.values;

  /// Sets the drawing color for new shapes
  void setDrawingColor(Color color) {
    _drawingColor = color;
    notifyListeners();
  }

  /// Selects an annotation tool. Deselects if the same tool is tapped again.
  void selectTool(AnnotationToolType tool) {
    if (_selectedTool == tool) {
      _selectedTool = null;
    } else {
      _selectedTool = tool;
    }
    notifyListeners();
  }

  /// Called when drawing starts (e.g., onPanStart). Creates a new shape.
  /// [position]: The starting point in image coordinates
  void onDrawStart(Offset position) {
    if (_selectedTool == null) return;
    switch (_selectedTool!) {
      case AnnotationToolType.freehand:
        _currentShape = createFreehand(
          [position],
          color: _drawingColor,
          strokeWidth: _strokeWidth,
        );
        break;
      case AnnotationToolType.rectangle:
        _currentShape = createRectangleFromDrag(
          position,
          position,
          color: _drawingColor,
          strokeWidth: _strokeWidth,
        );
        break;
      case AnnotationToolType.circle:
        _currentShape = createCircleFromDrag(
          position,
          position,
          color: _drawingColor,
          strokeWidth: _strokeWidth,
        );
        break;
    }
    notifyListeners();
  }

  /// Called when drawing is updated (e.g., onPanUpdate). Updates the in-progress shape.
  /// [position]: The current drag point in image coordinates
  void onDrawUpdate(Offset position) {
    if (_selectedTool == null || _currentShape == null) return;
    switch (_selectedTool!) {
      case AnnotationToolType.freehand:
        final shape = _currentShape as FreehandShape;
        shape.points.add(position);
        break;
      case AnnotationToolType.rectangle:
        final shape = _currentShape as RectangleShape;
        _currentShape = createRectangleFromDrag(
          shape.topLeft,
          position,
          color: shape.color,
          strokeWidth: shape.strokeWidth,
        );
        break;
      case AnnotationToolType.circle:
        final shape = _currentShape as CircleShape;
        _currentShape = createCircleFromDrag(
          shape.center,
          position,
          color: shape.color,
          strokeWidth: shape.strokeWidth,
        );
        break;
    }
    notifyListeners();
  }

  /// Called when drawing ends (e.g., onPanEnd). Finalizes the shape.
  void onDrawEnd() {
    if (_currentShape != null) {
      _shapes.add(_currentShape!);
      _currentShape = null;
      notifyListeners();
    }
  }

  /// Clears the selected tool (sets to null)
  void clearSelection() {
    _selectedTool = null;
    notifyListeners();
  }

  /// Returns true if the given tool is currently selected
  bool isToolSelected(AnnotationToolType tool) {
    return _selectedTool == tool;
  }

  /// Resets the ViewModel to its initial state (clears all shapes and resets color/tool)
  void reset() {
    _selectedTool = null;
    _shapes.clear();
    _currentShape = null;
    _drawingColor = Colors.red;
    notifyListeners();
  }

  /// Removes the last drawn shape (undo)
  void undo() {
    if (_shapes.isNotEmpty) {
      _shapes.removeLast();
      notifyListeners();
    }
  }
}
