class PostModel {
  final String id;
  final String userId;

  /// sell / buy
  final String type;

  final String categoryId;
  final String subCategoryId;

  final String title;
  final String description;

  final double price;
  final bool negotiable;

  /// New, Like New, Good, Fair
  final String condition;

  final List<String> images;

  final String city;
  final String area;

  /// active, sold, pending
  final String status;

  final int views;
  final int likes;

  final String? agentId;

  // Highlight Badges
  final bool isNew;
  final bool isFeatured;
  final bool isVerified;
  final bool isUrgent;

  final DateTime createdAt;
  final DateTime updatedAt;

  const PostModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.categoryId,
    required this.subCategoryId,
    required this.title,
    required this.description,
    required this.price,
    required this.negotiable,
    required this.condition,
    required this.images,
    required this.city,
    required this.area,
    required this.status,
    required this.views,
    required this.likes,
    this.agentId,
    this.isNew = false,
    this.isFeatured = false,
    this.isVerified = false,
    this.isUrgent = false,
    required this.createdAt,
    required this.updatedAt,
  });
}