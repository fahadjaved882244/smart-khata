import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

extension FirestoreX on FirebaseFirestore {
  DocumentReference<Map<String, dynamic>> get userDoc {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return collection('users').doc(user.uid);
    } else {
      throw UnauthorizedException();
    }
  }

  CollectionReference<Map<String, dynamic>> get userCollection =>
      collection('users');

  DocumentReference<Map<String, dynamic>> businessDoc(String businessId) =>
      userDoc.businessCollection.doc(businessId);

  DocumentReference<Map<String, dynamic>> customerDoc(
          String businessId, String customerId) =>
      businessDoc(businessId).customerCollection.doc(customerId);

  DocumentReference<Map<String, dynamic>> transactionDoc(
          String businessId, String customerId, String transactionId) =>
      customerDoc(businessId, customerId)
          .transactionCollection
          .doc(transactionId);
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference<Map<String, dynamic>> get businessCollection =>
      collection('businesses');
  CollectionReference<Map<String, dynamic>> get customerCollection =>
      collection('customers');
  CollectionReference<Map<String, dynamic>> get transactionCollection =>
      collection('transactions');
}
