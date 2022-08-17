import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';

class CustomMemImageView extends StatelessWidget {
  final Uint8List? imageData;
  final double width;
  final double height;
  final BoxFit fit;
  final bool isDarkBg;
  final bool isVideo;
  final bool isLoading;
  final Color? backgroundColor;

  const CustomMemImageView({
    Key? key,
    required this.imageData,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    this.isDarkBg = false,
    this.isVideo = false,
    this.isLoading = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor ??
              Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: !isLoading
            ? Stack(
                alignment: Alignment.center,
                children: [
                  if (imageData != null)
                    Image.memory(
                      imageData!,
                      height: height,
                      width: width,
                      fit: fit,
                      errorBuilder: (context, exc, st) =>
                          _errorBuilder(context),
                    )
                  else
                    Image.asset(
                      isDarkBg
                          ? 'assets/general/darkPlaceholder.png'
                          : 'assets/general/placeholder.png',
                      width: width,
                      height: height,
                      fit: fit,
                    ),
                  if (isVideo)
                    Container(
                      padding:
                          const EdgeInsets.all(AppSizes.exSmallPadding + 2),
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.6),
                        borderRadius:
                            BorderRadius.circular(AppSizes.roundRadius),
                      ),
                      child:
                          const Icon(Icons.play_arrow, color: AppColors.white),
                    ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
      ),
    );
  }

  DecoratedBox _errorBuilder(BuildContext context) {
    return DecoratedBox(
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.errorContainer),
      child: Image.asset(
        'assets/general/error.png',
        height: height,
        width: width,
        color: Theme.of(context).colorScheme.onErrorContainer,
        fit: BoxFit.contain,
      ),
    );
  }
}
