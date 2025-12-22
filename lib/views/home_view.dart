import 'package:flutter/material.dart';
import 'package:image_annotation/core/app_image_paths.dart';
import 'package:image_annotation/core/app_strings.dart';

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
            onTap: () {
              // Navigate to annotation screen later
            },
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
