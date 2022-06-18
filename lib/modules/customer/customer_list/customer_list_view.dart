import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/components/popups/custom_dialog.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/app_logo_text.dart';
import 'package:khata/modules/customer/customer_list/components/customer_list_widget.dart';
import 'package:khata/modules/customer/customer_list/components/search_customer_widget.dart';
import 'package:khata/modules/customer/customer_list/customer_list_controller.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';

import 'components/balance_widget.dart';

class CustomerListView extends GetView<CustomerListController> {
  const CustomerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        return BaseScaffold(
          noPadding: true,
          titleWidget: const AppLogoText(),
          actions: [
            if (!controller.isSelectable)
              PopupMenuButton(
                initialValue: -1,
                icon: const Icon(Icons.more_vert_outlined),
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 0, child: Text("Settings")),
                  PopupMenuItem(value: 1, child: Text("Logout"))
                ],
                onSelected: (i) async {
                  if (i == 1) {
                    if (await showCustomDialog(
                      context: context,
                      title: "Logout App?",
                      subTitle: "Sure, you want to logout from smart-khata?",
                      rightButtonTitle: "Logout",
                    )) {
                      await controller.logout();
                    }
                  }
                },
              ),
            if (controller.isSelectable && controller.selectedItems.length == 1)
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  Get.toNamed(
                    RouteNames.updateCustomerView,
                    arguments: controller.selectedItems[0],
                  );
                  controller.isSelectable = false;
                  controller.selectedItems.clear();
                },
              ),
            if (controller.isSelectable && controller.selectedItems.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded),
                onPressed: () async {
                  if (await showCustomDialog(
                    context: context,
                    title: "Delete Customers?",
                    subTitle:
                        "Sure, you want to delete (${controller.selectedItems.length}) customer?",
                    rightButtonTitle: "Delete",
                  )) {
                    await controller.deleteSelected();
                  } else {
                    controller.isSelectable = false;
                    controller.selectedItems.clear();
                  }
                },
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Get.toNamed(RouteNames.contactListView),
            icon: const Icon(Icons.person_add),
            label: const Text("Add Customer"),
          ),
          child: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const BalanceWidget(),
                    if (controller.dataList.isEmpty)
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_add_outlined,
                            size: 100,
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.0),
                            child: Text(
                              'Add customers and start managing there\nSmart-Khata!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ))
                    else
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.smallPadding),
                          child: Column(children: const [
                            SizedBox(height: AppSizes.smallPadding),
                            SearchCustomerWidget(),
                            SizedBox(height: AppSizes.exSmallPadding),
                            Expanded(child: CustomerListWidget())
                          ]),
                        ),
                      ),
                  ],
                ),
        );
      }),
    );
  }
}
