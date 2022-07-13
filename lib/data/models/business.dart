import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessModel {
  final String id;
  final String name;
  final DateTime dateTime;
  final String? type;
  final String? photoUrl;
  BusinessModel({
    required this.id,
    required this.name,
    required this.dateTime,
    this.type,
    this.photoUrl,
  });

  BusinessModel copyWith({
    String? id,
    String? name,
    DateTime? dateTime,
    String? type,
    String? photoUrl,
  }) {
    return BusinessModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dateTime': Timestamp.fromDate(dateTime),
      'type': type,
      'photoUrl': photoUrl,
    };
  }

  factory BusinessModel.fromMap(Map<String, dynamic> map) {
    return BusinessModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      type: map['type'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessModel.fromJson(String source) =>
      BusinessModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusinessModel(id: $id, name: $name, dateTime: $dateTime, type: $type, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusinessModel &&
        other.id == id &&
        other.name == name &&
        other.dateTime == dateTime &&
        other.type == type &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        dateTime.hashCode ^
        type.hashCode ^
        photoUrl.hashCode;
  }
}
