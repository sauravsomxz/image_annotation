// Custom painter for rendering annotation shapes on the canvas.
// Handles mapping from image coordinates to display coordinates.

import 'package:flutter/material.dart';
import 'package:image_annotation/models/drawable_shape.dart';
import 'package:image_annotation/helpers/image_helpers.dart';

/// Paints all annotation shapes and the current in-progress shape.
/// Uses imageRect and imageSize to map annotation points to the correct display position.
class ShapePainter extends CustomPainter {
  /// List of completed shapes to render
  final List<DrawableShape> shapes;

  /// The shape currently being drawn (if any)
  final DrawableShape? currentShape;

  /// The rectangle where the image is displayed on screen
  final Rect imageRect;

  /// The original size of the image (in pixels)
  final Size imageSize;

  ShapePainter({
    required this.shapes,
    this.currentShape,
    required this.imageRect,
    required this.imageSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw all completed annotation shapes
    for (final shape in shapes) {
      _drawShape(canvas, shape);
    }
    // Draw the shape currently being drawn (if any)
    if (currentShape != null) {
      _drawShape(canvas, currentShape!);
    }
  }

  /// Maps a point from image coordinates to display coordinates
  Offset _toDisplay(Offset imageOffset) =>
      mapImageToDisplay(imageOffset, imageRect, imageSize);

  /// Draws a single shape (circle, rectangle, or freehand path)
  void _drawShape(Canvas canvas, DrawableShape shape) {
    final paint = Paint()
      ..color = shape.color
      ..strokeWidth = shape.strokeWidth
      ..style = PaintingStyle.stroke;

    if (shape is CircleShape) {
      // Draw a circle using mapped center and scaled radius
      canvas.drawCircle(
        _toDisplay(shape.center),
        shape.radius * imageRect.width / imageSize.width,
        paint,
      );
    } else if (shape is RectangleShape) {
      // Draw a rectangle using mapped corners
      canvas.drawRect(
        Rect.fromPoints(
          _toDisplay(shape.topLeft),
          _toDisplay(shape.bottomRight),
        ),
        paint,
      );
    } else if (shape is FreehandShape) {
      // Draw a freehand path by connecting all mapped points
      if (shape.points.isNotEmpty) {
        for (int i = 0; i < shape.points.length - 1; i++) {
          canvas.drawLine(
            _toDisplay(shape.points[i]),
            _toDisplay(shape.points[i + 1]),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(ShapePainter oldDelegate) {
    return oldDelegate.shapes != shapes ||
        oldDelegate.currentShape != currentShape ||
        oldDelegate.imageRect != imageRect ||
        oldDelegate.imageSize != imageSize;
  }
}
