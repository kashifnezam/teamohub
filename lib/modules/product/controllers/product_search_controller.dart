import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';
import '../models/product_query.dart';
import '../repositories/product_repository.dart';

class ProductSearchController extends GetxController {
  ProductSearchController({
    ProductRepository? repository,
  }) : _repository = repository ?? ProductRepository();

  final ProductRepository _repository;

  final RxList<ProductModel> products = <ProductModel>[].obs;

  final RxBool loading = false.obs;
  final RxBool loadingMore = false.obs;
  final RxBool refreshing = false.obs;
  final RxBool hasMore = true.obs;
  final RxnString errorMessage = RxnString();

  bool _requestInProgress = false;

  final RxString keyword = "".obs;

  final Rx<ProductQuery> query = ProductQuery.initial().obs;

  Worker? _keywordWorker;

  @override
  void onInit() {
    super.onInit();

    _keywordWorker = debounce<String>(
      keyword,
          (_) {
        changeKeyword(keyword.value);
      },
      time: const Duration(milliseconds: 500),
    );

    search();
  }

  @override
  void onClose() {
    _keywordWorker?.dispose();
    super.onClose();
  }

  Future<void> search() async {
    if (_requestInProgress) return;

    _requestInProgress = true;
    loading.value = true;
    errorMessage.value = null;
    hasMore.value = true;

    try {
      final result = await _repository.searchProducts(
        query.value.resetPagination(),
      );

      products.assignAll(result.$1);

      query.value = query.value.copyWith(
        lastDocument: result.$2,
      );

      hasMore.value = result.$1.length == query.value.pageSize;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      loading.value = false;
      _requestInProgress = false;
    }
  }

  Future<void> loadMore() async {
    if (_requestInProgress) return;

    if (loadingMore.value) return;

    if (!hasMore.value) return;

    if (query.value.lastDocument == null) return;

    _requestInProgress = true;
    loadingMore.value = true;

    try {
      final result = await _repository.searchProducts(query.value);

      products.addAll(result.$1);

      query.value = query.value.copyWith(
        lastDocument: result.$2,
      );

      hasMore.value = result.$1.length == query.value.pageSize;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      loadingMore.value = false;
      _requestInProgress = false;
    }
  }

  Future<void> refreshProducts() async {
    refreshing.value = true;
    errorMessage.value = null;

    try {
      query.value = query.value.resetPagination();
      await search();
    } finally {
      refreshing.value = false;
    }
  }

  Future<void> retryLoading() async {
    errorMessage.value = null;
    await search();
  }

  Future<void> applyFilters(ProductQuery newQuery) async {
    query.value = newQuery.resetPagination();
    await search();
  }

  Future<void> clearFilters() async {
    keyword.value = "";

    query.value = ProductQuery.initial();

    await search();
  }

  Future<void> changeSort(ProductSortType sortType) async {
    query.value = query.value.copyWith(
      sortType: sortType,
      clearLastDocument: true,
    );

    await search();
  }

  Future<void> changeKeyword(String value) async {
    final text = value.trim().toLowerCase();

    if (text == (query.value.keyword ?? "")) {
      return;
    }

    query.value = query.value.copyWith(
      keyword: text.isEmpty ? null : text,
      clearLastDocument: true,
    );

    await search();
  }

  Future<void> changeCategory(String? categoryId) async {
    query.value = query.value.copyWith(
      categoryId: categoryId,
      clearLastDocument: true,
    );

    await search();
  }

  Future<void> changeSubCategory(String? subCategoryId) async {
    query.value = query.value.copyWith(
      subCategoryId: subCategoryId,
      clearLastDocument: true,
    );

    await search();
  }

  Future<void> changeLocation({
    String? countryId,
    String? stateId,
    String? cityId,
  }) async {
    query.value = query.value.copyWith(
      countryId: countryId,
      stateId: stateId,
      cityId: cityId,
      clearLastDocument: true,
    );

    await search();
  }

  Future<void> changePrice({
    double? minPrice,
    double? maxPrice,
  }) async {
    query.value = query.value.copyWith(
      minPrice: minPrice,
      maxPrice: maxPrice,
      clearLastDocument: true,
    );

    await search();
  }

  Future<void> changeCondition(String? condition) async {
    query.value = query.value.copyWith(
      condition: condition,
      clearLastDocument: true,
    );

    await search();
  }

  Future<void> changeBrand(String? brandId) async {
    query.value = query.value.copyWith(
      brandId: brandId,
      clearLastDocument: true,
    );

    await search();
  }

  Future<void> changeSeller(String? sellerId) async {
    query.value = query.value.copyWith(
      sellerId: sellerId,
      clearLastDocument: true,
    );

    await search();
  }
}