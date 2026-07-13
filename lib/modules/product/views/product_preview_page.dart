import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import 'post_details_page.dart';

class ProductPreviewPage extends GetView<ProductController> {
  const ProductPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final product = controller.buildProductModel();

      return PostDetailsPage(
        post: product,
        previewImages: controller.images,
        isPreview: true,
      );
    });
  }
}