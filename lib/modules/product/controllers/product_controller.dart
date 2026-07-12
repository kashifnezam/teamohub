import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  /// ----------------------------
  /// Basic Information
  /// ----------------------------

  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final priceController = TextEditingController();

  /// ----------------------------
  /// Dynamic Category Fields
  /// Example:
  /// brand
  /// fuel
  /// storage
  /// ram
  /// bedrooms
  /// etc.
  /// ----------------------------

  final RxMap<String, dynamic> attributes =
      <String, dynamic>{}.obs;

  /// ----------------------------
  /// Images
  /// ----------------------------

  final RxList<File> images = <File>[].obs;

  /// ----------------------------
  /// Location
  /// ----------------------------

  final RxString country = ''.obs;

  final RxString state = ''.obs;

  final RxString city = ''.obs;

  final RxString area = ''.obs;

  final RxString address = ''.obs;

  final RxDouble latitude = 0.0.obs;

  final RxDouble longitude = 0.0.obs;

  /// ----------------------------
  /// Loading
  /// ----------------------------

  final RxBool isUploading = false.obs;

  /// ----------------------------
  /// Dynamic Fields
  /// ----------------------------

  void setAttribute(
      String key,
      dynamic value,
      ) {
    attributes[key] = value;
  }

  dynamic getAttribute(String key) {
    return attributes[key];
  }

  /// ----------------------------
  /// Images
  /// ----------------------------

  void addImage(File image) {
    images.add(image);
  }

  void removeImage(int index) {
    images.removeAt(index);
  }

  void clearImages() {
    images.clear();
  }

  /// ----------------------------
  /// Location
  /// ----------------------------

  void setLocation({
    required String countryValue,
    required String stateValue,
    required String cityValue,
    String areaValue = '',
    String addressValue = '',
    double latitudeValue = 0,
    double longitudeValue = 0,
  }) {
    country.value = countryValue;
    state.value = stateValue;
    city.value = cityValue;
    area.value = areaValue;
    address.value = addressValue;
    latitude.value = latitudeValue;
    longitude.value = longitudeValue;
  }

  /// ----------------------------
  /// Reset
  /// ----------------------------

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();

    attributes.clear();

    images.clear();

    country.value = '';
    state.value = '';
    city.value = '';
    area.value = '';
    address.value = '';

    latitude.value = 0;
    longitude.value = 0;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();

    super.onClose();
  }
}