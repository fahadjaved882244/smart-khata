import 'dart:convert';

class UserModel {
  final String id;
  final String? name;
  final String phoneNumber;
  final String? photoUrl;
  final double gave;
  final double got;
  UserModel({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.photoUrl,
    this.gave = 0,
    this.got = 0,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? photoUrl,
    double? gave,
    double? got,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      gave: gave ?? this.gave,
      got: got ?? this.got,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'gave': gave,
      'got': got,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      photoUrl: map['photoUrl'],
      gave: map['gave']?.toDouble() ?? 0.0,
      got: map['got']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, phoneNumber: $phoneNumber, photoUrl: $photoUrl, gave: $gave, got: $got)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.photoUrl == photoUrl &&
        other.gave == gave &&
        other.got == got;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        photoUrl.hashCode ^
        gave.hashCode ^
        got.hashCode;
  }
}
