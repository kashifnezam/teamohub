import 'package:flutter/material.dart';

import '../models/product_image_model.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/description_card.dart';
import '../widgets/post_image_slider.dart';
import '../widgets/post_info_card.dart';
import '../widgets/preview_bottom_bar.dart';
import '../widgets/seller_card.dart';

class ProductDetailsPage extends StatefulWidget {
  /// Existing product (published)
  final ProductModel? product;

  /// Preview images
  final List<ProductImageModel>? previewImages;

  /// Preview mode
  final bool isPreview;

  const ProductDetailsPage({
    super.key,
    this.product,
    this.previewImages,
    this.isPreview = false,
  }) : assert(
  (isPreview && previewImages != null && product != null) ||
      (!isPreview && product != null),
  'Preview requires previewImages and post.',
  );

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final repository = ProductRepository();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      repository.registerView(
        productId: widget.product!.id,
        sellerId: widget.product!.sellerId,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),

      body: CustomScrollView(
        slivers: [
          //------------------------------------------------
          // Images
          //------------------------------------------------

          SliverToBoxAdapter(
            child: PostImageSlider(
              images: widget.isPreview
                  ? widget.previewImages!
                  : widget.product!.images
                  .map(
                    (url) => ProductImageModel(
                  url: url,
                ),
              )
                  .toList(),
              product: widget.product,
              isPreview: widget.isPreview,
            ),
          ),

          //------------------------------------------------
          // Product Info
          //------------------------------------------------

          SliverToBoxAdapter(
            child: PostInfoCard(
              post: widget.product!,
            ),
          ),

          //------------------------------------------------
          // Description
          //------------------------------------------------

          SliverToBoxAdapter(
            child: DescriptionCard(
              post: widget.product!,
              isPreview: widget.isPreview,
            ),
          ),

          //------------------------------------------------
          // Seller
          //------------------------------------------------

          if (!widget.isPreview)
            SliverToBoxAdapter(
              child: SellerCard(
                product: widget.product!
              ),
            ),

          //------------------------------------------------
          // Bottom spacing
          //------------------------------------------------

          const SliverPadding(
            padding: EdgeInsets.only(bottom: 10),
          ),
        ],
      ),

      //------------------------------------------------
      // Bottom Bar
      //------------------------------------------------

      bottomNavigationBar: widget.isPreview
          ? const PreviewBottomBar()
          : BottomActionBar(
        product: widget.product!,
      ),
    );
  }
}