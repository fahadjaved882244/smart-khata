import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/data/providers/transaction_provider.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';
import 'package:uuid/uuid.dart';

class AddTransactionController extends GetxController {
  final TransactionProvider provider;
  AddTransactionController(this.provider);

  late final TextEditingController amountController;
  late final TextEditingController noteController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  onInit() {
    amountController = TextEditingController();
    noteController = TextEditingController();
    super.onInit();
  }

  @override
  onClose() {
    amountController.dispose();
    noteController.dispose();
    super.onClose();
  }

  void updateValidationMode() {
    autoValidate = AutovalidateMode.onUserInteraction;
    update(['UPDATE_FORM']);
  }

  Future<void> addTransaction(CustomerModel customer, bool willAdd) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final amount = double.tryParse(amountController.text);
    if (amount != null) {
      final signedAmount = willAdd ? amount : amount * -1;
      final model = TransactionModel(
        id: const Uuid().v1(),
        amount: signedAmount,
        dateTime: DateTime.now(),
        note: noteController.text.isEmpty ? null : noteController.text,
      );
      _isLoading(true);
      await provider.create(customer.id, model);
      _isLoading(false);
      Get.back();
    } else {
      showCustomSnackBar(message: "Invalid Amount", isError: true);
    }
  }
}
