// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-24
// @desc [Model for annotation drawing data]

import 'package:flutter/material.dart';

/// Base class for drawn shapes
abstract class DrawableShape {
  final Color color;
  final double strokeWidth;

  DrawableShape({required this.color, required this.strokeWidth});
}

/// Circle shape for drawing
class CircleShape extends DrawableShape {
  final Offset center;
  final double radius;

  CircleShape({
    required this.center,
    required this.radius,
    required super.color,
    required super.strokeWidth,
  });

  /// Create a circle from start and current points (drag positions)
  factory CircleShape.fromDragPoints(
    Offset start,
    Offset current, {
    Color color = Colors.blue,
    double strokeWidth = 2.0,
  }) {
    final center = start;
    final radius = (current - start).distance;
    return CircleShape(
      center: center,
      radius: radius,
      color: color,
      strokeWidth: strokeWidth,
    );
  }
}

/// Rectangle shape for drawing
class RectangleShape extends DrawableShape {
  final Offset topLeft;
  final Offset bottomRight;

  RectangleShape({
    required this.topLeft,
    required this.bottomRight,
    required super.color,
    required super.strokeWidth,
  });
}

/// Freehand path for drawing
class FreehandShape extends DrawableShape {
  final List<Offset> points;

  FreehandShape({
    required this.points,
    required super.color,
    required super.strokeWidth,
  });
}

/// Eraser path for erasing
class EraserShape extends DrawableShape {
  final List<Offset> points;

  EraserShape({required this.points, super.strokeWidth = 15.0})
    : super(color: Colors.transparent);
}
