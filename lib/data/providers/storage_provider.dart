import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

class StorageProvider {
  static final FirebaseStorage _storgae = FirebaseStorage.instance;

  static Future<bool> upload(String filePath, File logo) async {
    try {
      final logoRef = _storgae.ref().child(filePath);
      await logoRef.putFile(logo);
      return true;
    } catch (e) {
      showCustomSnackBar(
          message: "Exception: Uploading File: $e", isError: true);
      return false;
    }
  }

  static Future<bool> delete(String filePath) async {
    try {
      final logoRef = _storgae.ref().child(filePath);
      await logoRef.delete();
      return true;
    } catch (e) {
      showCustomSnackBar(
          message: "Exception! Deleting File: $e", isError: true);
      return false;
    }
  }
}
