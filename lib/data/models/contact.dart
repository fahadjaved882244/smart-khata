import 'dart:convert';

class ContactModel {
  final String name;
  final String? phone;
  ContactModel({
    required this.name,
    this.phone,
  });

  ContactModel copyWith({
    String? name,
    String? phone,
  }) {
    return ContactModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      name: map['name'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));

  @override
  String toString() => 'ContactModel(name: $name, phone: $phone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactModel && other.name == name && other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode;
}
