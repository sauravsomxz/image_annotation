// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 15:19:56 2025-12-22
// @modify date 15:19:56 2025-12-22
// @desc [
//      File Holds the UI for Showing Image in FullScreen View
//      The option to edit or annot will be present here
//       ]

import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image View'), centerTitle: false),
      body: const Center(
        child: Text('Full Screen Image View with Annotation Options'),
      ),
    );
  }
}
