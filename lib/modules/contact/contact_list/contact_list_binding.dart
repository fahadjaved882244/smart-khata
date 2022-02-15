import 'package:get/get.dart';

import 'contact_list_controller.dart';

class ContactListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactListController());
  }
}
