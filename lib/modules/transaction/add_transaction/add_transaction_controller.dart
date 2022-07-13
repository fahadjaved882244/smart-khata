import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/data/providers/storage_provider.dart';
import 'package:khata/data/providers/transaction_provider.dart';
import 'package:khata/extensions/date_time_extensions.dart';
import 'package:khata/modules/components/controllers/i_base_controller.dart';
import 'package:khata/modules/components/popups/custom_date_picker.dart';
import 'package:khata/modules/components/popups/custom_option_dialog.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';
import 'package:uuid/uuid.dart';

class AddTransactionController extends IBaseController {
  DateTime datePicked = DateTime.now();

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
    amountController = TextEditingController();
    dateController = TextEditingController(text: datePicked.formattedDateRaw);
    noteController = TextEditingController();
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

  Future<void> addTransaction(
      String businessId, String customerId, bool willAdd) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final uid = const Uuid().v1();
    final imagePath = _pickedImage != null
        ? '${user.id}/$businessId/$customerId/$uid/${_pickedImage!.name}'
        : null;
    final amount = double.tryParse(amountController.text);
    if (amount != null) {
      final signedAmount = willAdd ? amount : amount * -1;
      final model = TransactionModel(
        id: uid,
        amount: signedAmount,
        dateTime: datePicked,
        clear: false,
        photoUrl: imagePath,
        note: noteController.text.isEmpty ? null : noteController.text,
      );
      isLoading = true;
      bool? uploaded;
      if (imagePath != null) {
        uploaded = await StorageProvider.upload(
          imagePath,
          io.File(_pickedImage!.path),
        );
      }
      final result = await TransactionProvider.create(
        businessId,
        customerId,
        model,
      );
      if (result && uploaded != null && !uploaded) {
        await TransactionProvider.delete(
          businessId,
          customerId,
          uid,
          signedAmount,
        );
      } else if (!result && uploaded != null && uploaded) {
        await StorageProvider.delete(imagePath!);
      }
      isLoading = false;
      Get.back();
    } else {
      showCustomSnackBar(message: "Invalid Amount", isError: true);
    }
  }
}
