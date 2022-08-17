import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/components/widgets/custom_date_chip.dart';
import 'package:khata/modules/customer/customer_detail/customer_detail_controller.dart';
import 'package:khata/modules/transaction/transaction_list/components/transaction_thumbnail.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/extensions/date_time_extensions.dart';

class TransactionListView extends GetView<CustomerDetailController> {
  const TransactionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final dataList = controller.uiList;
      if (dataList.isEmpty) {
        return const Center(child: Text('No transactions yet!'));
      } else {
        return Padding(
          padding: const EdgeInsets.only(),
          child: ListView.separated(
            reverse: true,
            padding:
                const EdgeInsets.all(AppSizes.smallPadding).copyWith(top: 0),
            controller: controller.scrollController,
            itemCount: dataList.length,
            itemBuilder: (_, i) {
              final transaction = dataList[i];
              bool showDate = false;
              if (i == controller.dataList.length - 1 ||
                  transaction.dateTime.formattedDate !=
                      dataList[i + 1].dateTime.formattedDate) {
                showDate = true;
              }
              return Column(
                children: [
                  if (showDate)
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomDateChip(date: transaction.dateTime),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                  Obx(() {
                    return TransactionThumbnail(
                      transaction: dataList[i],
                      isSelected:
                          controller.selectedItems.contains(transaction),
                      onTap: () {
                        if (controller.isSelectable) {
                          controller.selectItem(transaction);
                        }
                      },
                      onLongPress: () {
                        controller.isSelectable = true;
                        controller.selectItem(transaction);
                      },
                    );
                  }),
                ],
              );
            },
            separatorBuilder: (_, i) =>
                const SizedBox(height: AppSizes.smallPadding),
          ),
        );
      }
    });
  }
}
