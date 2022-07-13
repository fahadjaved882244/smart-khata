import 'dart:async';

import 'package:get/get.dart';
import 'package:khata/data/models/business.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/data/providers/business_provider.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/modules/auth/auth_controller.dart';
import 'package:khata/modules/components/controllers/i_list_controller.dart';

class CustomerListController extends IListController<CustomerModel> {
  final String businessId;
  CustomerListController(this.businessId);

  bool isBusLoading = true;
  BusinessModel? businessModel;

  @override
  void subsribeToStream() {
    isLoading = true;
    dataStream = CustomerProvider.watchAll(businessId).listen((event) {
      dataList = event;
      isLoading = false;
    });
  }

  @override
  onReady() async {
    super.onReady();
    businessModel = await BusinessProvider.read(businessId);
    isBusLoading = false;
    update(['BUSINESS_MODEL']);
  }

  Future<void> logout() async {
    isLoading = true;
    await Get.find<AuthController>().logout();
    isLoading = false;
  }

  Future<void> deleteSelected() async {
    isLoading = true;
    final List<Future> list = [];
    for (final customer in selectedItems) {
      list.add(CustomerProvider.delete(businessId, customer.id));
    }
    isSelectable = false;
    await Future.wait(list);
    selectedItems.clear();
    isLoading = false;
  }
}
