import 'dart:convert';

class SubCategoryModel {
  final String id;

  /// Parent Category ID
  final String categoryId;

  final String name;
  final String image;

  /// Display order
  final int order;

  /// Optional UI Color
  final String? color;

  /// Featured on Home
  final bool isFeatured;

  /// Hide/Show
  final bool isActive;

  final DateTime createdAt;
  final DateTime updatedAt;

  const SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.order,
    this.color,
    this.isFeatured = false,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  SubCategoryModel copyWith({
    String? id,
    String? categoryId,
    String? name,
    String? image,
    int? order,
    String? color,
    bool? isFeatured,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubCategoryModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      image: image ?? this.image,
      order: order ?? this.order,
      color: color ?? this.color,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'image': image,
      'order': order,
      'color': color,
      'isFeatured': isFeatured,
      'isActive': isActive,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: map['id'] ?? '',
      categoryId: map['categoryId'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      order: map['order'] ?? 0,
      color: map['color'],
      isFeatured: map['isFeatured'] ?? false,
      isActive: map['isActive'] ?? true,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] ?? 0,
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'] ?? 0,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategoryModel.fromJson(String source) =>
      SubCategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubCategoryModel(id: $id, categoryId: $categoryId, name: $name)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SubCategoryModel &&
              runtimeType == other.runtimeType &&
              other.id == id;

  @override
  int get hashCode => id.hashCode;
}