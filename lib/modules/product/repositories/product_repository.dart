import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamomarket/app/constants/firebase_constants.dart';
import '../../../app/services/device_info.dart';
import '../models/product_model.dart';
import '../models/product_pagination.dart';
import '../models/product_query.dart';

class ProductPageResult {
  final List<ProductModel> products;
  final ProductPagination pagination;

  const ProductPageResult({
    required this.products,
    required this.pagination,
  });
}

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _products => _firestore.collection(FirebaseConstants.products);

  ///------------------------------------------------
  /// Generate Product Id
  ///------------------------------------------------
  String generateProductId() {
    return _products.doc().id;
  }

  ///------------------------------------------------
  /// Create Product
  ///------------------------------------------------

  Future<void> createProduct(ProductModel product) async {
    final productWithKeywords = product.copyWith(
      searchKeywords: generateSearchKeywords(
        title: product.title,
        category: product.categoryName,
        subCategory: product.subCategoryName,
      )
    );
    await _products.doc(product.id).set(productWithKeywords.toJson());
  }

  ///------------------------------------------------
  /// Get All Products
  ///------------------------------------------------

  static const int pageSize = 20;

  Future<ProductPageResult> getProducts({
    required ProductPagination pagination,
    String? city,
    String? state,
  }) async {
    final List<ProductModel> products = [];
    final Set<String> loadedIds = {};

    Query<Map<String, dynamic>> baseQuery = _products
        .where("isDeleted", isEqualTo: false)
        .where("status", isEqualTo: ProductStatus.active.name)
        .orderBy("publishedAt", descending: true);

    ProductPagination current = pagination;

    while (products.length < pageSize &&
        current.stage != ProductPaginationStage.completed) {
      Query<Map<String, dynamic>> query;

      switch (current.stage) {
        case ProductPaginationStage.city:
          if (city == null || city.isEmpty) {
            current = current.copyWith(
              stage: ProductPaginationStage.state,
            );
            continue;
          }

          query = baseQuery.where("city", isEqualTo: city);

          if (current.cityLastDocument != null) {
            query = query.startAfterDocument(current.cityLastDocument!);
          }

          break;

        case ProductPaginationStage.state:
          if (state == null || state.isEmpty) {
            current = current.copyWith(
              stage: ProductPaginationStage.global,
            );
            continue;
          }

          query = baseQuery.where("state", isEqualTo: state);

          if (current.stateLastDocument != null) {
            query = query.startAfterDocument(current.stateLastDocument!);
          }

          break;

        case ProductPaginationStage.global:
          query = baseQuery;

          if (current.globalLastDocument != null) {
            query = query.startAfterDocument(current.globalLastDocument!);
          }

          break;

        case ProductPaginationStage.completed:
          return ProductPageResult(
            products: products,
            pagination: current,
          );
      }

      final snapshot = await query.limit(pageSize).get();

      if (snapshot.docs.isEmpty) {
        switch (current.stage) {
          case ProductPaginationStage.city:
            current = current.copyWith(
              stage: ProductPaginationStage.state,
            );
            break;

          case ProductPaginationStage.state:
            current = current.copyWith(
              stage: ProductPaginationStage.global,
            );
            break;

          case ProductPaginationStage.global:
            current = current.copyWith(
              stage: ProductPaginationStage.completed,
            );
            break;

          case ProductPaginationStage.completed:
            break;
        }

        continue;
      }

      switch (current.stage) {
        case ProductPaginationStage.city:
          current = current.copyWith(
            cityLastDocument: snapshot.docs.last,
          );
          break;

        case ProductPaginationStage.state:
          current = current.copyWith(
            stateLastDocument: snapshot.docs.last,
          );
          break;

        case ProductPaginationStage.global:
          current = current.copyWith(
            globalLastDocument: snapshot.docs.last,
          );
          break;

        case ProductPaginationStage.completed:
          break;
      }

      for (final doc in snapshot.docs) {
        final product = ProductModel.fromJson(doc.data());

        if (loadedIds.add(product.id)) {
          products.add(product);

          if (products.length >= pageSize) {
            break;
          }
        }
      }

      if (snapshot.docs.length < pageSize) {
        switch (current.stage) {
          case ProductPaginationStage.city:
            current = current.copyWith(
              stage: ProductPaginationStage.state,
            );
            break;

          case ProductPaginationStage.state:
            current = current.copyWith(
              stage: ProductPaginationStage.global,
            );
            break;

          case ProductPaginationStage.global:
            current = current.copyWith(
              stage: ProductPaginationStage.completed,
            );
            break;

          case ProductPaginationStage.completed:
            break;
        }
      }
    }

    return ProductPageResult(
      products: products,
      pagination: current,
    );
  }

  ///------------------------------------------------
  /// Stream All Products
  ///------------------------------------------------
  Stream<List<ProductModel>> streamProducts() {
    return _products
        .where("isDeleted", isEqualTo: false)
        .where("status", isEqualTo: ProductStatus.active.name)
        .orderBy("publishedAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList(),
    );
  }

  ///------------------------------------------------
  /// Get Single Product
  ///------------------------------------------------
  Future<ProductModel?> getProduct(String productId) async {
    // Try products collection first
    final productDoc = await _products.doc(productId).get();

    if (productDoc.exists) {
      return ProductModel.fromJson(productDoc.data()!);
    }

    // Fallback to agent_listings
    final agentDoc = await FirebaseFirestore.instance
        .collection("agent_listings")
        .doc(productId)
        .get();

    if (!agentDoc.exists) {
      return null;
    }

    final data = agentDoc.data()!;

    final Map<String, dynamic> snapshot =
    Map<String, dynamic>.from(data["productSnapshot"] ?? {});

    return ProductModel.fromJson({
      ...snapshot,
      "id": agentDoc.id,
      "title": data["title"],
      "description": data["description"],
      "price": data["price"],
      "images": data["images"],
      "sellerId": data["sellerId"],
    });
  }

  ///------------------------------------------------
  /// Update Product
  ///------------------------------------------------

  Future<void> updateProduct(ProductModel product) async {
    final updatedProduct = product.copyWith(
      searchKeywords:generateSearchKeywords(
        title: product.title,
        category: product.categoryName,
        subCategory: product.subCategoryName,
      )
    );

    await _products.doc(product.id).update(
      updatedProduct.toJson(),
    );
  }

  ///------------------------------------------------
  /// Soft Delete
  ///------------------------------------------------
  Future<void> deleteProduct(String productId) async {
    await _products.doc(productId).update({
      "isDeleted": true,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  Future<(List<ProductModel>, DocumentSnapshot?)> searchProducts(ProductQuery query) async {
    Query<Map<String, dynamic>> firestoreQuery = _products
        .where("isDeleted", isEqualTo: false)
        .where("status", isEqualTo: ProductStatus.active.name);

    if (query.featured != null) {
      firestoreQuery = firestoreQuery.where("featured", isEqualTo: query.featured);
    }

    if (query.categoryId != null) {
      firestoreQuery =
          firestoreQuery.where("categoryId", isEqualTo: query.categoryId);
    }

    if (query.subCategoryId != null) {
      firestoreQuery = firestoreQuery.where(
        "subCategoryId",
        isEqualTo: query.subCategoryId,
      );
    }

    if (query.countryId != null) {
      firestoreQuery =
          firestoreQuery.where("countryId", isEqualTo: query.countryId);
    }

    if (query.stateId != null) {
      firestoreQuery =
          firestoreQuery.where("stateId", isEqualTo: query.stateId);
    }

    if (query.cityId != null) {
      firestoreQuery =
          firestoreQuery.where("cityId", isEqualTo: query.cityId);
    }

    if (query.condition != null) {
      firestoreQuery =
          firestoreQuery.where("condition", isEqualTo: query.condition);
    }

    if (query.brandId != null) {
      firestoreQuery =
          firestoreQuery.where("brandId", isEqualTo: query.brandId);
    }

    if (query.sellerId != null) {
      firestoreQuery = firestoreQuery.where("sellerId", isEqualTo: query.sellerId);
    }

    if (query.negotiable != null) {
      firestoreQuery = firestoreQuery.where("negotiable", isEqualTo: query.negotiable);
    }

    if (query.deliveryAvailable != null) {
      firestoreQuery = firestoreQuery.where(
        "deliveryAvailable",
        isEqualTo: query.deliveryAvailable,
      );
    }

    if (query.hasKeyword) {
      firestoreQuery = firestoreQuery.where(
        "searchKeywords",
        arrayContains: query.keyword!.trim().toLowerCase(),
      );
    }

    firestoreQuery = _applySorting(firestoreQuery, query);

    if (query.minPrice != null) {
      firestoreQuery =
          firestoreQuery.where("price", isGreaterThanOrEqualTo: query.minPrice);
    }

    if (query.maxPrice != null) {
      firestoreQuery =
          firestoreQuery.where("price", isLessThanOrEqualTo: query.maxPrice);
    }

    firestoreQuery = firestoreQuery.limit(query.pageSize);

    if (query.lastDocument != null) {
      firestoreQuery = firestoreQuery.startAfterDocument(query.lastDocument!);
    }

    final snapshot = await firestoreQuery.get();

    final products = snapshot.docs
        .map((e) => ProductModel.fromJson(e.data()))
        .toList();
    return (
    products,
    snapshot.docs.isEmpty ? null : snapshot.docs.last,
    );
  }

  Query<Map<String, dynamic>> _applySorting(
      Query<Map<String, dynamic>> query,
      ProductQuery productQuery,
      ) {
    switch (productQuery.sortType) {
      case ProductSortType.oldest:
        return query.orderBy("publishedAt");

      case ProductSortType.priceLowToHigh:
        return query.orderBy("price");

      case ProductSortType.priceHighToLow:
        return query.orderBy("price", descending: true);

      case ProductSortType.mostViewed:
        return query.orderBy("viewCount", descending: true);

      case ProductSortType.mostLiked:
        return query.orderBy("likeCount", descending: true);

      case ProductSortType.newest:
        return query.orderBy("publishedAt", descending: true);
    }
  }

  ///------------------------------------------------
  /// Generate Search Keywords
  ///------------------------------------------------
  ///------------------------------------------------
  /// Generate Search Keywords
  ///------------------------------------------------
  List<String> generateSearchKeywords({
    required String title,
    String? category,
    String? subCategory,
  }) {
    final Set<String> keywords = {};

    void addText(String? text) {
      if (text == null || text.trim().isEmpty) return;

      final words = text
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9 ]'), ' ')
          .split(RegExp(r'\s+'));

      for (final word in words) {
        if (word.isEmpty) continue;

        // Full word
        keywords.add(word);

        // Prefixes
        final buffer = StringBuffer();
        for (final char in word.split('')) {
          buffer.write(char);
          keywords.add(buffer.toString());
        }
      }
    }

    addText(title);
    addText(category);
    addText(subCategory);

    return keywords.toList()..sort();
  }

  Future<void> registerView({
    required String productId,
    required String sellerId,
    bool uniquePerUser = false,
    int repeatAfterHours = 0,
  }) async {
    final viewerId = DeviceInfo.userUID ?? DeviceInfo.deviceId;

    if (viewerId == null || viewerId.isEmpty) return;

    // Don't count seller's own views (only applies to logged-in seller)
    if (DeviceInfo.userUID != null &&
        DeviceInfo.userUID == sellerId) {
      return;
    }

    // Unlimited counting
    if (!uniquePerUser && repeatAfterHours == 0) {
      await _products.doc(productId).update({
        "views": FieldValue.increment(1),
      });
      return;
    }

    final viewRef = _firestore
        .collection("productViews")
        .doc("${productId}_$viewerId");

    final productRef = _products.doc(productId);

    await _firestore.runTransaction((transaction) async {
      final viewDoc = await transaction.get(viewRef);

      if (!viewDoc.exists) {
        transaction.set(viewRef, {
          "productId": productId,
          "viewerId": viewerId,
          "authUser": DeviceInfo.userUID != null,
          "viewedAt": FieldValue.serverTimestamp(),
        });

        transaction.update(productRef, {
          "views": FieldValue.increment(1),
        });

        return;
      }

      if (uniquePerUser) return;

      final data = viewDoc.data()!;
      final Timestamp? timestamp = data["viewedAt"];

      if (timestamp == null) return;

      final lastViewed = timestamp.toDate();

      if (DateTime.now().difference(lastViewed).inHours <
          repeatAfterHours) {
        return;
      }

      transaction.update(viewRef, {
        "viewedAt": FieldValue.serverTimestamp(),
        "authUser": DeviceInfo.userUID != null,
      });

      transaction.update(productRef, {
        "views": FieldValue.increment(1),
      });
    });
  }

  Future<void> increaseShareCount(String productId) async {
    await _products.doc(productId).update({
      'shares': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateLastShared(String productId) async {
    await _products.doc(productId)
        .update({
        'lastSharedAt': FieldValue.serverTimestamp(),
      },
    );
  }

}