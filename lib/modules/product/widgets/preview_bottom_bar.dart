import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class PreviewBottomBar extends GetView<ProductController> {
  const PreviewBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: Obx(() {
        final loading = controller.isLoading.value;

        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: loading ? null : Get.back,
                child: const Text("Edit"),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: loading ? null : controller.publishProduct,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: loading
                      ? const Row(
                    key: ValueKey("loading"),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text("Publishing..."),
                    ],
                  )
                      : const Text(
                    "Publish Ad",
                    key: ValueKey("text"),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}