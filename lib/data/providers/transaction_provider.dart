import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:khata/data/models/transaction.dart';
import 'package:khata/extensions/firebase_extensions.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';

List<TransactionModel> parseRawList(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> rawList) {
  return rawList.map((e) => TransactionModel.fromMap(e.data())).toList();
}

Stream<List<TransactionModel>> parseRawStream(
    Stream<QuerySnapshot<Map<String, dynamic>>> rawStream) {
  return rawStream.map((snapshot) => snapshot.docs
      .map((doc) => TransactionModel.fromMap(doc.data()))
      .toList());
}

class TransactionProvider {
  static final _firestore = FirebaseFirestore.instance;

  static Stream<List<TransactionModel>> watchAll(
    String businessId,
    String customerId,
  ) async* {
    final rawStream = _firestore
        .customerDoc(businessId, customerId)
        .transactionCollection
        .orderBy("dateTime", descending: false)
        .snapshots();
    yield* await compute(parseRawStream, rawStream);
  }

  static Future<List<TransactionModel>?> getAll(
      String businessId, String customerId) async {
    try {
      return _firestore
          .customerDoc(businessId, customerId)
          .transactionCollection
          .get()
          .then((value) => compute(parseRawList, value.docs));
    } catch (e) {
      showCustomSnackBar(message: "Get_All_Transaction: exception : $e");
    }
    return null;
  }

  static Future<bool> create(
    String businessId,
    String customerId,
    TransactionModel model,
  ) async {
    try {
      await _firestore
          .transactionDoc(businessId, customerId, model.id)
          .set(model.toMap());
      await _firestore.customerDoc(businessId, customerId).update({
        'lastActivity': Timestamp.fromDate(model.dateTime),
        'credit': FieldValue.increment(model.amount),
      });
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Create_Transaction: exception : $e");
    }
    return false;
  }

  static Future<TransactionModel?> read(
    String businessId,
    String customerId,
    String transId,
  ) async {
    try {
      final snapShot = await _firestore
          .transactionDoc(businessId, customerId, transId)
          .get();
      if (snapShot.data() != null) {
        return TransactionModel.fromMap(snapShot.data()!);
      }
    } catch (e) {
      showCustomSnackBar(message: "Read_Transaction: exception : $e");
    }
    return null;
  }

  static Future<bool> update(
    String businessId,
    String customerId,
    String transactionId,
    Map<String, dynamic> map,
    double newAmount,
    double oldAmount,
  ) async {
    try {
      await _firestore
          .transactionDoc(businessId, customerId, transactionId)
          .update(map);
      await _firestore.customerDoc(businessId, customerId).update({
        'credit': FieldValue.increment(newAmount - oldAmount),
      });
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Update_Transaction: exception : $e");
      return false;
    }
  }

  static Future<bool> clear(
    String businessId,
    String customerId,
    TransactionModel oldModel,
  ) async {
    try {
      await _firestore
          .transactionDoc(businessId, customerId, oldModel.id)
          .update({"clear": true});
      final newModel = TransactionModel.fromClearAmount(oldModel.amount);
      await create(businessId, customerId, newModel);
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Clear_Transaction: exception : $e");
      return false;
    }
  }

  static Future<bool> delete(
    String businessId,
    String customerId,
    String transId,
    double oldAmount,
  ) async {
    try {
      await _firestore.transactionDoc(businessId, customerId, transId).delete();
      await _firestore.customerDoc(businessId, customerId).update({
        'credit': FieldValue.increment(-oldAmount),
      });
      return true;
    } catch (e) {
      showCustomSnackBar(message: "Delete_Transaction: exception : $e");
      return false;
    }
  }
}
