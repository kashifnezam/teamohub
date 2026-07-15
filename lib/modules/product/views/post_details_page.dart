import 'package:flutter/material.dart';

import '../models/product_image_model.dart';
import '../models/product_model.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/description_card.dart';
import '../widgets/post_image_slider.dart';
import '../widgets/post_info_card.dart';
import '../widgets/preview_bottom_bar.dart';
import '../widgets/seller_card.dart';

class PostDetailsPage extends StatelessWidget {
  /// Existing product (published)
  final ProductModel? product;

  /// Preview images
  final List<ProductImageModel>? previewImages;

  /// Preview mode
  final bool isPreview;

  const PostDetailsPage({
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
              images: isPreview
                  ? previewImages!
                  : product!.images
                  .map(
                    (url) => ProductImageModel(
                  url: url,
                ),
              )
                  .toList(),
              post: product,
              isPreview: isPreview,
            ),
          ),

          //------------------------------------------------
          // Product Info
          //------------------------------------------------

          SliverToBoxAdapter(
            child: PostInfoCard(
              post: product!,
            ),
          ),

          //------------------------------------------------
          // Description
          //------------------------------------------------

          SliverToBoxAdapter(
            child: DescriptionCard(
              post: product!,
              isPreview: isPreview,
            ),
          ),

          //------------------------------------------------
          // Seller
          //------------------------------------------------

          if (!isPreview)
            SliverToBoxAdapter(
              child: SellerCard(
                userId: product!.sellerId,
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

      bottomNavigationBar: isPreview
          ? const PreviewBottomBar()
          : BottomActionBar(
        product: product!,
      ),
    );
  }
}