import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khata/extensions/firebase_extensions.dart';
import 'package:khata/data/models/user.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

class UserProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<UserModel>> watchAll() async* {}

  Future<List<UserModel>?> getAll() async {
    return null;
  }

  Future<bool> create(UserModel userModel) async {
    try {
      await _firestore.userCollection.doc(userModel.id).set(userModel.toMap());
      return true;
    } on Exception catch (e) {
      showCustomSnackBar(message: "Create_User: $e", isError: true);
      return false;
    }
  }

  Future<UserModel?> read(String uid) async {
    try {
      final doc = await _firestore.userCollection.doc(uid).get();
      if (doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      }
    } on Exception catch (e) {
      showCustomSnackBar(message: "Read_User: $e", isError: true);
    }
    return null;
  }

  Future<bool> update(String id, Map<String, Object?> data) async {
    try {
      await _firestore.userCollection.doc(id).update(data);
      return true;
    } on Exception catch (e) {
      showCustomSnackBar(message: "Update_User: $e", isError: true);
      return false;
    }
  }

  Future<bool> delete(String uid) async {
    try {
      await _firestore.userCollection.doc(uid).delete();
      return true;
    } on Exception catch (e) {
      showCustomSnackBar(message: "Delete_User: $e", isError: true);
      return false;
    }
  }
}
