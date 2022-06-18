import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class TransactionModel {
  final String id;
  final double amount;
  final DateTime dateTime;
  final bool clear;
  final String? note;
  final String? photoUrl;
  TransactionModel({
    required this.id,
    required this.amount,
    required this.dateTime,
    required this.clear,
    this.note,
    this.photoUrl,
  });

  TransactionModel copyWith({
    String? id,
    double? amount,
    DateTime? dateTime,
    bool? clear,
    String? note,
    String? photoUrl,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
      clear: clear ?? this.clear,
      note: note ?? this.note,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'dateTime': Timestamp.fromDate(dateTime),
      'clear': clear,
      'note': note,
      'photoUrl': photoUrl,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: map['amount']?.toDouble() ?? 0.0,
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      clear: map['clear'] ?? false,
      note: map['note'],
      photoUrl: map['photoUrl'],
    );
  }

  factory TransactionModel.fromClearAmount(double amount) {
    return TransactionModel(
      id: const Uuid().v1(),
      amount: amount * -1,
      dateTime: DateTime.now(),
      clear: true,
      note: "Cleared of $amount",
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(id: $id, amount: $amount, dateTime: $dateTime, clear: $clear, note: $note, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.id == id &&
        other.amount == amount &&
        other.dateTime == dateTime &&
        other.clear == clear &&
        other.note == note &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        dateTime.hashCode ^
        clear.hashCode ^
        note.hashCode ^
        photoUrl.hashCode;
  }
}
