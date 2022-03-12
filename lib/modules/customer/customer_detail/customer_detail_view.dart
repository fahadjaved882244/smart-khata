import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/data/providers/transaction_provider.dart';
import 'package:khata/modules/components/popups/custom_dialog.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/custom_loader.dart';
import 'package:khata/modules/customer/customer_detail/components/top_customer_card.dart';
import 'package:khata/modules/customer/customer_detail/customer_detail_controller.dart';
import 'package:khata/modules/transaction/transaction_list/transaction_list_view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/bottom_button_bar.dart';

class CustomerDetailView extends StatelessWidget {
  final customer = Get.arguments as CustomerModel;
  CustomerDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CustomerDetailController(
        CustomerProvider(),
        TransactionProvider(),
        customer.id,
      ),
    );

    return Obx(() {
      if (!controller.isLoading) {
        return BaseScaffold(
          title: customer.name,
          noPadding: true,
          actions: [
            IconButton(
              onPressed: () async {
                if (customer.phoneNumber != null &&
                    await canLaunch('tel:${customer.phoneNumber}')) {
                  await launch('tel:${customer.phoneNumber}');
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
                if (i == 1) {
                  if (await showCustomDialog(
                      context: context,
                      title: "Delete Customer",
                      subTitle: "Sure, you want to delete this customer?")) {
                    await controller.deleteCustomer(customer.id);
                  }
                }
              },
            ),
          ],
          bottomNavigationBar: BottomButtonBar(customer: customer),
          child: Column(
            children: [
              TopCustomerCard(
                customer: customer,
                credit: controller.transactions
                    .fold(0.0, (prev, trans) => prev + trans.amount),
              ),
              Expanded(
                child:
                    TransactionListView(transactions: controller.transactions),
              ),
            ],
          ),
        );
      } else {
        return const CustomLoader();
      }
    });
  }
}
