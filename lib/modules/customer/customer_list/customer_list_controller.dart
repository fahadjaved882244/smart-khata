import 'dart:async';

import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/data/providers/customer_provider.dart';

class CustomerListController extends GetxController {
  final CustomerProvider _provider;
  CustomerListController(this._provider);

  final RxList<CustomerModel> dataList = <CustomerModel>[].obs;
  List<CustomerModel> get customers => dataList;
  late final StreamSubscription<List<CustomerModel>> dataStream;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading(value);

  @override
  onInit() {
    super.onInit();
    subsribeToStream();
  }

  void subsribeToStream() {
    isLoading = true;
    dataStream = _provider.watchAll().listen((event) {
      dataList.value = event;
      isLoading = false;
    });
  }
}
