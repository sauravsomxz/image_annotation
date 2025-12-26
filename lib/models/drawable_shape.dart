// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-24
// @desc [Model for annotation drawing data]

import 'package:flutter/material.dart';

/// Base class for all annotation shapes.
/// Stores color and stroke width for rendering.
abstract class DrawableShape {
  final Color color;
  final double strokeWidth;

  DrawableShape({required this.color, required this.strokeWidth});
}

/// Represents a circle annotation.
/// [center]: Center of the circle (in image coordinates)
/// [radius]: Radius of the circle (in image coordinates)
class CircleShape extends DrawableShape {
  final Offset center;
  final double radius;

  CircleShape({
    required this.center,
    required this.radius,
    required super.color,
    required super.strokeWidth,
  });
}

/// Represents a rectangle annotation.
/// [topLeft]: Top-left corner (in image coordinates)
/// [bottomRight]: Bottom-right corner (in image coordinates)
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

/// Represents a freehand annotation path.
/// [points]: List of points (in image coordinates)
class FreehandShape extends DrawableShape {
  final List<Offset> points;

  FreehandShape({
    required this.points,
    required super.color,
    required super.strokeWidth,
  });
}

/// Represents an eraser path (for erasing drawn shapes).
/// [points]: List of points (in image coordinates)
class EraserShape extends DrawableShape {
  final List<Offset> points;

  EraserShape({required this.points, super.strokeWidth = 15.0})
    : super(color: Colors.transparent);
}
