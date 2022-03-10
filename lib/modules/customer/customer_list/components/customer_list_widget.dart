import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/modules/components/widgets/avatar_image_text.dart';
import 'package:khata/modules/components/widgets/custom_list_tile.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/extensions/date_time_extensions.dart';
import 'package:khata/themes/app_theme.dart';

class CustomerListWidget extends StatelessWidget {
  final List<CustomerModel> customers;
  const CustomerListWidget({Key? key, required this.customers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: customers.length,
      itemBuilder: (context, i) {
        return CustomListTile(
          dense: true,
          title: customers[i].name,
          subtitle: customers[i].lastActivity.formattedDateTime ?? "",
          onTap: () {
            Get.toNamed(RouteNames.customerDetailView, arguments: customers[i]);
          },
          leading: AvatarImageText(
            name: customers[i].name,
            imageUrl: customers[i].photoUrl,
          ),
          trailing: _trailingWidget(i),
        );
      },
      separatorBuilder: (_, __) => const Divider(
        height: 0,
        indent: AppSizes.largePadding - 6,
        endIndent: AppSizes.exSmallPadding,
      ),
    );
  }

  Padding _trailingWidget(int i) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.exSmallPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (customers[i].credit == 0)
            const Text(
              "Clear",
              style: TextStyle(color: AppColors.darkGray),
            )
          else if (customers[i].credit.isNegative)
            const Text(
              "Due",
              style: TextStyle(color: AppColors.red),
            )
          else
            const Text(
              "Paid",
              style: TextStyle(color: AppColors.green),
            ),
          Text(
            "Rs. ${customers[i].credit.toInt()}",
            style: TextStyle(
              color: customers[i].credit == 0
                  ? AppColors.darkGray
                  : customers[i].credit.isNegative
                      ? AppColors.red
                      : AppColors.green,
            ),
          ),
        ],
      ),
    );
  }
}
