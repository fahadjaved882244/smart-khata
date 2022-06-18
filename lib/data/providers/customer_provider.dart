import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/extensions/firebase_extensions.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

List<CustomerModel> parseRawList(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> rawList) {
  return rawList.map((e) => CustomerModel.fromMap(e.data())).toList();
}

Stream<List<CustomerModel>> parseRawStream(
    Stream<QuerySnapshot<Map<String, dynamic>>> rawStream) {
  return rawStream.map((snapshot) =>
      snapshot.docs.map((doc) => CustomerModel.fromMap(doc.data())).toList());
}

class CustomerProvider {
  static final _firestore = FirebaseFirestore.instance;

  static Stream<List<CustomerModel>> watchAll() async* {
    final rawStream = _firestore.userDoc.customerCollection
        .orderBy("lastActivity", descending: true)
        .snapshots();
    yield* parseRawStream(rawStream);
  }

  static Future<List<CustomerModel>?> getAll() async {
    try {
      return _firestore.userDoc.customerCollection
          .get()
          .then((value) => parseRawList(value.docs));
    } catch (e) {
      showCustomSnackBar(message: "Get_All_Leads: exception : $e");
    }
    return null;
  }

  static Future<bool> create(CustomerModel model) async {
    try {
      await _firestore.customerDoc(model.id).set(model.toMap());
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Create_Customer: exception : $e");
    }
    return false;
  }

  static Future<CustomerModel?> read(String id) async {
    try {
      final snapShot = await _firestore.customerDoc(id).get();
      if (snapShot.data() != null) {
        return CustomerModel.fromMap(snapShot.data()!);
      }
    } catch (e) {
      showCustomSnackBar(message: "Get_Customer: exception : $e");
    }
    return null;
  }

  static Future<bool> update(String id, Map<String, Object?> data) async {
    try {
      await _firestore.customerDoc(id).update(data);
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Update_Customer: exception : $e");
      return false;
    }
  }

  static Future<bool> delete(String id) async {
    try {
      await _firestore.customerDoc(id).delete();
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Delete_Customer: exception : $e");
      return false;
    }
  }
}
