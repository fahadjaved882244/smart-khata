import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/business.dart';
import 'package:khata/modules/components/widgets/avatar_image_text.dart';
import 'package:khata/modules/components/widgets/custom_list_tile.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';

class BusinessListWidget extends StatelessWidget {
  final String businessId;
  final List<BusinessModel> businesses;
  const BusinessListWidget(
      {Key? key, required this.businesses, required this.businessId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
      itemCount: businesses.length,
      itemBuilder: (context, i) {
        return CustomListTile(
          dense: true,
          title: businesses[i].name,
          onTap: () {
            Get.toNamed(
              RouteNames.addCustomerView,
              arguments: businesses[i],
              parameters: {'businessId': businessId},
            );
          },
          leading: AvatarImageText(
            name: businesses[i].name,
            imageUrl: null,
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(
        height: 0,
        indent: AppSizes.largePadding - 6,
        endIndent: AppSizes.exSmallPadding,
      ),
    );
  }
}
