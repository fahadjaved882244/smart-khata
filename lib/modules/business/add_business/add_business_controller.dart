import 'dart:typed_data';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khata/data/models/business.dart';
import 'package:khata/data/providers/business_provider.dart';
import 'package:khata/data/providers/storage_provider.dart';
import 'package:khata/modules/components/controllers/i_base_controller.dart';
import 'package:khata/modules/components/popups/custom_option_dialog.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';
import 'package:uuid/uuid.dart';

import 'package:khata/extensions/string_extensions.dart';
import 'package:khata/routes/route_names.dart';

class AddBusinessController extends IBaseController {
  late final TextEditingController nameController;
  late final TextEditingController typeController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  final ImagePicker _picker = ImagePicker();
  bool isImageLoading = false;
  XFile? _pickedImage;
  Uint8List? pickedImageData;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    typeController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    typeController.dispose();
    super.onClose();
  }

  void updateValidationMode() {
    autoValidate = AutovalidateMode.onUserInteraction;
    update(['UPDATE_FORM']);
  }

  Future<int> pickImage(BuildContext context) async {
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
        imageQuality: 15,
      );
    } else if (result == 1) {
      image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 15,
      );
    }
    if (image != null) {
      _pickedImage = image;
      pickedImageData = await image.readAsBytes();
    }

    isImageLoading = false;
    update(["UPDATE_IMAGE"]);
    return result;
  }

  void removeImage() {
    _pickedImage = null;
    pickedImageData = null;
    update(['UPDATE_IMAGE']);
  }

  Future<void> addBusiness() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final uid = const Uuid().v1();
    final imagePath = _pickedImage != null
        ? '${user.id}/$uid/logo/${_pickedImage!.name}'
        : null;

    final model = BusinessModel(
      id: uid,
      dateTime: DateTime.now(),
      name: nameController.text.trim().capFirst,
      type: typeController.text.nullIfEmpty,
      photoUrl: imagePath,
    );

    isLoading = true;
    bool? uploaded;
    if (imagePath != null) {
      uploaded = await StorageProvider.upload(
        imagePath,
        io.File(_pickedImage!.path),
      );
    }
    final status = await BusinessProvider.create(model);
    await GetStorage().write('businessId', uid);
    if (status && uploaded != null && !uploaded) {
      await BusinessProvider.update(uid, {'photoUrl': null});
      showCustomSnackBar(
        message: "Try again, can't upload business logo!",
        isError: true,
      );
    } else if (!status && uploaded != null && uploaded) {
      await StorageProvider.delete(imagePath!);
    }
    isLoading = false;

    if (status) {
      Get.offAllNamed(
        RouteNames.customerListView,
        parameters: {'businessId': uid},
      );
    }
  }
}
