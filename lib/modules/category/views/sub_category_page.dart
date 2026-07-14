import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../product/arguments/add_product_arguments.dart';
import '../controllers/category_controller.dart';
import '../models/category_model.dart';
import '../models/sub_category_model.dart';

class SubCategoryPage extends GetView<CategoryController> {
  SubCategoryPage({super.key});
  final CategoryModel category = Get.arguments;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          category.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isSubCategoryLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.subCategories.isEmpty) {
          return const Center(
            child: Text("No Sub Categories Found"),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.subCategories.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 18,
            childAspectRatio: .82,
          ),
          itemBuilder: (_, index) {
            final SubCategoryModel subCategory =
            controller.subCategories[index];

            return InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () async {
                await controller.loadFields(
                  categoryId: category.id,
                  subCategoryId: subCategory.id,
                );

                Get.toNamed(
                  Routes.addProduct,
                  arguments: AddProductArguments(
                    category: category,
                    subCategory: subCategory,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: Image.asset(
                        'assets/categories/${subCategory.image}',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Text(
                        subCategory.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}