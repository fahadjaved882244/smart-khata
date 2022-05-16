import 'package:get/get.dart';
import 'add_transaction_controller.dart';

class AddTransactionBinding implements Bindings {
  const AddTransactionBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => AddTransactionController());
  }
}
