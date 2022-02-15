import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/contact.dart';
import 'package:khata/modules/components/widgets/avatar_image_text.dart';
import 'package:khata/modules/components/widgets/custom_list_tile.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';

class ContactListWidget extends StatelessWidget {
  final List<ContactModel> contacts;
  const ContactListWidget({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
      itemCount: contacts.length,
      itemBuilder: (context, i) {
        return CustomListTile(
          dense: true,
          title: contacts[i].name,
          subtitle: contacts[i].phone,
          onTap: () {
            Get.toNamed(RouteNames.addContactView, arguments: contacts[i]);
          },
          leading: AvatarImageText(
            name: contacts[i].name,
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
