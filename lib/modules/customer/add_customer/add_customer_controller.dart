import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khata/modules/components/controllers/i_base_controller.dart';
import 'package:uuid/uuid.dart';

import 'package:khata/data/models/contact.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/extensions/string_extensions.dart';
import 'package:khata/routes/route_names.dart';

class AddCustomerController extends IBaseController {
  final String businessId;
  final ContactModel? contactModel;
  AddCustomerController(this.contactModel, this.businessId);

  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    if (contactModel != null) {
      nameController.text = contactModel!.name;
      if (contactModel!.phone != null) {
        phoneController.text = contactModel!.phone!;
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void updateValidationMode() {
    autoValidate = AutovalidateMode.onUserInteraction;
    update(['UPDATE_FORM']);
  }

  Future<void> addCustomer() async {
    final model = CustomerModel(
      id: const Uuid().v1(),
      name: nameController.text,
      phoneNumber: phoneController.text.nullIfEmpty?.formatPhoneNumber,
      credit: 0,
    );
    isLoading = true;
    final status = await CustomerProvider.create(businessId, model);
    isLoading = false;
    if (status) {
      Get.offAllNamed(
        RouteNames.customerDetailView,
        predicate: (route) {
          if (route.settings.name != null) {
            return route.settings.name!.getRountingData.route ==
                RouteNames.customerListView;
          }
          return false;
        },
        arguments: model,
      );
    }
  }
}
