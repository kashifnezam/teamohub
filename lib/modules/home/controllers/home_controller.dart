import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../location/controllers/location_controller.dart';
import '../../location/models/location_result.dart';
import '../../product/models/product_model.dart';
import '../../product/models/product_pagination.dart';
import '../../product/repositories/product_repository.dart';

class HomeController extends GetxController {
  final ProductRepository _repository = ProductRepository();

  final products = <ProductModel>[].obs;

  final isLoading = true.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  final pagination = const ProductPagination().obs;

  final ScrollController scrollController = ScrollController();

  final locationController = Get.find<LocationController>();

  @override
  void onInit() {
    super.onInit();

    fetchProducts();

    ever<LocationResult?>(
      locationController.currentLocation,
          (_) {
        fetchProducts();
      },
    );

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300 &&
          !isLoading.value &&
          !isLoadingMore.value &&
          hasMore.value) {
        loadMore();
      }
    });
  }

  LocationResult? get currentLocation => locationController.currentLocation.value;

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      products.clear();

      pagination.value = const ProductPagination();

      hasMore.value = true;

      final result = await _repository.getProducts(
        pagination: pagination.value,
        city: currentLocation?.city.name,
        state: currentLocation?.state.name,
      );

      pagination.value = result.pagination;

      products.assignAll(result.products);

      hasMore.value = !result.pagination.isCompleted;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore.value) return;

    try {
      isLoadingMore.value = true;

      final result = await _repository.getProducts(
        pagination: pagination.value,
        city: currentLocation?.city.name,
        state: currentLocation?.state.name,
      );

      pagination.value = result.pagination;

      products.addAll(result.products);

      hasMore.value = !result.pagination.isCompleted;
    } finally {
      isLoadingMore.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}