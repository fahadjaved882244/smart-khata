import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'package:khata/data/models/contact.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/extensions/string_extensions.dart';
import 'package:khata/routes/route_names.dart';

class AddCustomerController extends GetxController {
  final ContactModel? contactModel;
  AddCustomerController(this.contactModel);

  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    if (contactModel != null) {
      nameController.text = contactModel!.name;
      if (contactModel!.phone != null) {
        phoneController.text = contactModel!.phone!;
      }
    }
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> addCustomer() async {
    final model = CustomerModel(
      id: const Uuid().v1(),
      name: nameController.text,
      phoneNumber: phoneController.text.nullIfEmpty?.formatPhoneNumber,
      credit: 0,
    );
    _isLoading(true);
    final status = await CustomerProvider().create(model);
    _isLoading(false);
    if (status) {
      Get.offAndToNamed(RouteNames.customerDetailView, arguments: model);
      // showCustomSnackBar(message: "Customer Added!", isSuccess: true);
    }
  }
}
