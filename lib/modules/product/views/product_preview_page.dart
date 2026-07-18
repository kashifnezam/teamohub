import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import 'product_details_page.dart';

class ProductPreviewPage extends GetView<ProductController> {
  const ProductPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final product = controller.buildProductModel();

      return ProductDetailsPage(
        product: product,
        previewImages: controller.images,
        isPreview: true,
      );
    });
  }
}