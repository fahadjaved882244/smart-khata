import 'dart:io' as io;
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khata/data/models/business.dart';
import 'package:khata/data/providers/business_provider.dart';
import 'package:khata/data/providers/storage_provider.dart';
import 'package:khata/modules/components/controllers/i_base_controller.dart';
import 'package:khata/modules/components/popups/custom_option_dialog.dart';
import 'package:khata/extensions/string_extensions.dart';

class UpdateBusinessController extends IBaseController {
  final BusinessModel business;
  UpdateBusinessController(this.business);

  late final TextEditingController nameController;
  late final TextEditingController typeController;

  final ImagePicker _picker = ImagePicker();
  bool isImageLoading = false;
  XFile? _pickedImage;
  Uint8List? pickedImageData;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  @override
  onInit() {
    super.onInit();
    nameController = TextEditingController(text: business.name);
    typeController = TextEditingController(text: business.type);
  }

  @override
  void onReady() async {
    super.onReady();
    await loadImage();
  }

  @override
  onClose() {
    nameController.dispose();
    typeController.dispose();
    super.onClose();
  }

  Future<void> loadImage() async {
    if (business.photoUrl != null) {
      isImageLoading = true;
      update(["UPDATE_IMAGE"]);
      pickedImageData = await FirebaseStorage.instance
          .ref()
          .child(business.photoUrl!)
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

  Future<void> deleteBusiness() async {
    isLoading = true;
    if (business.photoUrl != null) {
      await StorageProvider.delete(business.photoUrl!);
    }
    await BusinessProvider.delete(business.id);
    Get.back();
    isLoading = false;
  }

  String? getImagePath() {
    if (_pickedImage != null && _pickedImage!.name.isEmpty) {
      return business.photoUrl;
    } else if (_pickedImage != null) {
      return '${user.id}/${business.id}/logo/${_pickedImage!.name}';
    } else {
      return null;
    }
  }

  Future<void> updateBusiness() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final imagePath = getImagePath();

    final map = {
      'name': nameController.text.trim(),
      'type': typeController.text.nullIfEmpty,
      'photoUrl': imagePath,
    };

    isLoading = true;
    if (business.photoUrl != null &&
        (_pickedImage == null || business.photoUrl != imagePath)) {
      await StorageProvider.delete(business.photoUrl!);
    }
    if (_pickedImage != null && imagePath != business.photoUrl) {
      await StorageProvider.upload(imagePath!, io.File(_pickedImage!.path));
    }
    await BusinessProvider.update(business.id, map);
    isLoading = false;
    Get.back();
  }
}
