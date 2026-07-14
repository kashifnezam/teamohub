import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/modules/product/controllers/product_controller.dart';

import '../../category/controllers/category_controller.dart';
import '../arguments/add_product_arguments.dart';
import '../widgets/add_photos_card.dart';
import '../widgets/basic_information_card.dart';
import '../widgets/bottom_continue_bar.dart';
import '../widgets/dynamic_fields_card.dart';
import '../widgets/location_card.dart';

class AddProductPage extends GetView<CategoryController> {
  AddProductPage({super.key});
  final ProductController productController = Get.put(ProductController());
  final AddProductArguments args = Get.arguments;
  @override
  Widget build(BuildContext context) {


    productController.initialize(
      category: args.category,
      subCategory: args.subCategory,
    );

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Column(
          children: [
            Text(
              "Sell ${args.subCategory?.name ?? args.category.name}",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            Text(
              args.category.name,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const BottomContinueBar(),

      body: Obx(() {
        if (controller.isFieldLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Form(
          key: productController.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [

              /// Photos
              const AddPhotosCard(),

              const SizedBox(height: 18),

              /// Basic Information
              const BasicInformationCard(),

              const SizedBox(height: 18),

              /// Category Specific Fields
              DynamicFieldsCard(
                fields: controller.fields,
              ),

              const SizedBox(height: 18),

              /// Location
              const LocationCard(),

              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}