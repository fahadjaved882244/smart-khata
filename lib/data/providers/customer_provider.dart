import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/extensions/firebase_extensions.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

class CustomerProvider {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<CustomerModel>> watchAll() async* {
    final snapShots = _firestore.userDoc.customerCollection
        .orderBy("lastActivity", descending: true)
        .snapshots();
    yield* snapShots.map((snapshot) =>
        snapshot.docs.map((doc) => CustomerModel.fromMap(doc.data())).toList());
  }

  Future<List<CustomerModel>?> getAll() async {
    try {
      final snapShot = await _firestore.userDoc.customerCollection.get();
      final rawList = snapShot.docs;
      if (rawList.isNotEmpty) {
        return rawList.map((e) => CustomerModel.fromMap(e.data())).toList();
      }
    } catch (e) {
      showCustomSnackBar(message: "Get_All_Leads: exception : $e");
    }
    return null;
  }

  Future<bool> create(CustomerModel model) async {
    try {
      await _firestore.customerDoc(model.id).set(model.toMap());
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Create_Customer: exception : $e");
    }
    return false;
  }

  Future<CustomerModel?> read(String id) async {
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

  Future<bool> update(String id, Map<String, Object?> data) async {
    try {
      await _firestore.customerDoc(id).update(data);
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Update_Customer: exception : $e");
      return false;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await _firestore.customerDoc(id).delete();
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Delete_Customer: exception : $e");
      return false;
    }
  }
}
