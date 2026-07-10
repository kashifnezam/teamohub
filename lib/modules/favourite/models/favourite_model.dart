import 'dart:convert';

class FavouriteModel {
  final String id;

  /// User who liked the product
  final String userId;

  /// Product
  final String productId;

  final DateTime createdAt;

  const FavouriteModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.createdAt,
  });

  FavouriteModel copyWith({
    String? id,
    String? userId,
    String? productId,
    DateTime? createdAt,
  }) {
    return FavouriteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory FavouriteModel.fromMap(Map<String, dynamic> map) {
    return FavouriteModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] ?? 0,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteModel.fromJson(String source) =>
      FavouriteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FavouriteModel(id: $id, productId: $productId)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FavouriteModel &&
              runtimeType == other.runtimeType &&
              other.id == id;

  @override
  int get hashCode => id.hashCode;
}