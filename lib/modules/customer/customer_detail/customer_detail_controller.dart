import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/data/providers/customer_provider.dart';
import 'package:khata/data/providers/transaction_provider.dart';
import 'package:khata/modules/components/controllers/i_list_controller.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

class CustomerDetailController extends IListController<TransactionModel> {
  final String customerId;
  CustomerDetailController(this.customerId);

  late final ScrollController scrollController;

  @override
  void onInit() {
    scrollController = ScrollController();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  @override
  void subsribeToStream() {
    isLoading = true;
    dataStream = TransactionProvider.watchAll(customerId).listen((event) {
      dataList = event;
      isLoading = false;
    });
  }

  Future<void> deleteCustomer() async {
    isLoading = true;
    if (await CustomerProvider.delete(customerId)) {
      Get.back(closeOverlays: true);
      showCustomSnackBar(message: "Customer Deleted!", isSuccess: true);
    }
    isLoading = false;
  }

  Future<void> deleteSelected() async {
    isLoading = true;
    final List<Future> list = [];
    for (final transaction in selectedItems) {
      final oldAmount = transaction.amount;
      list.add(
        TransactionProvider.delete(customerId, transaction.id, oldAmount),
      );
    }
    isSelectable = false;
    await Future.wait(list);
    selectedItems.clear();
    isLoading = false;
  }
}
