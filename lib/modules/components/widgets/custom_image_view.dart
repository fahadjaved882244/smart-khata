import 'package:flutter/material.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';

class CustomImageView extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit fit;
  final bool isDarkBg;
  final bool isVideo;

  const CustomImageView({
    Key? key,
    required this.imagePath,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    this.isDarkBg = false,
    this.isVideo = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer),
      child: Stack(
        alignment: Alignment.center,
        children: [
          FadeInImage.assetNetwork(
            height: height,
            width: width,
            fit: fit,
            fadeInDuration: const Duration(milliseconds: 100),
            placeholder: isDarkBg
                ? 'assets/general/darkPlaceholder.png'
                : 'assets/general/placeholder.png',
            image: imagePath,
            imageErrorBuilder: (context, exception, stackTrace) {
              return DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer),
                child: Image.asset(
                  'assets/general/error.png',
                  height: height,
                  width: width,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
          if (isVideo)
            Container(
              padding: const EdgeInsets.all(AppSizes.exSmallPadding + 2),
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(AppSizes.roundRadius),
              ),
              child: const Icon(Icons.play_arrow, color: AppColors.white),
            ),
        ],
      ),
    );
  }
}
