// Helper functions for coordinate conversion and image rect calculation.

import 'package:flutter/material.dart';

/// Converts a screen offset (e.g., from a gesture) to image coordinate space.
/// [local]: The point in screen coordinates (e.g., from GestureDetector)
/// [imageRect]: The rectangle where the image is displayed on screen
/// [imageSize]: The original size of the image (in pixels)
/// Returns: The corresponding point in image coordinates
Offset mapScreenToImage(Offset local, Rect imageRect, Size imageSize) {
  if (!imageRect.contains(local)) return Offset.zero;
  return Offset(
    (local.dx - imageRect.left) * imageSize.width / imageRect.width,
    (local.dy - imageRect.top) * imageSize.height / imageRect.height,
  );
}

/// Converts a point from image coordinates to display (screen) coordinates.
/// [imageOffset]: The point in image coordinates
/// [imageRect]: The rectangle where the image is displayed on screen
/// [imageSize]: The original size of the image (in pixels)
/// Returns: The corresponding point in screen coordinates
Offset mapImageToDisplay(Offset imageOffset, Rect imageRect, Size imageSize) {
  return Offset(
    imageRect.left + imageOffset.dx * imageRect.width / imageSize.width,
    imageRect.top + imageOffset.dy * imageRect.height / imageSize.height,
  );
}

/// Calculates the rectangle where the image will be displayed inside a parent container,
/// using BoxFit.contain logic.
/// [imageSize]: The original size of the image (in pixels)
/// [parentSize]: The size of the parent widget/container
/// Returns: The rectangle (in screen coordinates) where the image is rendered
Rect calculateImageRect(Size imageSize, Size parentSize) {
  return Alignment.center.inscribe(
    Size(
      imageSize.width * (parentSize.width / imageSize.width).clamp(0.0, 1.0),
      imageSize.height * (parentSize.height / imageSize.height).clamp(0.0, 1.0),
    ),
    Offset.zero & parentSize,
  );
}
