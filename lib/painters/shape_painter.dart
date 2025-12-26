// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-24
// @desc [Custom painter for drawing shapes on canvas]

import 'package:flutter/material.dart';
import 'package:image_annotation/models/drawable_shape.dart';

class ShapePainter extends CustomPainter {
  final List<DrawableShape> shapes;
  final DrawableShape? currentShape;
  final Rect imageRect;
  final Size imageSize;

  ShapePainter({
    required this.shapes,
    this.currentShape,
    required this.imageRect,
    required this.imageSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint all completed shapes
    for (final shape in shapes) {
      _drawShape(canvas, shape);
    }

    // Paint the shape being drawn
    if (currentShape != null) {
      _drawShape(canvas, currentShape!);
    }
  }

  Offset _toDisplay(Offset imageOffset) {
    return Offset(
      imageRect.left + imageOffset.dx * imageRect.width / imageSize.width,
      imageRect.top + imageOffset.dy * imageRect.height / imageSize.height,
    );
  }

  void _drawShape(Canvas canvas, DrawableShape shape) {
    final paint = Paint()
      ..color = shape.color
      ..strokeWidth = shape.strokeWidth
      ..style = PaintingStyle.stroke;

    if (shape is CircleShape) {
      canvas.drawCircle(
        _toDisplay(shape.center),
        shape.radius * imageRect.width / imageSize.width,
        paint,
      );
    } else if (shape is RectangleShape) {
      canvas.drawRect(
        Rect.fromPoints(
          _toDisplay(shape.topLeft),
          _toDisplay(shape.bottomRight),
        ),
        paint,
      );
    } else if (shape is FreehandShape) {
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
