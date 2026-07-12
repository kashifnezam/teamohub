import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../arguments/add_product_arguments.dart';
import '../../category/controllers/category_controller.dart';

class AddProductPage extends GetView<CategoryController> {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddProductArguments args = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sell ${args.subCategory?.name ?? args.category.title}",
        ),
      ),
      body: Obx(() {
        if (controller.isFieldLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [

            /// Dynamic Fields
            ...controller.fields.map(
                  (field) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildField(field),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Continue"),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildField(dynamic field) {
    switch (field.type) {
      case "text":
        return TextField(
          decoration: InputDecoration(
            labelText: field.label,
            hintText: field.hint,
          ),
        );

      case "textarea":
        return TextField(
          maxLines: 4,
          decoration: InputDecoration(
            labelText: field.label,
            hintText: field.hint,
          ),
        );

      case "number":
        return TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: field.label,
            hintText: field.hint,
          ),
        );

      case "dropdown":
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: field.label,
          ),
          items: field.options
              .map<DropdownMenuItem<String>>(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
              .toList(),
          onChanged: (_) {},
        );

      case "checkbox":
        return CheckboxListTile(
          value: false,
          onChanged: (_) {},
          title: Text(field.label),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}