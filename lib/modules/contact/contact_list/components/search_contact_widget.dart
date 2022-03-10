import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/contact.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/components/widgets/custom_text_form_field.dart';
import 'package:khata/modules/contact/contact_list/components/contact_list_widget.dart';
import 'package:khata/modules/contact/contact_list/contact_list_controller.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';

class SearchContactWidget extends GetView<ContactListController> {
  const SearchContactWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.smallPadding).copyWith(top: 0),
        child: InkWell(
          onTap: () {
            showSearch(
              context: context,
              delegate: _SearchDelegate(controller.contacts),
            );
          },
          child: CustomTextFormField(
            enabled: false,
            fillColor: Theme.of(context).colorScheme.surface,
            hintText: "Search by name or phone number",
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}

class _SearchDelegate extends SearchDelegate {
  final List<ContactModel> contacts;
  _SearchDelegate(this.contacts);
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
    final result = contacts.where((c) {
      if (c.name.toLowerCase().contains(query.toLowerCase())) {
        return true;
      } else if (c.phone != null &&
          c.phone!.contains(query.removeAllWhitespace)) {
        return true;
      }
      return false;
    }).toList();

    if (result.isNotEmpty) {
      return ContactListWidget(contacts: result);
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
              onPressed: () => Get.toNamed(RouteNames.addCustomerView),
            ),
          ],
        ),
      );
    }
  }
}
