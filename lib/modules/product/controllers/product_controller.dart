import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/utils/location_utils.dart';
import '../../category/models/category_model.dart';
import '../../category/models/sub_category_model.dart';
import '../models/product_image_model.dart';
import '../models/product_model.dart';

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

  bool get hasImages =>
      images.isNotEmpty;

  bool get canAddMoreImages =>
      images.length < maxImages;

  int get imageCount =>
      images.length;

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

    latitude.value = latitudeValue!;
    longitude.value = longitudeValue!;

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
        Get.snackbar(
          "Maximum Reached",
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
      Get.snackbar(
        "Error",
        "Unable to select images.",
      );
    }
  }
  /// ---------------------------------------
  /// Validation
  /// ---------------------------------------

  bool validateForm() {
    if (images.isEmpty) {
      Get.snackbar(
        "Photos Required",
        "Please upload at least one photo.",
      );
      return false;
    }

    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return false;
    }
    if (city.value.isEmpty) {
      Get.snackbar(
        "Location Required",
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

    if (!validateForm()) {
      return;
    }

    try {

      isLoading.value = true;

      // TODO

      // Upload Images

      // Create ProductModel

      // Save to Firestore

      Get.back();

      Get.snackbar(
        "Success",
        "Product published successfully.",
      );

      clearForm();

    } catch (e) {

      Get.snackbar(
        "Error",
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

      price: double.tryParse(
        priceController.text.trim(),
      ) ??
          0,

      categoryId: selectedCategory!.id,

      subCategoryId: selectedSubCategory?.id,

      sellerId: "", // TODO: Replace with logged-in user's id

      agentId: null,

      images: const [], // Images are uploaded during publish()

      attributes: Map<String, dynamic>.from(attributes),

      country: country.value,

      state: state.value,

      city: city.value,

      area: area.value.isEmpty ? null : area.value,

      address: address.value.isEmpty ? null : address.value,

      latitude: latitude.value,

      longitude: longitude.value,

      createdAt: now,

      updatedAt: now,

      publishedAt: now,
      sellerName: '',
      sellerPhoto: '',
    );
  }
  /// ---------------------------------------
  /// Reset
  /// ---------------------------------------

  void clearForm() {

    titleController.clear();

    priceController.clear();

    descriptionController.clear();

    clearAttributes();

    clearImages();

    clearLocation();

  }

}