import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/data/providers/transaction_provider.dart';
import 'package:khata/modules/components/popups/custom_date_picker.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';
import 'package:khata/extensions/date_time_extensions.dart';

class UpdateTransactionController extends GetxController {
  final TransactionModel transaction;
  UpdateTransactionController(this.transaction);

  late final double oldAmount;
  late DateTime datePicked;

  late final TextEditingController amountController;
  late final TextEditingController dateController;
  late final TextEditingController noteController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  onInit() {
    oldAmount = transaction.amount;
    datePicked = transaction.dateTime;
    amountController =
        TextEditingController(text: transaction.amount.abs().toString());
    dateController = TextEditingController(text: datePicked.formattedDateRaw);
    noteController = TextEditingController(text: transaction.note);
    super.onInit();
  }

  @override
  onClose() {
    amountController.dispose();
    dateController.dispose();
    noteController.dispose();
    super.onClose();
  }

  void updateValidationMode() {
    autoValidate = AutovalidateMode.onUserInteraction;
    update(['UPDATE_FORM']);
  }

  Future<void> updateDate(BuildContext context) async {
    final pickedDate = await showCustomDatePicker(context, datePicked);
    if (pickedDate != null) {
      datePicked = pickedDate;
      dateController.text = pickedDate.formattedDateRaw!;
    }
  }

  Future<void> updateTransaction(String customerId) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final amount = double.tryParse(amountController.text);
    if (amount != null) {
      final signedAmount = oldAmount >= 0 ? amount : -amount;
      final model = transaction.copyWith(
        amount: signedAmount,
        dateTime: datePicked,
        note: noteController.text.isEmpty ? null : noteController.text,
      );
      _isLoading(true);
      await TransactionProvider.update(customerId, model, oldAmount);
      _isLoading(false);
      Get.back();
    } else {
      showCustomSnackBar(message: "Invalid Amount", isError: true);
    }
  }
}
