import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../app/utils/validators.dart';
import '../controllers/product_controller.dart';

class BasicInformationCard extends GetView<ProductController> {
  const BasicInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Basic Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "Tell buyers about your product",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            /// =========================
            /// Title
            /// =========================

            TextFormField(
              controller: controller.titleController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: AppValidator.productTitle,
              decoration: InputDecoration(
                labelText: "Ad Title *",
                hintText: "Example: Hyundai Creta SX 2022",
                prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 18),

            /// =========================
            /// Price
            /// =========================

            TextFormField(
              controller: controller.priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
              validator: AppValidator.price,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d{0,2}$'),
                ),
              ],
              decoration: InputDecoration(
                labelText: "Price *",
                hintText: "Enter selling price",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    "₹",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 18),

            /// =========================
            /// Description
            /// =========================

            TextFormField(
              controller: controller.descriptionController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.newline,
              validator: AppValidator.description,
              maxLines: 6,
              minLines: 5,
              maxLength: 1000,
              decoration: InputDecoration(
                labelText: "Description *",
                hintText:
                "Describe the product, its condition, features, accessories, warranty, purchase date, and reason for selling.",
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}