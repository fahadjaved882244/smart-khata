import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/business/business_list/business_list_controller.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/avatar_image_text.dart';
import 'package:khata/modules/components/widgets/custom_list_tile.dart';
import 'package:khata/modules/components/widgets/empty_view.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';

import 'components/business_list_widget.dart';

class BusinessListView extends StatelessWidget {
  final String? businessId = Get.parameters['businessId'];
  BusinessListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (businessId != null) {
      final controller = Get.put(BusinessListController(businessId!));
      return BaseScaffold(
        noPadding: true,
        title: "Manage Businesses",
        child: Obx(() {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (controller.dataList.isEmpty) {
            return const Center(child: Text('No Businesses Found!'));
          } else {
            return Column(
              children: [
                _addBusinessButton(context),
                const Divider(),
                Expanded(
                    child: BusinessListWidget(
                  businesses: controller.dataList,
                  businessId: businessId!,
                )),
              ],
            );
          }
        }),
      );
    } else {
      return const EmptyView(title: 'BusinessId Not Found!');
    }
  }

  Padding _addBusinessButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
      child: CustomListTile(
        title: "Add Business",
        subtitle: "Tap to add a new business",
        onTap: () => Get.toNamed(RouteNames.addBusinessView),
        leading: AvatarImageText(
          name: "New",
          icon: Icon(
            Icons.business_center,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        trailing: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
