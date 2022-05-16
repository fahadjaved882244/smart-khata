import 'package:flutter/material.dart';
import 'package:khata/themes/app_sizes.dart';

import 'custom_image_view.dart';

class AvatarImageText extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final double? radius;
  final Widget? icon;
  final BoxBorder? border;
  const AvatarImageText({
    Key? key,
    required this.name,
    this.imageUrl,
    this.icon,
    this.radius,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double diameter =
        radius != null ? radius! * 2 : AppSizes.smallIconSize * 2;

    return SizedBox(
      height: diameter,
      width: diameter,
      child: CircleAvatar(
        radius: diameter / 2,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        child: ClipOval(
          child: imageUrl != null
              ? CustomImageView(
                  imagePath: imageUrl!,
                )
              : icon ??
                  Text(
                    name[0].toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: diameter / 2,
                        ),
                  ),
        ),
      ),
    );
  }
}
