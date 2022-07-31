import 'package:flutter/material.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';

class EmptyView extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Widget? button;
  final bool isLoading;
  const EmptyView({
    Key? key,
    this.title = "Nothing found",
    this.iconData = Icons.error_outline,
    this.button,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const CircularProgressIndicator.adaptive()
            else ...[
              Icon(
                iconData,
                size: 150,
                color: AppColors.errorRed,
              ),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSizes.mediumPadding),
              if (button != null) button!,
            ],
          ],
        ),
      ),
    );
  }
}
