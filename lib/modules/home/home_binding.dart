import 'package:get/get.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/modules/customer/customer_list/customer_list_controller.dart';

import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CustomerListController(CustomerProvider()));
  }
}
