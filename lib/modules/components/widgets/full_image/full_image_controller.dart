import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:khata/modules/components/controllers/i_base_controller.dart';

class FullImageController extends IBaseController {
  final String? photoUrl;
  FullImageController(this.photoUrl);

  Uint8List? imageData;

  @override
  void onInit() {
    super.onInit();
    loadImage();
  }

  Future<void> loadImage() async {
    if (photoUrl != null) {
      isLoading = true;
      imageData =
          await FirebaseStorage.instance.ref().child(photoUrl!).getData();
      isLoading = false;
    }
  }
}
