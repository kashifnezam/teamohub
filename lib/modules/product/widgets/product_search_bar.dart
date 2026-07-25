import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_search_controller.dart';

class ProductSearchBar extends StatelessWidget {
  ProductSearchBar({
    super.key,
    this.hintText = "Search products...",
    this.autofocus = false,
    this.showBackButton = false,
  });

  final String hintText;
  final bool autofocus;
  final bool showBackButton;

  final ProductSearchController controller =
  Get.find<ProductSearchController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        autofocus: autofocus,
        controller: TextEditingController(text: controller.keyword.value)
          ..selection = TextSelection.collapsed(
            offset: controller.keyword.value.length,
          ),
        onChanged: (value) => controller.keyword.value = value,
        textInputAction: TextInputAction.search,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 15,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: showBackButton
                ? IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            )
                : const Icon(
              Icons.search_rounded,
              color: Colors.black54,
              size: 22,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 48,
          ),
          suffixIcon: Obx(() {
            if (controller.keyword.value.isEmpty) {
              return const SizedBox.shrink();
            }

            return IconButton(
              splashRadius: 20,
              icon: const Icon(
                Icons.close_rounded,
                size: 20,
                color: Colors.black54,
              ),
              onPressed: () {
                controller.keyword.value = "";
              },
            );
          }),
        ),
      ),
    );
  }
}