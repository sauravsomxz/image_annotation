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

class ImageView extends StatelessWidget {
  final String imagePath;

  const ImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.imageViewTitle),
        centerTitle: false,
      ),
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Hero(
          tag: imagePath,
          child: InteractiveViewer(
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
