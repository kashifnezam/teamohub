import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../product/arguments/add_product_arguments.dart';
import '../controllers/category_controller.dart';
import '../../../app/routes/app_routes.dart';

class CategoriesPage extends GetView<CategoryController> {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (controller.isCategoryLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.categories.isEmpty) {
          return const Center(
            child: Text("No Categories Found"),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.categories.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 18,
            childAspectRatio: .82,
          ),
          itemBuilder: (_, index) {
            final category = controller.categories[index];

            return InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () async {
                if (category.hasSubCategories) {
                  await controller.loadSubCategories(category.id);

                  Get.toNamed(
                    Routes.subCategories,
                    arguments: category,
                  );
                } else {
                  await controller.loadFields(
                    categoryId: category.id,
                  );

                  Get.toNamed(
                    Routes.addProduct,
                    arguments: AddProductArguments(
                      category: category,
                    ),
                  );
                }
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
                        category.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Text(
                        category.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
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