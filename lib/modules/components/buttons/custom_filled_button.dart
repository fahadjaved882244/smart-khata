import 'package:flutter/material.dart';
import 'package:khata/themes/app_sizes.dart';

class CustomFilledButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Widget? icon;
  final double elevation;
  final bool isTonal;
  final bool isDanger;
  final double heightScale;
  final double width;
  final double borderRadius;

  const CustomFilledButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.icon,
    this.elevation = 0,
    this.isTonal = false,
    this.isDanger = false,
    this.heightScale = 1,
    this.width = double.maxFinite,
    this.borderRadius = AppSizes.buttonRadius,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heightScale != 0
          ? AppSizes.tabHeight * heightScale
          : double.maxFinite,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )),
          backgroundColor: MaterialStateProperty.all(
            elevation > 0
                ? Theme.of(context).colorScheme.surface
                : isTonal
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : isDanger
                        ? Theme.of(context).colorScheme.errorContainer
                        : Theme.of(context).colorScheme.primary,
          ),
          foregroundColor: MaterialStateProperty.all(
            elevation > 0
                ? Theme.of(context).colorScheme.onSurface
                : isTonal
                    ? Theme.of(context).colorScheme.secondary
                    : isDanger
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 4),
            ],
            if (text != null) Text(text!),
          ],
        ),
      ),
    );
  }
}
