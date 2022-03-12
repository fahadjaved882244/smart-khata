import 'package:get/get.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/modules/customer/customer_list/customer_list_controller.dart';

class CustomerListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerListController(CustomerProvider()));
  }
}
