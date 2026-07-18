import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:teamomarket/app/services/device_info.dart';
import 'package:teamomarket/app/utils/offline_data.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/utils/custom_alert.dart';
import '../../../app/utils/location_utils.dart';
import '../../../app/widgets/custom_widget.dart';
import '../../category/models/category_model.dart';
import '../../category/models/sub_category_model.dart';
import '../../location/models/location_result.dart';
import '../models/product_image_model.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';
import '../services/storage_service.dart';
import '../views/product_details_page.dart';

class ProductController extends GetxController {


  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final areaController = TextEditingController();

  CategoryModel? selectedCategory;
  SubCategoryModel? selectedSubCategory;
  final RxMap<String, dynamic> attributes = <String, dynamic>{}.obs;
  final ImagePicker _picker = ImagePicker();
  static const int maxImages = 20;
  final RxList<ProductImageModel> images = <ProductImageModel>[].obs;
  final Rxn<LocationResult> selectedLocation = Rxn<LocationResult>();

  final RxString country = ''.obs;
  final RxString state = ''.obs;
  final RxString city = ''.obs;
  final RxString area = ''.obs;
  final RxString address = ''.obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;

  final RxBool isLoading = false.obs;
  final RxBool imagesError = false.obs;
  final RxBool locationError = false.obs;
  bool get hasImages => images.isNotEmpty;
  bool get canAddMoreImages => images.length < maxImages;
  int get imageCount => images.length;

  final StorageService _storageService = StorageService();
  final ProductRepository _repository = ProductRepository();

  ProductImageModel? get coverImage {
    try {
      return images.firstWhere(
            (e) => e.isCover,
      );
    } catch (_) {
      return null;
    }
  }

  /// ---------------------------------------
  /// Dynamic Attributes
  /// ---------------------------------------

  void setAttribute(String key,
      dynamic value,) {
    attributes[key] = value;
  }

  dynamic getAttribute(String key) {
    return attributes[key];
  }

  void removeAttribute(String key) {
    attributes.remove(key);
  }

  void clearAttributes() {
    attributes.clear();
  }

  /// ---------------------------------------
  /// Images
  /// ---------------------------------------


  Future<void> pickLocation() async {
    await useCurrentLocation();
  }

  void setLocationResult(
      LocationResult location,
      ) {
    selectedLocation.value = location;

    country.value = location.country.name;

    state.value = location.state.name;

    city.value = location.city.name;

    latitude.value =
        location.city.latitude ?? 0;

    longitude.value =
        location.city.longitude ?? 0;
  }

  Future<List<String>> uploadImages({
    required String productId,
    required String categoryName,
    required List<String> imagePaths,
  }) async {
    final futures = imagePaths.map((path) async {
      final compressed = await CustomWidget.compressImage(path);

      return _storageService.uploadProductImage(
        productId: productId,
        categoryName: categoryName,
        imageFile: compressed,
      );
    });

    return Future.wait(futures);
  }

  Future<void> useCurrentLocation() async {
    final location = await LocationUtils.getSingleLocation(
      onError: (message) {
        Get.snackbar(
          "Location",
          message,
        );
      },
    );

    if (location == null) return;

    latitude.value = location.latitude;
    longitude.value = location.longitude;

    final places = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );

    if (places.isEmpty) return;

    final place = places.first;

    setLocation(
      countryValue: place.country ?? "",
      stateValue:
      place.administrativeArea ?? "",
      cityValue: place.locality ??
          place.subAdministrativeArea ??
          "",
      areaValue: place.subLocality,
      addressValue: place.street,
      latitudeValue: location.latitude,
      longitudeValue: location.longitude,
    );
  }

  void initialize({
    required CategoryModel category,
    SubCategoryModel? subCategory,
  }) {
    selectedCategory = category;
    selectedSubCategory = subCategory;
  }

  void removeImage(int index) {
    if (index < 0 || index >= images.length) {
      return;
    }

    final wasCover = images[index].isCover;

    images.removeAt(index);

    for (int i = 0; i < images.length; i++) {
      images[i] = images[i].copyWith(
        order: i,
        isCover: wasCover && i == 0
            ? true
            : images[i].isCover,
      );
    }
  }

  void clearImages() {
    images.clear();
  }

  void setCoverImage(int index) {

    if (index < 0 || index >= images.length) {
      return;
    }

    for (int i = 0; i < images.length; i++) {
      images[i] = images[i].copyWith(
        isCover: i == index,
      );
    }
  }

  void reorderImages(
      int oldIndex,
      int newIndex,
      ) {

    if (oldIndex < newIndex) {
      newIndex--;
    }

    final image =
    images.removeAt(oldIndex);

    images.insert(newIndex, image);

    for (int i = 0; i < images.length; i++) {

      images[i] =
          images[i].copyWith(
            order: i,
          );
    }
  }

  /// ---------------------------------------
  /// Location
  /// ---------------------------------------

  void setLocation({
    required String countryValue,
    required String stateValue,
    required String cityValue,
    String? areaValue,
    String? addressValue,
    double? latitudeValue,
    double? longitudeValue,
  }) {
    country.value = countryValue;
    state.value = stateValue;
    city.value = cityValue;

    area.value = areaValue ?? "";
    address.value = addressValue ?? "";

    latitude.value = latitudeValue ?? 0;
    longitude.value = longitudeValue ?? 0;

    areaController.text = area.value;

    locationError.value = false;
  }

  void clearLocation() {
    country.value = '';
    state.value = '';
    city.value = '';
    area.value = '';
    address.value = '';

    latitude.value = 0;
    longitude.value = 0;
  }

  Future<void> pickImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
        imageQuality: 85,
      );

      if (pickedImages.isEmpty) {
        return;
      }

      final remaining = maxImages - images.length;

      if (remaining <= 0) {
        CustomAlert.infoAlert(
          title: "Maximum Reached",
          "You can upload up to $maxImages photos.",
        );
        return;
      }

      for (final image in pickedImages.take(remaining)) {
        images.add(
          ProductImageModel(
            file: File(image.path),
            order: images.length,
            isCover: images.isEmpty,
          ),
        );
      }

      imagesError.value = false;

    } catch (e) {
      CustomAlert.errorAlert(
        title: "Error",
        "Unable to select images.",
      );
    }
  }
  /// ---------------------------------------
  /// Validation
  /// ---------------------------------------

  bool validateForm() {
    if (images.isEmpty) {
      CustomAlert.infoAlert(
        title: "Photos Required",
        "Please upload at least one photo.",
      );
      return false;
    }

    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return false;
    }
    if (city.value.isEmpty) {
      CustomAlert.infoAlert(
        title: "Location Required",
        "Please select a location.",
      );
      return false;
    }



    return true;
  }

  /// ---------------------------------------
  /// Preview
  /// ---------------------------------------

  void continueToPreview() {

    if (!validateForm()) {
      return;
    }


    Get.toNamed(
      Routes.productPreview,
    );
  }
  /// ---------------------------------------
  /// Publish
  /// ---------------------------------------

  Future<void> publishProduct() async {
    if (!validateForm()) return;

    try {
      isLoading.value = true;
      CustomAlert.loadAlert("Uploading product...");

      final productId = _repository.generateProductId();

      ProductModel product = buildProductModel().copyWith(
        id: productId,
      );

      //---------------------------------------
      // Upload Images
      //---------------------------------------

      final imageUrls = await uploadImages(
        productId: productId,
        categoryName: product.categoryName!,
        imagePaths: images
            .where((image) => image.file != null)
            .map((image) => image.file!.path)
            .toList(),
      );

      //---------------------------------------
      // Update Product
      //---------------------------------------

      product = product.copyWith(
        images: imageUrls,
      );

      //---------------------------------------
      // Upload Product
      //---------------------------------------

      await _repository.createProduct(product);
      clearForm();
      CustomAlert.dismissAlert();
      Get.offNamed(Routes.myAds);
      CustomAlert.successAlert(
        title: "Success",
        "Product published successfully.",
      );

      // Get.back(result: true);

      //clearForm();
    } catch (e) {
      CustomAlert.errorAlert(
        title: "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  ProductModel buildProductModel() {
    final now = DateTime.now();

    return ProductModel(
      id: "",
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      price: double.tryParse(priceController.text.trim()) ?? 0,
      categoryId: selectedCategory!.id,
      categoryName: selectedCategory!.name,
      subCategoryId: selectedSubCategory?.id,
      subCategoryName: selectedSubCategory?.name,
      sellerId: DeviceInfo.userUID!,
      sellerName: userInfo?['name'],
      sellerPhoto: userInfo?["photoUrl"],
      images: const [], // Images are uploaded during publish()
      attributes: Map<String, dynamic>.from(attributes),
      country: country.value,
      state: state.value,
      city: city.value,
      area: areaController.text.isEmpty ? null : areaController.text,
      address: address.value.isEmpty ? null : address.value,
      latitude: latitude.value,
      longitude: longitude.value,
      createdAt: now,
      updatedAt: now,
      publishedAt: now,
    );
  }
  /// ---------------------------------------
  /// Reset
  /// ---------------------------------------

  Future<ProductModel?> getProductDetail(String productId) async {
    CustomAlert.loadAlert("Loading Product Details...");
    ProductModel? product = await _repository.getProduct(productId);
    CustomAlert.dismissAlert();
    if(product != null && (product.status != ProductStatus.active || product.isDeleted)) CustomAlert.errorAlert("Product is either sold, deleted or inactive", title: "Not Available");
    else Get.to(() => ProductDetailsPage(product: product)) ;
    return product;
  }

  void clearForm() {

    titleController.clear();

    priceController.clear();

    descriptionController.clear();

    clearAttributes();

    clearImages();

    clearLocation();

  }

}