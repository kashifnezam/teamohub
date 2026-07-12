import 'dart:convert';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String? photo;

  /// buyer | seller | agent | admin
  final String role;

  final String country;
  final String state;
  final String city;
  final String? area;
  final String? address;
  final String? pincode;

  final bool isVerified;
  final bool isBlocked;

  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.photo,
    required this.role,
    required this.country,
    required this.state,
    required this.city,
    this.area,
    this.address,
    this.pincode,
    this.isVerified = false,
    this.isBlocked = false,
    required this.createdAt,
    required this.updatedAt,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photo,
    String? role,
    String? country,
    String? state,
    String? city,
    String? area,
    String? address,
    String? pincode,
    bool? isVerified,
    bool? isBlocked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: id ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      role: role ?? this.role,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      area: area ?? this.area,
      address: address ?? this.address,
      pincode: pincode ?? this.pincode,
      isVerified: isVerified ?? this.isVerified,
      isBlocked: isBlocked ?? this.isBlocked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'role': role,
      'country': country,
      'state': state,
      'city': city,
      'area': area,
      'address': address,
      'pincode': pincode,
      'isVerified': isVerified,
      'isBlocked': isBlocked,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      photo: map['photo'],
      role: map['role'] ?? 'buyer',
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      area: map['area'],
      address: map['address'],
      pincode: map['pincode'],
      isVerified: map['isVerified'] ?? false,
      isBlocked: map['isBlocked'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] ?? 0,
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'] ?? 0,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $uid, name: $name, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is UserModel &&
            runtimeType == other.runtimeType &&
            other.uid == uid;
  }

  @override
  int get hashCode => uid.hashCode;
}