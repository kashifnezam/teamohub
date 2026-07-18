import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../app/utils/time-utils.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? photoUrl;

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
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photoUrl,
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
    String? photoUrl,
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
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
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

  /// Used when saving/updating Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'role': role,
      'country': country,
      'state': state,
      'city': city,
      'area': area,
      'address': address,
      'pincode': pincode,
      'isVerified': isVerified,
      'isBlocked': isBlocked,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// Create from Firestore DocumentSnapshot
  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data() ?? {};

    return UserModel(
      id: data['id'] ?? doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      photoUrl: data['photoUrl'],
      role: data['role'] ?? 'buyer',
      country: data['country'] ?? '',
      state: data['state'] ?? '',
      city: data['city'] ?? '',
      area: data['area'],
      address: data['address'],
      pincode: data['pincode'],
      isVerified: data['isVerified'] ?? false,
      isBlocked: data['isBlocked'] ?? false,
      createdAt: TimeUtils.parseDate(data['createdAt']),
      updatedAt: TimeUtils.parseDate(data['updatedAt']),
    );
  }

  /// Used for local JSON storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
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
    DateTime parse(dynamic value) {
      if (value == null) return DateTime.now();

      if (value is Timestamp) {
        return value.toDate();
      }

      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }

      if (value is String) {
        return DateTime.tryParse(value) ?? DateTime.now();
      }

      return DateTime.now();
    }

    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      photoUrl: map['photoUrl'],
      role: map['role'] ?? 'buyer',
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      area: map['area'],
      address: map['address'],
      pincode: map['pincode'],
      isVerified: map['isVerified'] ?? false,
      isBlocked: map['isBlocked'] ?? false,
      createdAt: parse(map['createdAt']),
      updatedAt: parse(map['updatedAt']),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}