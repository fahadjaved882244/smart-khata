import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/modules/components/widgets/custom_date_chip.dart';
import 'package:khata/modules/transaction/transaction_list/components/transaction_thumbnail.dart';
import 'package:khata/modules/transaction/transaction_list/transaction_list_controller.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/extensions/date_time_extensions.dart';

class TransactionListView extends StatelessWidget {
  final List<TransactionModel> transactions;
  const TransactionListView({Key? key, required this.transactions})
      : super(key: key);

  void _scrollToBottom(TransactionListController controller) {
    if (controller.scrollController.hasClients) {
      controller.scrollController.jumpTo(
        controller.scrollController.position.maxScrollExtent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionListController());
    if (transactions.isEmpty) {
      return const Center(child: Text('No transactions yet!'));
    } else {
      WidgetsBinding.instance!
          .addPostFrameCallback((_) => _scrollToBottom(controller));
      return Padding(
        padding: const EdgeInsets.only(top: AppSizes.smallPadding),
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSizes.smallPadding).copyWith(top: 0),
          controller: controller.scrollController,
          itemCount: transactions.length,
          itemBuilder: (_, i) {
            final transaction = transactions[i];
            bool showDate = false;
            if (i == 0 ||
                transaction.dateTime.formattedDate !=
                    transactions[i - 1].dateTime.formattedDate) {
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
                TransactionThumbnail(transaction: transactions[i]),
              ],
            );
          },
          separatorBuilder: (_, i) =>
              const SizedBox(height: AppSizes.smallPadding),
        ),
      );
    }
  }
}
