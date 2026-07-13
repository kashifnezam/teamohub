import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class PreviewBottomBar extends GetView<ProductController> {
  const PreviewBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: Row(
        children: [

          Expanded(
            child: OutlinedButton(
              onPressed: Get.back,
              child: const Text("Edit"),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            flex: 2,
            child: FilledButton(
              onPressed: controller.publishProduct,
              child: const Text("Publish Ad"),
            ),
          ),

        ],
      ),
    );
  }
}