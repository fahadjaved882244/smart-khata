import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/components/widgets/custom_text_form_field.dart';
import 'package:khata/modules/customer/customer_list/components/customer_list_widget.dart';
import 'package:khata/modules/customer/customer_list/customer_list_controller.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';

class SearchCustomerWidget extends GetView<CustomerListController> {
  const SearchCustomerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showSearch(
          context: context,
          delegate: _SearchDelegate(controller.dataList),
        );
      },
      child: const CustomTextFormField(
        enabled: false,
        hintText: "Search customers",
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}

class _SearchDelegate extends SearchDelegate {
  final List<CustomerModel> customers;
  _SearchDelegate(this.customers);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return getList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return getList(context);
  }

  Widget getList(BuildContext context) {
    final result = customers.where((c) {
      if (c.name.toLowerCase().contains(query.toLowerCase())) {
        return true;
      } else if (c.phoneNumber != null &&
          c.phoneNumber!.contains(query.removeAllWhitespace)) {
        return true;
      }
      return false;
    }).toList();

    if (result.isNotEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
        child: CustomerListWidget(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This customer does not exist in your contact list.\nAdd new customer now.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.mediumPadding),
            CustomFilledButton(
              text: "Add Contact",
              onPressed: () => Get.toNamed(RouteNames.contactListView),
            ),
          ],
        ),
      );
    }
  }
}
