import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final double amount;
  final DateTime dateTime;
  final String? note;
  final String? photoUrl;
  TransactionModel({
    required this.id,
    required this.amount,
    required this.dateTime,
    this.note,
    this.photoUrl,
  });

  TransactionModel copyWith({
    String? id,
    double? amount,
    DateTime? dateTime,
    String? note,
    String? photoUrl,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
      note: note ?? this.note,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'dateTime': Timestamp.fromDate(dateTime),
      'note': note,
      'photoUrl': photoUrl,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: map['amount']?.toDouble() ?? 0.0,
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      note: map['note'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(id: $id, amount: $amount, dateTime: $dateTime, note: $note, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.id == id &&
        other.amount == amount &&
        other.dateTime == dateTime &&
        other.note == note &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        dateTime.hashCode ^
        note.hashCode ^
        photoUrl.hashCode;
  }
}
