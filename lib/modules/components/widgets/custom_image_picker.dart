import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:khata/themes/app_sizes.dart';

import 'custom_mem_image_view.dart';

class CustomImagePicker extends StatelessWidget {
  final Uint8List? imageData;
  final bool isLoading;
  final Future<int> Function(BuildContext) onPicked;
  final VoidCallback onRemoved;
  final double height;
  final double width;
  const CustomImagePicker({
    Key? key,
    required this.imageData,
    required this.isLoading,
    required this.onPicked,
    required this.onRemoved,
    this.height = 150,
    this.width = double.maxFinite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Card(
            child: CustomMemImageView(
              imageData: imageData,
              isLoading: isLoading,
              height: height,
              width: width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.exSmallPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (imageData != null) ...[
                  Card(
                    elevation: 5,
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: IconButton(
                      onPressed: () => onRemoved(),
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.exSmallPadding),
                ],
                Card(
                  elevation: 5,
                  color: Theme.of(context).colorScheme.background,
                  child: IconButton(
                    onPressed: () async {
                      final ctx = context;
                      final result = await onPicked(context);
                      // ignore: use_build_context_synchronously
                      if (result != -1) AppLock.of(ctx)?.didUnlock();
                    },
                    icon: Icon(
                      Icons.photo_camera_back_outlined,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
