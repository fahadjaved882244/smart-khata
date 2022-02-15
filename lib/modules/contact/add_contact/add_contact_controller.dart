import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/contact.dart';

class AddContactController extends GetxController {
  final ContactModel? contactModel;
  AddContactController(this.contactModel);

  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading(value);

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
}
