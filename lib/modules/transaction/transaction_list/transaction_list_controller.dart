import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TransactionListController extends GetxController {
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
}
