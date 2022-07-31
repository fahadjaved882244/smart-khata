import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khata/data/models/business.dart';
import 'package:khata/modules/components/widgets/avatar_image_text.dart';
import 'package:khata/modules/components/widgets/custom_list_tile.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';

class BusinessListWidget extends StatefulWidget {
  final String businessId;
  final List<BusinessModel> businesses;
  const BusinessListWidget(
      {Key? key, required this.businesses, required this.businessId})
      : super(key: key);

  @override
  State<BusinessListWidget> createState() => _BusinessListWidgetState();
}

class _BusinessListWidgetState extends State<BusinessListWidget> {
  late String bid = widget.businessId;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
      itemCount: widget.businesses.length,
      itemBuilder: (context, i) {
        return CustomListTile(
          dense: true,
          title: widget.businesses[i].name,
          onTap: () => _toggleBusiness(widget.businesses[i].id),
          onLongPress: () => Get.toNamed(
            RouteNames.updateBusinessView,
            arguments: widget.businesses[i],
          ),
          leading: AvatarImageText(
            name: widget.businesses[i].name,
            imageUrl: null,
          ),
          trailing: Radio<String>(
            value: widget.businesses[i].id,
            groupValue: bid,
            onChanged: _toggleBusiness,
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(
        height: AppSizes.smallPadding,
        indent: AppSizes.largePadding - 6,
        endIndent: AppSizes.exSmallPadding,
      ),
    );
  }

  void _toggleBusiness(id) async {
    if (id != null) {
      setState(() => bid = id);
      await GetStorage().write('businessId', id);
      Get.offAllNamed(
        RouteNames.customerListView,
        parameters: {'businessId': id},
      );
    }
  }
}
