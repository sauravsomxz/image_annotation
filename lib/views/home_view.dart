// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 15:24:40 2025-12-22
// @modify date 15:24:40 2025-12-22
// @desc [File holds the UI for Home View; For now it shows a grid of images]

import 'package:flutter/material.dart';
import 'package:image_annotation/core/app_image_paths.dart';
import 'package:image_annotation/core/app_strings.dart';
import 'package:image_annotation/views/image_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.imageAnnotation),
        centerTitle: false,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: AppImagePaths.listOfImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (context) => ImageView()),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                AppImagePaths.listOfImages[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
