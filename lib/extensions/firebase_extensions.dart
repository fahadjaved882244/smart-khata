import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirestoreX on FirebaseFirestore {
  DocumentReference<Map<String, dynamic>> get userDoc {
    final user = FirebaseAuth.instance.currentUser!;
    return collection('users').doc(user.uid);
  }

  CollectionReference<Map<String, dynamic>> get userCollection =>
      collection('users');
}

extension DocumentReferenceX on DocumentReference {}
