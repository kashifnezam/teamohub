import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import 'product_card.dart';

class ProductTile extends GetView<HomeController> {
  const ProductTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final product = controller.products[index];

      return ProductCard(
        product: product,
      );
    });
  }
}