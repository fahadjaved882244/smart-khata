import 'package:get/get.dart';
import 'package:khata/data/providers/transaction_provider.dart';

import 'add_transaction_controller.dart';

class AddTransactionBinding implements Bindings {
  const AddTransactionBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => AddTransactionController(TransactionProvider()));
  }
}
