import 'dart:io' as io;
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/data/providers/storage_provider.dart';
import 'package:khata/data/providers/transaction_provider.dart';
import 'package:khata/modules/components/controllers/i_base_controller.dart';
import 'package:khata/modules/components/popups/custom_date_picker.dart';
import 'package:khata/modules/components/popups/custom_option_dialog.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';
import 'package:khata/extensions/date_time_extensions.dart';

class UpdateTransactionController extends IBaseController {
  final String businessId;
  final String customerId;
  final TransactionModel transaction;
  UpdateTransactionController(
      this.businessId, this.customerId, this.transaction);

  late final double oldAmount;
  late DateTime datePicked;

  late final TextEditingController amountController;
  late final TextEditingController dateController;
  late final TextEditingController noteController;

  final ImagePicker _picker = ImagePicker();
  bool isImageLoading = false;
  XFile? _pickedImage;
  Uint8List? pickedImageData;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  @override
  onInit() {
    super.onInit();
    oldAmount = transaction.amount;
    datePicked = transaction.dateTime;
    amountController =
        TextEditingController(text: transaction.amount.abs().toString());
    dateController = TextEditingController(text: datePicked.formattedDateRaw);
    noteController = TextEditingController(text: transaction.note);
  }

  @override
  void onReady() async {
    super.onReady();
    await loadImage();
  }

  @override
  onClose() {
    amountController.dispose();
    dateController.dispose();
    noteController.dispose();
    super.onClose();
  }

  Future<void> loadImage() async {
    if (transaction.photoUrl != null) {
      isImageLoading = true;
      update(["UPDATE_IMAGE"]);
      pickedImageData = await FirebaseStorage.instance
          .ref()
          .child(transaction.photoUrl!)
          .getData();
      if (pickedImageData != null) {
        _pickedImage = XFile.fromData(pickedImageData!);
      }
      isImageLoading = false;
      update(["UPDATE_IMAGE"]);
    }
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

  Future<void> pickImage(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final result = await showCustomOptionDialog(
      context: context,
      title: "Image Source?",
      options: {0: "Camera", 1: "Gallery"},
      initialValue: 0,
    );
    isImageLoading = true;
    update(["UPDATE_IMAGE"]);

    XFile? image;
    if (result == 0) {
      image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
    } else if (result == 1) {
      image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 10,
      );
    }
    if (image != null) {
      _pickedImage = image;
      pickedImageData = await image.readAsBytes();
    }
    isImageLoading = false;
    update(["UPDATE_IMAGE"]);
  }

  void removeImage() {
    _pickedImage = null;
    pickedImageData = null;
    update(['UPDATE_IMAGE']);
  }

  Future<void> deleteTransaction() async {
    isLoading = true;
    if (transaction.photoUrl != null) {
      await StorageProvider.delete(transaction.photoUrl!);
    }
    await TransactionProvider.delete(
      businessId,
      customerId,
      transaction.id,
      transaction.amount,
    );
    Get.back();
    isLoading = false;
  }

  Future<void> clearTransaction() async {
    isLoading = true;
    await TransactionProvider.clear(businessId, customerId, transaction);
    if (transaction.photoUrl != null) {
      await StorageProvider.delete(transaction.photoUrl!);
    }
    Get.back();
    isLoading = false;
  }

  String? getImagePath() {
    if (_pickedImage != null && _pickedImage!.name.isEmpty) {
      return transaction.photoUrl;
    } else if (_pickedImage != null) {
      return '${user.id}/$businessId/$customerId/${transaction.id}/${_pickedImage!.name}';
    } else {
      return null;
    }
  }

  Future<void> updateTransaction(String customerId) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final imagePath = getImagePath();
    final amount = double.tryParse(amountController.text);
    if (amount != null) {
      final signedAmount = oldAmount >= 0 ? amount : -amount;
      final map = {
        'amount': signedAmount,
        'dateTime': datePicked,
        'note': noteController.text.isEmpty ? null : noteController.text,
        'photoUrl': imagePath,
      };
      isLoading = true;
      if (transaction.photoUrl != null &&
          (_pickedImage == null || transaction.photoUrl != imagePath)) {
        await StorageProvider.delete(transaction.photoUrl!);
      }
      if (_pickedImage != null && imagePath != transaction.photoUrl) {
        await StorageProvider.upload(imagePath!, io.File(_pickedImage!.path));
      }
      await TransactionProvider.update(
        businessId,
        customerId,
        transaction.id,
        map,
        signedAmount,
        oldAmount,
      );
      isLoading = false;
      Get.back();
    } else {
      showCustomSnackBar(message: "Invalid Amount", isError: true);
    }
  }
}
