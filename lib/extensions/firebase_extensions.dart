import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirestoreX on FirebaseFirestore {
  DocumentReference<Map<String, dynamic>> get userDoc {
    final user = FirebaseAuth.instance.currentUser!;
    return collection('users').doc(user.uid);
  }

  CollectionReference<Map<String, dynamic>> get userCollection =>
      collection('users');

  DocumentReference<Map<String, dynamic>> customerDoc(id) {
    return userDoc.customerCollection.doc(id);
  }

  DocumentReference<Map<String, dynamic>> transactionDoc(
      String customerId, String transactionId) {
    return customerDoc(customerId).transactionCollection.doc(transactionId);
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference<Map<String, dynamic>> get customerCollection =>
      collection('customers');
  CollectionReference<Map<String, dynamic>> get transactionCollection =>
      collection('transactions');
}
