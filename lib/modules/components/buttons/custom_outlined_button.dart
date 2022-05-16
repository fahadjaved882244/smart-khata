import 'package:flutter/material.dart';
import 'package:khata/themes/app_sizes.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Icon? icon;
  final String? tooltip;
  final double spacing;
  final double heightScale;
  final double width;

  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.tooltip,
    this.heightScale = 1,
    this.width = double.maxFinite,
    this.spacing = AppSizes.exSmallPadding,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heightScale == 0 ? double.maxFinite : AppSizes.tabHeight,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          )),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
