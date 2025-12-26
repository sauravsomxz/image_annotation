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
import 'package:provider/provider.dart';

class ImageView extends StatelessWidget {
  final String imagePath;

  const ImageView({super.key, required this.imagePath});

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
          body: Stack(
            children: [
              Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Hero(
                      tag: imagePath,
                      child: InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(0),
                        minScale: 1.0,
                        maxScale: 5.0,
                        child: Image.asset(imagePath, fit: BoxFit.contain),
                      ),
                    ),
                    const DrawingCanvas(),
                  ],
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
          ),
        ),
      ),
    );
  }
}
