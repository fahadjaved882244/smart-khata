import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/modules/components/widgets/avatar_image_text.dart';
import 'package:khata/modules/components/widgets/custom_list_tile.dart';
import 'package:khata/modules/contact/contact_list/components/contact_list_widget.dart';
import 'package:khata/modules/contact/contact_list/components/search_contact_widget.dart';
import 'package:khata/modules/contact/contact_list/contact_list_controller.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';

class ContactListView extends GetView<ContactListController> {
  const ContactListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      noPadding: true,
      title: "Add Customer",
      child: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.permissionDenied) {
          return const Center(child: Text('Permission Denied'));
        } else if (controller.contacts.isEmpty) {
          return const Center(child: Text('No Contacts Found!'));
        } else {
          return Column(
            children: [
              const SearchContactWidget(),
              const SizedBox(height: 6),
              _addContactButton(context),
              const Divider(),
              Expanded(child: ContactListWidget(contacts: controller.contacts)),
            ],
          );
        }
      }),
    );
  }

  Padding _addContactButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
      child: CustomListTile(
        title: "Add Contact",
        subtitle: "Tap to add a new contact",
        onTap: () => Get.toNamed(RouteNames.addCustomerView),
        leading: AvatarImageText(
          name: "New",
          icon: Icon(
            Icons.person_add,
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
