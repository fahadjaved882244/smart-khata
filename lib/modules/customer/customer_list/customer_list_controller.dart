import 'dart:async';

import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/modules/auth/auth_controller.dart';
import 'package:khata/modules/components/controllers/i_list_controller.dart';

class CustomerListController extends IListController<CustomerModel> {
  Future<void> logout() async {
    isLoading = true;
    Get.find<AuthController>().logout();
    isLoading = false;
  }

  @override
  void subsribeToStream() {
    isLoading = true;
    dataStream = CustomerProvider.watchAll().listen((event) {
      dataList = event;
      isLoading = false;
    });
  }

  Future<void> deleteSelected() async {
    isLoading = true;
    final List<Future> list = [];
    for (final customer in selectedItems) {
      list.add(CustomerProvider.delete(customer.id));
    }
    isSelectable = false;
    await Future.wait(list);
    selectedItems.clear();
    isLoading = false;
  }
}
