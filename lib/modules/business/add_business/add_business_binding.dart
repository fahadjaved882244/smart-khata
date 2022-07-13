import 'package:get/get.dart';
import 'add_business_controller.dart';

class AddBusinessBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddBusinessController());
  }
}
