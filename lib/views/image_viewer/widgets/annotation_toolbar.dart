// @author [Sourav Ranjan Maharana]
// @email [saurav.maharana07@gmail.com]
// @create date 2025-12-23
// @desc [Widget for annotation tools toolbar]

import 'package:flutter/material.dart';
import 'package:image_annotation/viewmodels/annotation_tools_vm.dart';
import 'package:image_annotation/views/image_viewer/widgets/annotation_tool_button.dart';
import 'package:provider/provider.dart';

class AnnotationToolbar extends StatelessWidget {
  const AnnotationToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AnnotationToolsVM>(
      builder: (context, viewModel, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...viewModel.availableTools.map(
                (tool) => AnnotationToolButton(
                  tool: tool,
                  isSelected: viewModel.isToolSelected(tool),
                  onPressed: () => viewModel.selectTool(tool),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
