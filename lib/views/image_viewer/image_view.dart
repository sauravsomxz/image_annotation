// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 15:19:56 2025-12-22
// @modify date 15:19:56 2025-12-22
// @desc [
//      File Holds the UI for Showing Image in FullScreen View
//      The option to edit or annot will be present here
//       ]

import 'package:flutter/material.dart';
import 'package:image_annotation/core/app_strings.dart';
import 'package:image_annotation/viewmodels/annotation_tools_vm.dart';
import 'package:image_annotation/views/image_viewer/widgets/annotation_toolbar.dart';
import 'package:image_annotation/views/image_viewer/widgets/color_picker.dart';
import 'package:image_annotation/views/image_viewer/widgets/drawing_canvas.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class ImageView extends StatelessWidget {
  final String imagePath;

  const ImageView({super.key, required this.imagePath});

  Future<Size> _getImageSize(BuildContext context) async {
    final completer = Completer<Size>();
    final img = AssetImage(imagePath);
    final stream = img.resolve(createLocalImageConfiguration(context));
    stream.addListener(
      ImageStreamListener((info, _) {
        completer.complete(
          Size(info.image.width.toDouble(), info.image.height.toDouble()),
        );
      }),
    );
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AnnotationToolsVM(),
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.imageViewTitle),
            centerTitle: false,
          ),
          body: FutureBuilder<Size>(
            future: _getImageSize(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final imageSize = snapshot.data!;
              return Stack(
                children: [
                  Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(0),
                      minScale: 1.0,
                      maxScale: 5.0,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final parentSize = Size(
                            constraints.maxWidth,
                            constraints.maxHeight,
                          );
                          final fitted = applyBoxFit(
                            BoxFit.contain,
                            imageSize,
                            parentSize,
                          );
                          final imageRect = Alignment.center.inscribe(
                            fitted.destination,
                            Offset.zero & parentSize,
                          );
                          return Stack(
                            children: [
                              Positioned.fromRect(
                                rect: imageRect,
                                child: Image.asset(imagePath, fit: BoxFit.fill),
                              ),
                              Positioned.fromRect(
                                rect: imageRect,
                                child: DrawingCanvas(
                                  imageRect: Rect.fromLTWH(
                                    0,
                                    0,
                                    imageSize.width,
                                    imageSize.height,
                                  ),
                                  imageSize: imageSize,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: const AnnotationToolbar(),
                  ),
                  Positioned(top: 0, right: 0, child: ColorPicker()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
