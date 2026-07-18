import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/constants/app_constants.dart';
import '../../../app/utils/custom_alert.dart';
import '../../product/models/product_model.dart';
import '../repository/my_ads_repository.dart';

class MyAdsController extends GetxController {
  final MyAdsRepository _repository = MyAdsRepository.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxBool isLoading = true.obs;

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;

  final RxString selectedFilter = "All".obs;

  final TextEditingController searchController = TextEditingController();

  StreamSubscription<List<ProductModel>>? _subscription;

  String get uid => _auth.currentUser?.uid ?? "";

  @override
  void onInit() {
    super.onInit();

    searchController.addListener(_applyFilters);

    listenMyAds();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    searchController.dispose();
    super.onClose();
  }

  Future<void> refreshAds() async {
    listenMyAds();
  }

  void listenMyAds() {
    if (uid.isEmpty) return;

    isLoading(true);

    _subscription?.cancel();

    _subscription = _repository.streamMyProducts(uid).listen(
          (items) {
        products.assignAll(items);

        _applyFilters();
        AppConstants.log;

        isLoading(false);
      },
      onError: (e) {
        isLoading(false);

        CustomAlert.errorAlert(
          title: "Error",
          e.toString(),
        );
      },
    );
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    _applyFilters();
  }

  void clearSearch() {
    searchController.clear();
    _applyFilters();
  }

  void _applyFilters() {
    final keyword = searchController.text.trim().toLowerCase();

    Iterable<ProductModel> result = products;

    if (selectedFilter.value != "All") {
      result = result.where(
            (e) => e.status.name == selectedFilter.value.toLowerCase(),
      );
    }

    if (keyword.isNotEmpty) {
      result = result.where(
            (e) =>
        e.title.toLowerCase().contains(keyword) ||
            e.description.toLowerCase().contains(keyword),
      );
    }

    filteredProducts.assignAll(result.toList());
  }

  Future<void> markSold(ProductModel product) async {
    try {
      CustomAlert.loadAlert("Updating...");

      await _repository.updateStatus(
        productId: product.id,
        status: "Sold",
      );

      CustomAlert.dismissAlert();

      CustomAlert.successAlert(
        title: "Success",
        "Product marked as sold.",
      );
    } catch (e) {
      CustomAlert.dismissAlert();

      CustomAlert.errorAlert(
        title: "Error",
        e.toString(),
      );
    }
  }

  Future<void> updateStatus(ProductModel product, {bool active = false}) async {
    try {
      CustomAlert.loadAlert("Updating...");
      await _repository.updateStatus(productId: product.id, status: active ? 'active' : 'inactive');
      CustomAlert.dismissAlert();
      CustomAlert.successAlert(
        title: "Success",
        active? "Product activated successfully." : "Product deactivated successfully.",
      );
    } catch (e) {
      CustomAlert.dismissAlert();
      CustomAlert.errorAlert(
        title: "Error",
        e.toString(),
      );
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      CustomAlert.loadAlert("Deleting product...");

      await _repository.deleteProduct(product.id);

      CustomAlert.dismissAlert();

      CustomAlert.successAlert(
        title: "Deleted",
        "Product deleted successfully.",
      );
    } catch (e) {
      CustomAlert.dismissAlert();

      CustomAlert.errorAlert(
        title: "Error",
        e.toString(),
      );
    }
  }

  void editProduct(ProductModel product) {
    // TODO:

    // Navigate to Edit Product page
  }

  void viewProduct(ProductModel product) {
    // TODO:
    // Navigate to Product Details page
  }

  void shareProduct(ProductModel product) {
    // TODO:
    // Share product using share_plus
  }

  int get totalAds => products.length;

  int get activeAds =>
      products.where((e) => (e.status) == "Active").length;

  int get soldAds =>
      products.where((e) => (e.status) == "Sold").length;

  int get draftAds =>
      products.where((e) => (e.status) == "Draft").length;
}