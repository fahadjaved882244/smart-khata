import 'package:get/get.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

class CustomerDetailController extends GetxController {
  final CustomerProvider _provider;
  CustomerDetailController(this._provider);

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<void> deleteCustomer(String id) async {
    _isLoading(true);
    if (await _provider.delete(id)) {
      Get.back();
      showCustomSnackBar(message: "Customer Deleted!", isSuccess: true);
    }
    _isLoading(false);
  }
}
