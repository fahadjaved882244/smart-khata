import 'package:flutter/material.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/extensions/date_time_extensions.dart';

class CustomDateChip extends StatelessWidget {
  final DateTime date;
  const CustomDateChip({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppSizes.smallPadding,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.exSmallPadding,
        horizontal: AppSizes.smallPadding,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        date.formattedDate!,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).colorScheme.onTertiaryContainer),
        textAlign: TextAlign.center,
      ),
    );
  }
}
