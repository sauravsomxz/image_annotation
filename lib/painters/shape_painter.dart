// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-24
// @desc [Custom painter for drawing shapes on canvas]

import 'package:flutter/material.dart';
import 'package:image_annotation/models/drawable_shape.dart';

class ShapePainter extends CustomPainter {
  final List<DrawableShape> shapes;
  final DrawableShape? currentShape;

  ShapePainter({required this.shapes, this.currentShape});

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

  void _drawShape(Canvas canvas, DrawableShape shape) {
    final paint = Paint()
      ..color = shape.color
      ..strokeWidth = shape.strokeWidth
      ..style = PaintingStyle.stroke;

    if (shape is CircleShape) {
      canvas.drawCircle(shape.center, shape.radius, paint);
    } else if (shape is RectangleShape) {
      canvas.drawRect(Rect.fromPoints(shape.topLeft, shape.bottomRight), paint);
    } else if (shape is FreehandShape) {
      if (shape.points.isNotEmpty) {
        for (int i = 0; i < shape.points.length - 1; i++) {
          canvas.drawLine(shape.points[i], shape.points[i + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(ShapePainter oldDelegate) {
    return oldDelegate.shapes != shapes ||
        oldDelegate.currentShape != currentShape;
  }
}
