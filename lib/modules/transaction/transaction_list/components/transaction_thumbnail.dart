import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';
import 'package:khata/extensions/date_time_extensions.dart';

class TransactionThumbnail extends StatelessWidget {
  final TransactionModel transaction;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  const TransactionThumbnail({
    Key? key,
    required this.transaction,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final largeStyle = transaction.amount.isNegative
        ? Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.red)
        : Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppColors.green);
    final smallStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: AppColors.darkGray);

    return Padding(
      padding: transaction.amount.isNegative
          ? EdgeInsets.only(left: Get.width * 0.35)
          : EdgeInsets.only(right: Get.width * 0.35),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          side: const BorderSide(width: 0.5),
        ),
        color: isSelected
            ? Theme.of(context).colorScheme.tertiaryContainer
            : AppColors.white,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.smallPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rs. ${transaction.amount.abs().round().toString()}",
                  style: largeStyle,
                ),
                if (transaction.note != null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(transaction.note!, style: smallStyle),
                  ),
                ],
                const Divider(height: AppSizes.smallPadding),
                Text(
                  transaction.dateTime.formattedTime!,
                  style: smallStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
