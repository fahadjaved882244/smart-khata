import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/modules/components/widgets/custom_mem_image_view.dart';
import 'package:khata/modules/customer/customer_detail/customer_detail_controller.dart';
import 'package:khata/modules/transaction/transaction_list/components/transaction_thumbnail_controller.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';
import 'package:khata/extensions/date_time_extensions.dart';

class TransactionThumbnail extends GetView<CustomerDetailController> {
  final TransactionModel transaction;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final TransactionThumbnailController tbController;
  TransactionThumbnail({
    Key? key,
    required this.transaction,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  })  : tbController = Get.put(
          TransactionThumbnailController(transaction),
          tag: transaction.id,
        ),
        super(key: key);

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
                if (transaction.photoUrl != null)
                  Card(
                    margin:
                        const EdgeInsets.only(bottom: AppSizes.smallPadding),
                    child: Obx(() {
                      return InkWell(
                        onTap: !controller.isSelectable
                            ? () => Get.toNamed(
                                  RouteNames.fullImageView,
                                  parameters: transaction.photoUrl != null
                                      ? {'photoUrl': transaction.photoUrl!}
                                      : null,
                                )
                            : null,
                        child: CustomMemImageView(
                          imageData: tbController.imageData,
                          isLoading: tbController.isLoading,
                          height: 250,
                        ),
                      );
                    }),
                  ),
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
