// Helper functions for creating and manipulating annotation shapes.

import 'package:flutter/material.dart';
import 'package:image_annotation/models/drawable_shape.dart';

/// Creates a CircleShape from a drag gesture.
/// [start]: The drag start point (center of the circle, in image coordinates)
/// [current]: The current drag point (determines radius)
/// [color]: The color of the circle
/// [strokeWidth]: The stroke width of the circle
CircleShape createCircleFromDrag(
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

/// Creates a RectangleShape from a drag gesture.
/// [start]: The drag start point (top-left corner, in image coordinates)
/// [current]: The current drag point (bottom-right corner)
/// [color]: The color of the rectangle
/// [strokeWidth]: The stroke width of the rectangle
RectangleShape createRectangleFromDrag(
  Offset start,
  Offset current, {
  Color color = Colors.blue,
  double strokeWidth = 2.0,
}) {
  return RectangleShape(
    topLeft: start,
    bottomRight: current,
    color: color,
    strokeWidth: strokeWidth,
  );
}

/// Creates a FreehandShape from a list of points.
/// [points]: The list of points in image coordinates
/// [color]: The color of the freehand path
/// [strokeWidth]: The stroke width of the path
FreehandShape createFreehand(
  List<Offset> points, {
  Color color = Colors.blue,
  double strokeWidth = 2.0,
}) {
  return FreehandShape(points: points, color: color, strokeWidth: strokeWidth);
}

/// Creates an EraserShape from a list of points.
/// [points]: The list of points in image coordinates
/// [strokeWidth]: The width of the eraser
EraserShape createEraser(List<Offset> points, {double strokeWidth = 15.0}) {
  return EraserShape(points: points, strokeWidth: strokeWidth);
}
