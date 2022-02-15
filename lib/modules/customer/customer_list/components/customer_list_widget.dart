import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/modules/components/widgets/avatar_image_text.dart';
import 'package:khata/modules/components/widgets/custom_list_tile.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/extensions/date_time_extensions.dart';

class CustomerListWidget extends StatelessWidget {
  final List<CustomerModel> customers;
  const CustomerListWidget({Key? key, required this.customers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final grayColor =
        Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5);
    final greenColor = Theme.of(context).colorScheme.primary;
    final redColor = Theme.of(context).colorScheme.error;

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
          trailing: _trailingWidget(i, grayColor, redColor, greenColor),
        );
      },
      separatorBuilder: (_, __) => const Divider(
        height: 0,
        indent: AppSizes.largePadding - 6,
        endIndent: AppSizes.exSmallPadding,
      ),
    );
  }

  Padding _trailingWidget(
      int i, Color grayColor, Color redColor, Color greenColor) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.exSmallPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (customers[i].credit == 0)
            Text(
              "Clear",
              style: TextStyle(color: grayColor),
            )
          else if (customers[i].credit.isNegative)
            Text(
              "Due",
              style: TextStyle(color: redColor),
            )
          else
            Text(
              "Paid",
              style: TextStyle(color: greenColor),
            ),
          Text(
            "Rs. ${customers[i].credit.toInt()}",
            style: TextStyle(
              color: customers[i].credit == 0
                  ? grayColor
                  : customers[i].credit.isNegative
                      ? redColor
                      : greenColor,
            ),
          ),
        ],
      ),
    );
  }
}
