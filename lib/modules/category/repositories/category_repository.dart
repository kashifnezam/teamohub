import 'package:teamomarket/modules/category/repositories/category_list.dart';
import '../models/category_field_model.dart';
import '../models/category_model.dart';
import '../models/sub_category_model.dart';
import 'category_field_list.dart';
import 'sub_category_list.dart';

class CategoryRepository {

  Future<List<CategoryModel>> getCategories() async {
    // final snapshot = await _firestore
    //     .collection(FirestoreCollections.categories)
    //     .where('isActive', isEqualTo: true)
    //     .orderBy('order')
    //     .get();
    return categories;
  }

  Future<List<SubCategoryModel>> getSubCategories(
      String categoryId) async {
    // final snapshot = await _firestore
    //     .collection(FirestoreCollections.subCategories)
    //     .where('categoryId', isEqualTo: categoryId)
    //     .where('isActive', isEqualTo: true)
    //     .orderBy('order')
    //     .get();
    //
    // return snapshot.docs
    //     .map((e) => SubCategoryModel.fromMap(e.data()))
    //     .toList();

    return subCategories
        .where((e) => e.categoryId == categoryId)
        .toList();
  }

  Future<List<CategoryFieldModel>> getFields({
    required String categoryId,
    String? subCategoryId,
  }) async {
    // Query query = _firestore
    //     .collection(FirestoreCollections.categoryFields)
    //     .where('categoryId', isEqualTo: categoryId)
    //     .where('isActive', isEqualTo: true);
    //
    // if (subCategoryId != null) {
    //   query = query.where(
    //     'subCategoryId',
    //     isEqualTo: subCategoryId,
    //   );
    // }
    //
    // final snapshot = await query.orderBy('order').get();

    // return snapshot.docs
    //     .map(
    //       (e) => CategoryFieldModel.fromMap(
    //     e.data() as Map<String, dynamic>,
    //   ),
    // )
    //     .toList();
    return categoryFields
        .where((e) => e.categoryId == categoryId && e.isActive)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }
}