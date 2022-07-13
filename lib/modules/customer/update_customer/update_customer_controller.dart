import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:khata/data/models/customer.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/extensions/string_extensions.dart';
import 'package:khata/routes/route_names.dart';

class UpdateCustomerController extends GetxController {
  final String businessId;
  final CustomerModel customer;
  UpdateCustomerController(this.businessId, this.customer);

  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: customer.name);
    phoneController = TextEditingController(text: customer.phoneNumber);
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

  Future<void> updateCustomer() async {
    final model = customer.copyWith(
      name: nameController.text,
      phoneNumber: phoneController.text.nullIfEmpty?.formatPhoneNumber,
    );
    _isLoading(true);
    final status =
        await CustomerProvider.update(businessId, customer.id, model.toMap());
    _isLoading(false);
    if (status) {
      Get.offNamedUntil(
        RouteNames.customerDetailView,
        (route) {
          return route.settings.name!.getRountingData.route ==
              RouteNames.customerListView;
        },
        arguments: model,
      );
    }
  }
}
