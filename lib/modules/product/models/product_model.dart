
/// ===============================
/// Product Type
/// ===============================
enum ProductType {
  sell,
  buy,
}

/// ===============================
/// Product Condition
/// ===============================
enum ProductCondition {
  newProduct,
  likeNew,
  good,
  fair,
  poor,
}

/// ===============================
/// Product Status
/// ===============================
enum ProductStatus {
  draft,
  pending,
  active,
  sold,
  rejected,
  expired,
}

class ProductModel {
  /// Unique Product ID
  final String id;
  final String? sellerName;
  final String? sellerPhoto;
  /// Basic Information
  final String title;
  final String description;
  final double price;

  /// Sell / Buy
  final ProductType type;

  /// Category
  final String categoryId;
  final String? categoryName;
  final String? subCategoryId;
  final String? subCategoryName;

  /// Seller
  final String sellerId;

  /// Optional Agent
  final String? agentId;

  /// Product Images
  final List<String> images;

  /// Dynamic Attributes
  ///
  /// Example:
  /// {
  ///   "brand": "Toyota",
  ///   "year": 2022,
  ///   "fuel": "Petrol"
  /// }
  final Map<String, dynamic> attributes;

  // /// Product Condition
  // final ProductCondition condition;

  /// Country
  final String country;

  /// State
  final String state;

  /// City
  final String city;

  /// Area / Locality
  final String? area;

  /// Full Address
  final String? address;

  /// Map Coordinates
  final double? latitude;
  final double? longitude;

  /// Product Status
  final ProductStatus status;

  /// Price Negotiable
  final bool isNegotiable;

  /// Home Featured Product
  final bool isFeatured;

  /// Newly Added Badge
  // final bool isNew;

  /// Verified Seller/Product
  final bool isVerified;

  /// Urgent Sale Badge
  final bool isUrgent;

  /// Total Views
  final int views;

  /// Total Likes
  final int likes;

  /// Total Shares
  final int shares;

  /// Total Chats Started
  final int chats;

  /// Whether comments are enabled
  final bool allowComments;

  /// Soft Delete
  final bool isDeleted;

  /// Published Time
  final DateTime? publishedAt;

  /// Expiry Time
  final DateTime? expiresAt;

  /// Created Time
  final DateTime createdAt;

  /// Updated Time
  final DateTime updatedAt;

  const ProductModel({
    required this.id,
    this.sellerName,
    this.sellerPhoto,
    required this.title,
    required this.description,
    required this.price,

    this.type = ProductType.sell,

    required this.categoryId,
    this.categoryName,
    this.subCategoryId,
    this.subCategoryName,

    required this.sellerId,
    this.agentId,

    this.images = const [],
    this.attributes = const {},

    // this.condition = ProductCondition.good,

    required this.country,
    required this.state,
    required this.city,

    this.area,
    this.address,

    this.latitude,
    this.longitude,

    this.status = ProductStatus.active,

    this.isNegotiable = false,
    this.isFeatured = false,
    // this.isNew = false,
    this.isVerified = false,
    this.isUrgent = false,

    this.views = 0,
    this.likes = 0,
    this.shares = 0,
    this.chats = 0,

    this.allowComments = true,

    this.isDeleted = false,

    this.publishedAt,
    this.expiresAt,

    required this.createdAt,
    required this.updatedAt,
  });


  ProductModel copyWith({
    String? id,
    String? sellerName,
    String? sellerPhoto,
    String? title,
    String? description,
    double? price,
    ProductType? type,
    String? categoryId,
    String? categoryName,
    String? subCategoryId,
    String? subCategoryName,
    String? sellerId,
    String? agentId,
    List<String>? images,
    Map<String, dynamic>? attributes,
    ProductCondition? condition,
    String? country,
    String? state,
    String? city,
    String? area,
    String? address,
    double? latitude,
    double? longitude,
    ProductStatus? status,
    bool? isNegotiable,
    bool? isFeatured,
    bool? isVerified,
    bool? isUrgent,
    int? views,
    int? likes,
    int? shares,
    int? chats,
    bool? allowComments,
    bool? isDeleted,
    DateTime? publishedAt,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      sellerName: sellerName ?? this.sellerName,
      sellerPhoto: sellerPhoto ?? this.sellerPhoto,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      sellerId: sellerId ?? this.sellerId,
      agentId: agentId ?? this.agentId,
      images: images ?? this.images,
      attributes: attributes ?? this.attributes,
      // condition: condition ?? this.condition,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      area: area ?? this.area,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
      isNegotiable: isNegotiable ?? this.isNegotiable,
      isFeatured: isFeatured ?? this.isFeatured,
      // isNew: isNew ?? this.isNew,
      isVerified: isVerified ?? this.isVerified,
      isUrgent: isUrgent ?? this.isUrgent,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      shares: shares ?? this.shares,
      chats: chats ?? this.chats,
      allowComments: allowComments ?? this.allowComments,
      isDeleted: isDeleted ?? this.isDeleted,
      publishedAt: publishedAt ?? this.publishedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,

      'type': type.name,

      'categoryId': categoryId,
      'categoryName': categoryName,
      'subCategoryId': subCategoryId,
      'subCategoryName': subCategoryName,

      'sellerId': sellerId,
      "sellerName": sellerName,
      "sellerPhoto": sellerPhoto,
      'agentId': agentId,

      'images': images,
      'attributes': attributes,

      // 'condition': condition.name,

      'country': country,
      'state': state,
      'city': city,
      'area': area,
      'address': address,

      'latitude': latitude,
      'longitude': longitude,

      'status': status.name,

      'isNegotiable': isNegotiable,
      'isFeatured': isFeatured,
      // 'isNew': isNew,
      'isVerified': isVerified,
      'isUrgent': isUrgent,

      'views': views,
      'likes': likes,
      'shares': shares,
      'chats': chats,

      'allowComments': allowComments,
      'isDeleted': isDeleted,

      'publishedAt': publishedAt?.millisecondsSinceEpoch,
      'expiresAt': expiresAt?.millisecondsSinceEpoch,

      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      sellerName: map['sellerName'],
      sellerPhoto: map['sellerPhoto'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),

      type: ProductType.values.firstWhere(
            (e) => e.name == map['type'],
        orElse: () => ProductType.sell,
      ),

      categoryId: map['categoryId'] ?? '',
      categoryName: map['categoryName'] ?? '',
      subCategoryId: map['subCategoryId'],
      subCategoryName: map['subCategoryName'] ?? '',

      sellerId: map['sellerId'] ?? '',
      agentId: map['agentId'],

      images: List<String>.from(map['images'] ?? const []),

      attributes: Map<String, dynamic>.from(
        map['attributes'] ?? const {},
      ),

      // condition: ProductCondition.values.firstWhere(
      //       (e) => e.name == map['condition'],
      //   orElse: () => ProductCondition.good,
      // ),

      country: map['country'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      area: map['area'],
      address: map['address'],

      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),

      status: ProductStatus.values.firstWhere(
            (e) => e.name == map['status'],
        orElse: () => ProductStatus.active,
      ),

      isNegotiable: map['isNegotiable'] ?? false,
      isFeatured: map['isFeatured'] ?? false,
      // isNew: map['isNew'] ?? false,
      isVerified: map['isVerified'] ?? false,
      isUrgent: map['isUrgent'] ?? false,

      views: map['views'] ?? 0,
      likes: map['likes'] ?? 0,
      shares: map['shares'] ?? 0,
      chats: map['chats'] ?? 0,

      allowComments: map['allowComments'] ?? true,
      isDeleted: map['isDeleted'] ?? false,

      publishedAt: map['publishedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['publishedAt'])
          : null,

      expiresAt: map['expiresAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expiresAt'])
          : null,

      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] ?? 0,
      ),

      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'] ?? 0,
      ),
    );
  }  /// Convert to JSON
  Map<String, dynamic> toJson() => toMap();

  /// Create from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel.fromMap(json);

  /// -------------------------
  /// Computed Getters
  /// -------------------------

  bool get isActive => status == ProductStatus.active;

  bool get isSold => status == ProductStatus.sold;

  bool get isPending => status == ProductStatus.pending;

  bool get hasImages => images.isNotEmpty;

  bool get hasLocation =>
      latitude != null && longitude != null;

  bool get isPublished => publishedAt != null;

  bool get isExpired =>
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  @override
  String toString() {
    return '''
ProductModel(
  id: $id,
  title: $title,
  price: $price,
  type: ${type.name},
  status: ${status.name},
  city: $city
)
''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}