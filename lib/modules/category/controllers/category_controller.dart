import 'package:get/get.dart';

import '../models/category_field_model.dart';
import '../models/category_model.dart';
import '../models/sub_category_model.dart';
import '../repositories/category_repository.dart';

class CategoryController extends GetxController {
  final CategoryRepository _repository;

  CategoryController(this._repository);

  final RxBool isCategoryLoading = false.obs;
  final RxBool isSubCategoryLoading = false.obs;
  final RxBool isFieldLoading = false.obs;

  final RxList<CategoryModel> categories =
      <CategoryModel>[].obs;

  final RxList<SubCategoryModel> subCategories =
      <SubCategoryModel>[].obs;

  final RxList<CategoryFieldModel> fields =
      <CategoryFieldModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      isCategoryLoading.value = true;

      categories.value =
      await _repository.getCategories();
    } finally {
      isCategoryLoading.value = false;
    }
  }

  Future<void> loadSubCategories(
      String categoryId) async {
    try {
      isSubCategoryLoading.value = true;

      subCategories.value =
      await _repository.getSubCategories(categoryId);
    } finally {
      isSubCategoryLoading.value = false;
    }
  }

  Future<void> loadFields({
    required String categoryId,
    String? subCategoryId,
  }) async {
    try {
      isFieldLoading.value = true;

      fields.value = await _repository.getFields(
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );
    } finally {
      isFieldLoading.value = false;
    }
  }

  Future<bool> hasSubCategories(String categoryId) async {
    final list = await _repository.getSubCategories(categoryId);
    return list.isNotEmpty;
  }

  void clearSubCategories() {
    subCategories.clear();
  }

  void clearFields() {
    fields.clear();
  }
}