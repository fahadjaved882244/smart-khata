import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/modules/components/controllers/i_base_controller.dart';

class TransactionThumbnailController extends IBaseController {
  final TransactionModel _transaction;
  TransactionThumbnailController(this._transaction);

  Uint8List? imageData;

  @override
  void onInit() {
    super.onInit();
    loadImage();
  }

  Future<void> loadImage() async {
    if (_transaction.photoUrl != null) {
      isLoading = true;
      imageData = await FirebaseStorage.instance
          .ref()
          .child(_transaction.photoUrl!)
          .getData();
      isLoading = false;
    }
  }
}
