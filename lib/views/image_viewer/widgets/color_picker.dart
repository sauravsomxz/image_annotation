// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-24
// @desc [Widget for color picker in annotation toolbar]

import 'package:flutter/material.dart';
import 'package:image_annotation/viewmodels/annotation_tools_vm.dart';
import 'package:provider/provider.dart';

class ColorPicker extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.black,
  ];

  ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AnnotationToolsVM>(
      builder: (context, viewModel, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Color',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ...colors.map(
                  (color) => GestureDetector(
                    onTap: () => viewModel.setDrawingColor(color),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6.0),
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: viewModel.drawingColor == color
                              ? Colors.black
                              : Colors.grey.shade400,
                          width: viewModel.drawingColor == color ? 3.0 : 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
