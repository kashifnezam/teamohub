import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../product/models/product_model.dart';
import '../../product/repositories/product_repository.dart';

class HomeController extends GetxController {
  final ProductRepository _repository = ProductRepository();

  final products = <ProductModel>[].obs;

  final isLoading = true.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  DocumentSnapshot? _lastDocument;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    fetchProducts();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300 &&
          !isLoadingMore.value &&
          hasMore.value &&
          !isLoading.value) {
        loadMore();
      }
    });
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      _lastDocument = null;
      hasMore.value = true;

      final (items, lastDoc) =
      await _repository.getProducts();

      products.assignAll(items);

      _lastDocument = lastDoc;

      if (items.length < ProductRepository.pageSize) {
        hasMore.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    try {
      isLoadingMore.value = true;

      final (items, lastDoc) =
      await _repository.getProducts(
        lastDocument: _lastDocument,
      );

      products.addAll(items);

      _lastDocument = lastDoc;

      if (items.length < ProductRepository.pageSize) {
        hasMore.value = false;
      }
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