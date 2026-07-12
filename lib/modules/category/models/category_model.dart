import 'dart:convert';

class CategoryModel {
  final String id;
  final String title;
  final String image;

  /// Display order
  final int order;

  /// Optional color for UI (Hex Color)
  /// Example: #4F46E5
  final String? color;

  /// Featured category on Home
  final bool isFeatured;

  final bool hasSubCategories;

  /// Hide/Show category
  final bool isActive;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.image,
    required this.order,
    this.color,
    this.isFeatured = false,
    this.isActive = true,
    this.hasSubCategories = false,
    this.createdAt = null,
    this.updatedAt = null,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? image,
    int? order,
    String? color,
    bool? isFeatured,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      title: name ?? this.title,
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
      'name': title,
      'image': image,
      'order': order,
      'color': color,
      'isFeatured': isFeatured,
      'isActive': isActive,
      'createdAt': createdAt?.millisecondsSinceEpoch ?? null,
      'updatedAt': updatedAt?.millisecondsSinceEpoch ?? null,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      title: map['name'] ?? '',
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

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $title)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryModel &&
              runtimeType == other.runtimeType &&
              other.id == id;

  @override
  int get hashCode => id.hashCode;
}