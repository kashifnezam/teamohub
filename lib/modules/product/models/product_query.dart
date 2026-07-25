import 'package:cloud_firestore/cloud_firestore.dart';

enum ProductSortType {
  newest,
  oldest,
  priceLowToHigh,
  priceHighToLow,
  mostViewed,
  mostLiked,
}

class ProductQuery {
  final String? keyword;

  final String? categoryId;
  final String? subCategoryId;

  final String? countryId;
  final String? stateId;
  final String? cityId;

  final double? minPrice;
  final double? maxPrice;

  final String? condition;

  final String? brandId;

  final String? sellerId;

  final bool? negotiable;
  final bool? deliveryAvailable;
  final bool? featured;

  final ProductSortType sortType;

  final DocumentSnapshot? lastDocument;

  final int pageSize;

  const ProductQuery({
    this.keyword,
    this.categoryId,
    this.subCategoryId,
    this.countryId,
    this.stateId,
    this.cityId,
    this.minPrice,
    this.maxPrice,
    this.condition,
    this.brandId,
    this.sellerId,
    this.negotiable,
    this.deliveryAvailable,
    this.featured,
    this.sortType = ProductSortType.newest,
    this.lastDocument,
    this.pageSize = 20,
  });

  ProductQuery copyWith({
    String? keyword,
    String? categoryId,
    String? subCategoryId,
    String? countryId,
    String? stateId,
    String? cityId,
    double? minPrice,
    double? maxPrice,
    String? condition,
    String? brandId,
    String? sellerId,
    bool? negotiable,
    bool? deliveryAvailable,
    bool? featured,
    ProductSortType? sortType,
    DocumentSnapshot? lastDocument,
    int? pageSize,
    bool clearKeyword = false,
    bool clearCategory = false,
    bool clearSubCategory = false,
    bool clearCountry = false,
    bool clearState = false,
    bool clearCity = false,
    bool clearMinPrice = false,
    bool clearMaxPrice = false,
    bool clearCondition = false,
    bool clearBrand = false,
    bool clearSeller = false,
    bool clearNegotiable = false,
    bool clearDeliveryAvailable = false,
    bool clearFeatured = false,
    bool clearLastDocument = false,
  }) {
    return ProductQuery(
      keyword: clearKeyword ? null : (keyword ?? this.keyword),
      categoryId: clearCategory ? null : (categoryId ?? this.categoryId),
      subCategoryId:
      clearSubCategory ? null : (subCategoryId ?? this.subCategoryId),
      countryId: clearCountry ? null : (countryId ?? this.countryId),
      stateId: clearState ? null : (stateId ?? this.stateId),
      cityId: clearCity ? null : (cityId ?? this.cityId),
      minPrice: clearMinPrice ? null : (minPrice ?? this.minPrice),
      maxPrice: clearMaxPrice ? null : (maxPrice ?? this.maxPrice),
      condition: clearCondition ? null : (condition ?? this.condition),
      brandId: clearBrand ? null : (brandId ?? this.brandId),
      sellerId: clearSeller ? null : (sellerId ?? this.sellerId),
      negotiable:
      clearNegotiable ? null : (negotiable ?? this.negotiable),
      deliveryAvailable: clearDeliveryAvailable
          ? null
          : (deliveryAvailable ?? this.deliveryAvailable),
      featured: clearFeatured ? null : (featured ?? this.featured),
      sortType: sortType ?? this.sortType,
      lastDocument: clearLastDocument
          ? null
          : (lastDocument ?? this.lastDocument),
      pageSize: pageSize ?? this.pageSize,
    );
  }

  factory ProductQuery.initial() {
    return const ProductQuery();
  }

  bool get hasKeyword =>
      keyword != null && keyword!.trim().isNotEmpty;

  bool get hasFilters =>
      hasKeyword ||
          categoryId != null ||
          subCategoryId != null ||
          countryId != null ||
          stateId != null ||
          cityId != null ||
          minPrice != null ||
          maxPrice != null ||
          condition != null ||
          brandId != null ||
          sellerId != null ||
          negotiable != null ||
          deliveryAvailable != null ||
          featured != null;

  ProductQuery resetPagination() {
    return copyWith(clearLastDocument: true);
  }

  ProductQuery clearAll() {
    return const ProductQuery();
  }

  @override
  String toString() {
    final filters = <String, dynamic>{
      "keyword": keyword,
      "categoryId": categoryId,
      "subCategoryId": subCategoryId,
      "countryId": countryId,
      "stateId": stateId,
      "cityId": cityId,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "condition": condition,
      "brandId": brandId,
      "sellerId": sellerId,
      "negotiable": negotiable,
      "deliveryAvailable": deliveryAvailable,
      "featured": featured,
      "sortType": sortType.name,
      "pageSize": pageSize,
      "lastDocument": lastDocument?.id,
    };

    filters.removeWhere((key, value) => value == null);

    return "ProductQuery(${filters.entries.map((e) => "${e.key}: ${e.value}").join(", ")})";
  }
}