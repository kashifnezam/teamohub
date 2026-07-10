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

  /// Hide/Show category
  final bool isActive;

  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.image,
    required this.order,
    this.color,
    this.isFeatured = false,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
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
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
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


final now = DateTime.now();

final List<CategoryModel> categories = [
  CategoryModel(
    id: "1",
    title: "Cars",
    image: "assets/categories/car.png",
    order: 1,
    color: "#EF4444",
    isFeatured: true,
    createdAt: now,
    updatedAt: now,
  ),
  CategoryModel(
    id: "2",
    title: "Mobiles",
    image: "assets/categories/mobile.png",
    order: 2,
    color: "#3B82F6",
    isFeatured: true,
    createdAt: now,
    updatedAt: now,
  ),
  CategoryModel(
    id: "3",
    title: "Property",
    image: "assets/categories/property.png",
    order: 3,
    color: "#10B981",
    isFeatured: true,
    createdAt: now,
    updatedAt: now,
  ),
  CategoryModel(
    id: "4",
    title: "Fashion",
    image: "assets/categories/fashion.png",
    order: 4,
    color: "#EC4899",
    createdAt: now,
    updatedAt: now,
  ),
  CategoryModel(
    id: "5",
    title: "Jobs",
    image: "assets/categories/jobs.png",
    order: 5,
    color: "#F59E0B",
    createdAt: now,
    updatedAt: now,
  ),
  CategoryModel(
    id: "6",
    title: "Bikes",
    image: "assets/categories/bikes.png",
    order: 6,
    color: "#6366F1",
    createdAt: now,
    updatedAt: now,
  ),
  CategoryModel(
    id: "7",
    title: "Furniture",
    image: "assets/categories/furniture.png",
    order: 7,
    color: "#8B5CF6",
    createdAt: now,
    updatedAt: now,
  ),
  CategoryModel(
    id: "8",
    title: "Services",
    image: "assets/categories/service.png",
    order: 8,
    color: "#06B6D4",
    createdAt: now,
    updatedAt: now,
  ),
  CategoryModel(
    id: "9",
    title: "Electronics",
    image: "assets/categories/electronics.png",
    order: 9,
    color: "#14B8A6",
    createdAt: now,
    updatedAt: now,
  ),

  CategoryModel(
    id: "11",
    title: "Pets",
    image: "assets/categories/pets.png",
    order: 11,
    color: "#A855F7",
    createdAt: now,
    updatedAt: now,
  ),
];