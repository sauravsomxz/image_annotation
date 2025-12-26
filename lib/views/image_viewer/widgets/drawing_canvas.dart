// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-24
// @desc [Widget for drawing canvas overlay on image]

import 'package:flutter/material.dart';
import 'package:image_annotation/painters/shape_painter.dart';
import 'package:image_annotation/viewmodels/annotation_tools_vm.dart';
import 'package:provider/provider.dart';

class DrawingCanvas extends StatelessWidget {
  const DrawingCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AnnotationToolsVM>(
      builder: (context, viewModel, child) {
        final customPaint = CustomPaint(
          painter: ShapePainter(
            shapes: viewModel.shapes,
            currentShape: viewModel.currentShape,
          ),
          child: Container(),
        );

        // Only consume gesture events when a tool is selected
        if (viewModel.selectedTool != null) {
          return GestureDetector(
            onPanStart: (details) =>
                viewModel.onDrawStart(details.localPosition),
            onPanUpdate: (details) =>
                viewModel.onDrawUpdate(details.localPosition),
            onPanEnd: (details) => viewModel.onDrawEnd(),
            child: customPaint,
          );
        }
        // When no tool is selected, ignore pointer events to allow InteractiveViewer to work
        return IgnorePointer(child: customPaint);
      },
    );
  }
}
