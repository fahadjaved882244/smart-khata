import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khata/data/models/business.dart';
import 'package:khata/extensions/firebase_extensions.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

List<BusinessModel> parseRawList(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> rawList) {
  return rawList.map((e) => BusinessModel.fromMap(e.data())).toList();
}

Stream<List<BusinessModel>> parseRawStream(
    Stream<QuerySnapshot<Map<String, dynamic>>> rawStream) {
  return rawStream.map((snapshot) =>
      snapshot.docs.map((doc) => BusinessModel.fromMap(doc.data())).toList());
}

class BusinessProvider {
  static final _firestore = FirebaseFirestore.instance;

  static Stream<List<BusinessModel>> watchAll() async* {
    final rawStream =
        _firestore.userDoc.businessCollection.orderBy("dateTime").snapshots();
    yield* parseRawStream(rawStream);
  }

  static Future<List<BusinessModel>?> getAll() async {
    try {
      return _firestore.userDoc.businessCollection
          .get()
          .then((value) => parseRawList(value.docs));
    } catch (e) {
      showCustomSnackBar(message: "Get_All_Businesses: exception : $e");
    }
    return null;
  }

  static Future<bool> create(BusinessModel model) async {
    try {
      await _firestore.businessDoc(model.id).set(model.toMap());
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Create_Business: exception : $e");
    }
    return false;
  }

  static Future<BusinessModel?> read(String id) async {
    try {
      final snapShot = await _firestore.businessDoc(id).get();
      if (snapShot.data() != null) {
        return BusinessModel.fromMap(snapShot.data()!);
      }
    } catch (e) {
      showCustomSnackBar(message: "Get_Business: exception : $e");
    }
    return null;
  }

  static Future<bool> update(String id, Map<String, Object?> data) async {
    try {
      await _firestore.businessDoc(id).update(data);
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Update_Business: exception : $e");
      return false;
    }
  }

  static Future<bool> delete(String id) async {
    try {
      await _firestore.businessDoc(id).delete();
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Delete_Business: exception : $e");
      return false;
    }
  }
}
