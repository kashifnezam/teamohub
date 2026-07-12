import '../../category/models/category_model.dart';
import '../../category/models/sub_category_model.dart';

class AddProductArguments {
  final CategoryModel category;
  final SubCategoryModel? subCategory;

  const AddProductArguments({
    required this.category,
    this.subCategory,
  });
}