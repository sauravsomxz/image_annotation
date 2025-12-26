import 'package:flutter/material.dart';
import 'package:image_annotation/painters/shape_painter.dart';
import 'package:image_annotation/viewmodels/annotation_tools_vm.dart';
import 'package:provider/provider.dart';
import 'package:image_annotation/helpers/image_helpers.dart';

// Widget that overlays annotation drawing on top of the image.
// Handles gesture input and converts screen coordinates to image coordinates.
// Uses ShapePainter to render all shapes and the current shape being drawn.
class DrawingCanvas extends StatelessWidget {
  /// The rectangle in which the image is displayed (in screen coordinates)
  final Rect imageRect;

  /// The original size of the image (in pixels)
  final Size imageSize;

  /// [imageRect]: The rectangle where the image is rendered on screen
  /// [imageSize]: The original pixel size of the image
  const DrawingCanvas({
    super.key,
    required this.imageRect,
    required this.imageSize,
  });

  @override
  /// Builds the drawing canvas with gesture handling and annotation rendering.
  /// - If a tool is selected, gestures are enabled for drawing.
  /// - Otherwise, the canvas is non-interactive.
  @override
  Widget build(BuildContext context) {
    return Consumer<AnnotationToolsVM>(
      builder: (context, viewModel, child) {
        // Converts a screen offset to image coordinate space
        Offset toImageSpace(Offset local) =>
            mapScreenToImage(local, imageRect, imageSize);

        // The CustomPaint widget renders all completed and in-progress shapes
        final customPaint = CustomPaint(
          painter: ShapePainter(
            shapes: viewModel.shapes,
            currentShape: viewModel.currentShape,
            imageRect: imageRect,
            imageSize: imageSize,
          ),
          child: Container(),
        );
        // If a tool is selected, enable drawing gestures
        if (viewModel.selectedTool != null) {
          return GestureDetector(
            onPanStart: (details) =>
                viewModel.onDrawStart(toImageSpace(details.localPosition)),
            onPanUpdate: (details) =>
                viewModel.onDrawUpdate(toImageSpace(details.localPosition)),
            onPanEnd: (details) => viewModel.onDrawEnd(),
            child: customPaint,
          );
        }
        // Otherwise, block pointer events
        return IgnorePointer(child: customPaint);
      },
    );
  }
}
