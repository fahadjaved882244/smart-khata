import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/modules/components/popups/custom_dialog.dart';
import 'package:khata/modules/components/popups/custom_option_dialog.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/custom_loader.dart';
import 'package:khata/modules/customer/customer_detail/components/top_customer_card.dart';
import 'package:khata/modules/customer/customer_detail/customer_detail_controller.dart';
import 'package:khata/modules/transaction/transaction_list/transaction_list_view.dart';
import 'package:khata/routes/route_names.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/bottom_button_bar.dart';

class CustomerDetailView extends StatelessWidget {
  final customer = Get.arguments as CustomerModel;
  CustomerDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController(customer.id));

    return WillPopScope(
      onWillPop: () async {
        if (controller.isSelectable) {
          controller.isSelectable = false;
          controller.selectedItems.clear();
          return false;
        }
        return true;
      },
      child: Obx(() {
        if (!controller.isLoading) {
          return BaseScaffold(
            title: customer.name,
            noPadding: true,
            actions: [
              if (!controller.isSelectable) ...[
                IconButton(
                  onPressed: () async {
                    if (customer.phoneNumber != null &&
                        await canLaunchUrl(
                            Uri.parse('tel:${customer.phoneNumber}'))) {
                      await launchUrl(Uri.parse('tel:${customer.phoneNumber}'));
                    }
                  },
                  icon: const Icon(Icons.phone_outlined),
                ),
                PopupMenuButton(
                  initialValue: -1,
                  icon: const Icon(Icons.more_vert_outlined),
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 0, child: Text("Edit")),
                    PopupMenuItem(value: 1, child: Text("Delete"))
                  ],
                  onSelected: (i) async {
                    if (i == 0) {
                      Get.toNamed(
                        RouteNames.updateCustomerView,
                        arguments: customer,
                      );
                    } else if (i == 1) {
                      if (await showCustomDialog(
                        context: context,
                        title: "Delete Customer?",
                        subTitle:
                            "Customer will be permanently removed form your account. Sure, you want to delete this customer?",
                        rightButtonTitle: "Delete",
                      )) {
                        await controller.deleteCustomer();
                      }
                    }
                  },
                ),
              ],
              if (controller.isSelectable &&
                  controller.selectedItems.length == 1)
                IconButton(
                  onPressed: () {
                    Get.toNamed(
                      RouteNames.updateTransactionView,
                      arguments: [customer.id, controller.selectedItems[0]],
                    );
                    controller.isSelectable = false;
                    controller.selectedItems.clear();
                  },
                  icon: const Icon(Icons.edit_outlined),
                ),
              if (controller.isSelectable &&
                  controller.selectedItems.isNotEmpty)
                IconButton(
                  onPressed: () async {
                    final result = await showCustomOptionDialog(
                      context: context,
                      title:
                          "Remove (${controller.selectedItems.length}) Transactions?",
                      options: {0: "Clear", 1: "Delete"},
                    );
                    if (result == 0) {
                      await controller.clearSelected();
                    } else if (result == 1) {
                      await controller.deleteSelected();
                    } else {
                      controller.isSelectable = false;
                      controller.selectedItems.clear();
                    }
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              if (controller.isSelectable)
                IconButton(
                  onPressed: () {
                    controller.selectedItems.clear();
                    controller.isSelectable = false;
                  },
                  icon: const Icon(Icons.close),
                ),
            ],
            bottomNavigationBar: BottomButtonBar(customer: customer),
            child: Column(
              children: [
                TopCustomerCard(
                  customer: customer,
                  credit: controller.dataList
                      .fold(0.0, (prev, trans) => prev + trans.amount),
                ),
                const Expanded(child: TransactionListView()),
              ],
            ),
          );
        } else {
          return const CustomLoader();
        }
      }),
    );
  }
}
