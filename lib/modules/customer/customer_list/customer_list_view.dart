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
    return BaseScaffold(
      noPadding: true,
      titleWidget: const AppLogoText(),
      actions: [
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
                  title: "Logout App",
                  subTitle: "Sure, you want to logout from smart-khata?")) {
                await controller.logout();
              }
            }
          },
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(RouteNames.contactListView),
        icon: const Icon(Icons.person_add),
        label: const Text("Add Customer"),
      ),
      child: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              const BalanceWidget(),
              if (controller.customers.isEmpty)
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_outlined,
                      size: 100,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(children: [
                      const SizedBox(height: AppSizes.smallPadding),
                      const SearchCustomerWidget(),
                      const SizedBox(height: AppSizes.exSmallPadding),
                      Expanded(
                        child: CustomerListWidget(
                          customers: controller.customers,
                        ),
                      )
                    ]),
                  ),
                ),
            ],
          );
        }
      }),
    );
  }
}
