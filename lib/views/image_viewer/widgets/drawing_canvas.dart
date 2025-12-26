import 'package:flutter/material.dart';
import 'package:image_annotation/painters/shape_painter.dart';
import 'package:image_annotation/viewmodels/annotation_tools_vm.dart';
import 'package:provider/provider.dart';

// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
class DrawingCanvas extends StatelessWidget {
  final Rect imageRect;
  final Size imageSize;

  const DrawingCanvas({
    super.key,
    required this.imageRect,
    required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AnnotationToolsVM>(
      builder: (context, viewModel, child) {
        Offset toImageSpace(Offset local) {
          if (!imageRect.contains(local)) return Offset.zero;
          return Offset(
            (local.dx - imageRect.left) * imageSize.width / imageRect.width,
            (local.dy - imageRect.top) * imageSize.height / imageRect.height,
          );
        }

        final customPaint = CustomPaint(
          painter: ShapePainter(
            shapes: viewModel.shapes,
            currentShape: viewModel.currentShape,
            imageRect: imageRect,
            imageSize: imageSize,
          ),
          child: Container(),
        );
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
        return IgnorePointer(child: customPaint);
      },
    );
  }
}
