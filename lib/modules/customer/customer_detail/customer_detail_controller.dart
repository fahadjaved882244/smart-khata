import 'dart:async';

import 'package:get/get.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/data/providers/transaction_provider.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

class CustomerDetailController extends GetxController {
  final CustomerProvider _cusProvider;
  final TransactionProvider _traProvider;
  final String customerId;
  CustomerDetailController(
    this._cusProvider,
    this._traProvider,
    this.customerId,
  );

  late final StreamSubscription<List<TransactionModel>> dataStream;

  final RxList<TransactionModel> _dataList = <TransactionModel>[].obs;
  List<TransactionModel> get transactions => _dataList;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading(value);

  @override
  onInit() {
    super.onInit();
    subsribeToStream();
  }

  @override
  void onClose() {
    dataStream.cancel();
    super.onClose();
  }

  void subsribeToStream() {
    isLoading = true;
    dataStream = _traProvider.watchAll(customerId).listen((event) {
      _dataList.value = event;
      isLoading = false;
    });
  }

  Future<void> deleteCustomer(String id) async {
    _isLoading(true);
    if (await _cusProvider.delete(id)) {
      Get.back(closeOverlays: true);
      showCustomSnackBar(message: "Customer Deleted!", isSuccess: true);
    }
    _isLoading(false);
  }
}
