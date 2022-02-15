import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/app_logo_text.dart';
import 'package:khata/modules/customer/customer_list/customer_list_view.dart';
import 'package:khata/modules/home/components/balance_widget.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      noPadding: true,
      titleWidget: const AppLogoText(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(RouteNames.contactListView),
        icon: const Icon(Icons.person_add),
        label: const Text("Add Customer"),
      ),
      child: Column(
        children: const [
          BalanceWidget(),
          SizedBox(height: AppSizes.smallPadding),
          Expanded(child: CustomerListView()),
        ],
      ),
    );
  }
}
