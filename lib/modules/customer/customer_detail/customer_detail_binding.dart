import 'package:get/get.dart';
import 'package:khata/data/providers/customer_provider.dart';

import 'customer_detail_controller.dart';

class CustomerDetailBinding implements Bindings {
  const CustomerDetailBinding();
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerDetailController(CustomerProvider()));
  }
}
