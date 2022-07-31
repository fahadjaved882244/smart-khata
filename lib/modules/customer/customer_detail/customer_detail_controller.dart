import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/data/providers/storage_provider.dart';
import 'package:khata/data/providers/transaction_provider.dart';
import 'package:khata/modules/components/controllers/i_list_controller.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

class CustomerDetailController extends IListController<TransactionModel> {
  final String businessId;
  final String customerId;
  CustomerDetailController(this.businessId, this.customerId);

  late final ScrollController scrollController;
  final RxList<TransactionModel> _list = <TransactionModel>[].obs;
  List<TransactionModel> get uiList => _list;
  set uiList(List<TransactionModel> list) => _list.value = list;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  @override
  void subsribeToStream() {
    isLoading = true;
    dataStream =
        TransactionProvider.watchAll(businessId, customerId).listen((event) {
      dataList = event;
      uiList = event;
      uiList.removeWhere((t) => t.clear == true);
      uiList = uiList.reversed.toList();
      isLoading = false;
    });
  }

  Future<void> deleteCustomer() async {
    isLoading = true;
    if (await CustomerProvider.delete(businessId, customerId)) {
      Get.back(closeOverlays: true);
      showCustomSnackBar(message: "Customer Deleted!", isSuccess: true);
    }
    isLoading = false;
  }

  Future<void> deleteSelected() async {
    isLoading = true;
    final transList = selectedItems
        .map((t) =>
            TransactionProvider.delete(businessId, customerId, t.id, t.amount))
        .toList();

    final imageList = selectedItems.map((t) {
      if (t.photoUrl != null) {
        return StorageProvider.delete(t.photoUrl!);
      }
      return Future.value(true);
    }).toList();

    final list = transList + imageList;
    await Future.wait(list);
    isSelectable = false;
    selectedItems.clear();
    isLoading = false;
  }

  Future<void> clearSelected() async {
    isLoading = true;
    final transList = selectedItems
        .map((t) => TransactionProvider.clear(businessId, customerId, t))
        .toList();
    final imageList = selectedItems.map((t) {
      if (t.photoUrl != null) {
        return StorageProvider.delete(t.photoUrl!);
      }
      return Future.value(true);
    }).toList();

    final list = transList + imageList;
    await Future.wait(list);
    isSelectable = false;
    selectedItems.clear();
    isLoading = false;
  }
}
