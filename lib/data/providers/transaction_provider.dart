import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/extensions/firebase_extensions.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

class TransactionProvider {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<TransactionModel>> watchAll(String customerId) async* {
    final snapShots = _firestore
        .customerDoc(customerId)
        .transactionCollection
        .orderBy("dateTime", descending: true)
        .snapshots();
    yield* snapShots.map((snapshot) => snapshot.docs
        .map((doc) => TransactionModel.fromMap(doc.data()))
        .toList());
  }

  Future<List<TransactionModel>?> getAll(String customerId) async {
    try {
      final snapShot =
          await _firestore.customerDoc(customerId).transactionCollection.get();
      final rawList = snapShot.docs;
      if (rawList.isNotEmpty) {
        return rawList.map((e) => TransactionModel.fromMap(e.data())).toList();
      }
    } catch (e) {
      showCustomSnackBar(message: "Get_All_Transaction: exception : $e");
    }
    return null;
  }

  Future<bool> create(String customerId, TransactionModel model) async {
    try {
      await _firestore.transactionDoc(customerId, model.id).set(model.toMap());
      await _firestore.customerDoc(customerId).update({
        'lastActivity': Timestamp.fromDate(model.dateTime),
        'credit': FieldValue.increment(model.amount),
      });
      if (model.amount.isNegative) {
        await _firestore.userDoc
            .update({'gave': FieldValue.increment(model.amount.abs())});
      } else {
        await _firestore.userDoc
            .update({'got': FieldValue.increment(model.amount.abs())});
      }
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Create_Transaction: exception : $e");
    }
    return false;
  }

  Future<TransactionModel?> read(String customerId, String transId) async {
    try {
      final snapShot =
          await _firestore.transactionDoc(customerId, transId).get();
      if (snapShot.data() != null) {
        return TransactionModel.fromMap(snapShot.data()!);
      }
    } catch (e) {
      showCustomSnackBar(message: "Read_Transaction: exception : $e");
    }
    return null;
  }

  Future<bool> update(
      String customerId, String transId, Map<String, Object?> data) async {
    try {
      await _firestore.transactionDoc(customerId, transId).update(data);
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Update_Transaction: exception : $e");
      return false;
    }
  }

  Future<bool> delete(String customerId, String transId) async {
    try {
      await _firestore.transactionDoc(customerId, transId).delete();
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Delete_Transaction: exception : $e");
      return false;
    }
  }
}
