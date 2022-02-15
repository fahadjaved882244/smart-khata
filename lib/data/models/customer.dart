import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String name;
  final double credit;
  final String? phoneNumber;
  final String? photoUrl;
  final DateTime? lastActivity;
  CustomerModel({
    required this.name,
    required this.credit,
    this.phoneNumber,
    this.photoUrl,
    this.lastActivity,
  });

  CustomerModel copyWith({
    String? name,
    String? phoneNumber,
    double? credit,
    String? photoUrl,
    DateTime? lastActivity,
  }) {
    return CustomerModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      credit: credit ?? this.credit,
      photoUrl: photoUrl ?? this.photoUrl,
      lastActivity: lastActivity ?? this.lastActivity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'credit': credit,
      'photoUrl': photoUrl,
      'lastActivity':
          lastActivity != null ? Timestamp.fromDate(lastActivity!) : null,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      credit: map['credit']?.toDouble() ?? 0.0,
      photoUrl: map['photoUrl'],
      lastActivity: map['lastActivity'] != null
          ? (map['lastActivity'] as Timestamp).toDate()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerModel(name: $name, phoneNumber: $phoneNumber, credit: $credit, photoUrl: $photoUrl, lastActivity: $lastActivity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerModel &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.credit == credit &&
        other.photoUrl == photoUrl &&
        other.lastActivity == lastActivity;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phoneNumber.hashCode ^
        credit.hashCode ^
        photoUrl.hashCode ^
        lastActivity.hashCode;
  }
}
