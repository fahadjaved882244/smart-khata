import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/customer/customer_list/components/customer_list_widget.dart';
import 'package:khata/modules/customer/customer_list/components/search_customer_widget.dart';
import 'package:khata/modules/customer/customer_list/customer_list_controller.dart';
import 'package:khata/themes/app_sizes.dart';

class CustomerListView extends GetView<CustomerListController> {
  const CustomerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.customers.isEmpty) {
        return const Center(child: Text('No Customers Found!'));
      } else {
        return Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.exSmallPadding),
          child: Column(
            children: [
              const SearchCustomerWidget(),
              const SizedBox(height: AppSizes.exSmallPadding),
              Expanded(
                child: CustomerListWidget(customers: controller.customers),
              ),
            ],
          ),
        );
      }
    });
  }
}
