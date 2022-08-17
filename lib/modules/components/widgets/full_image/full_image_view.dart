import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/custom_mem_image_view.dart';
import 'full_image_controller.dart';

class FullImageView extends StatelessWidget {
  final String? photoUrl = Get.parameters['photoUrl'];
  FullImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FullImageController(photoUrl));
    return BaseScaffold(
      title: "",
      noPadding: true,
      child: Obx(() {
        if (!controller.isLoading) {
          return InteractiveViewer(
            minScale: 1,
            maxScale: 5,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 500),
                child: CustomMemImageView(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  imageData: controller.imageData,
                  isLoading: controller.isLoading,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
