import 'package:flutter/material.dart';

import '../../../app/utils/offline_data.dart';
import '../models/product_image_model.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/description_card.dart';
import '../widgets/post_image_slider.dart';
import '../widgets/post_info_card.dart';
import '../widgets/preview_bottom_bar.dart';
import '../widgets/product_action_infobar.dart';
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
    if(!widget.isPreview && widget.product?.status == ProductStatus.active)
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
          : widget.product == null
          ? null
          : (widget.product!.status == ProductStatus.active &&
          widget.product!.sellerId != userInfo?["id"])
          ? BottomActionBar(
        product: widget.product!,
      )
          : ProductActionInfoBar(
        title: _actionInfo.title,
        message: _actionInfo.message,
        icon: _actionInfo.icon,
        color: _actionInfo.color,
      ),
    );
  }
  _ActionInfo get _actionInfo {
    if (widget.product!.sellerId == userInfo?["id"]) {
      return const _ActionInfo(
        title: "Your Product",
        message:
        "This listing belongs to you. You can't start a conversation with yourself.",
        icon: Icons.storefront_outlined,
        color: Colors.blue,
      );
    }

    switch (widget.product!.status) {
      case ProductStatus.inactive:
        return const _ActionInfo(
          title: "Communication Disabled",
          message:
          "This listing is currently inactive. The seller must reactivate it before buyers can chat or make offers.",
          icon: Icons.pause_circle_outline,
          color: Colors.orange,
        );

      case ProductStatus.draft:
        return const _ActionInfo(
          title: "Awaiting Approval",
          message:
          "This listing is under review. Communication will be enabled once it is approved.",
          icon: Icons.hourglass_top_outlined,
          color: Colors.amber,
        );

      case ProductStatus.rejected:
        return const _ActionInfo(
          title: "Listing Unavailable",
          message:
          "This listing was rejected and is not available for communication.",
          icon: Icons.cancel_outlined,
          color: Colors.red,
        );

      case ProductStatus.sold:
        return const _ActionInfo(
          title: "Product Sold",
          message:
          "This product has been sold. Communication has been disabled for this listing.",
          icon: Icons.check_circle_outline,
          color: Colors.green,
        );

      default:
        return const _ActionInfo(
          title: "Communication Disabled",
          message:
          "Communication is currently unavailable for this listing.",
          icon: Icons.info_outline,
          color: Colors.grey,
        );
    }
  }
}

class _ActionInfo {
  final String title;
  final String message;
  final IconData icon;
  final Color color;

  const _ActionInfo({
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
  });
}