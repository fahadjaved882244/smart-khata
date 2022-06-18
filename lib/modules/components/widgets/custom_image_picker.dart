import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:khata/themes/app_sizes.dart';

import 'custom_file_image_view.dart';

class CustomImagePicker extends StatelessWidget {
  final Uint8List? imageData;
  final bool isLoading;
  final Future<void> Function(BuildContext) onPicked;
  final VoidCallback onRemoved;
  final double height;
  const CustomImagePicker({
    Key? key,
    required this.imageData,
    required this.isLoading,
    required this.onPicked,
    required this.onRemoved,
    this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Card(
          child: CustomFileImageView(
            imageData: imageData,
            isLoading: isLoading,
            height: height,
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
                  onPressed: () async => await onPicked(context),
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
    );
  }
}
