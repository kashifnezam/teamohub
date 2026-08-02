import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/theme/app_colors.dart';
import '../../../../../modules/product/models/product_model.dart';
import '../../../app/widgets/custom_widget.dart';
import '../../favourite/controllers/favourite_controller.dart';
import '../controllers/product_controller.dart';
import '../models/product_image_model.dart';
import '../views/image_viewer_page.dart';

class PostImageSlider extends StatefulWidget {
  final List<ProductImageModel> images;

  /// Null while previewing
  final ProductModel? product;

  /// Preview Mode
  final bool isPreview;

  const PostImageSlider({
    super.key,
    required this.images,
    this.product,
    this.isPreview = false,
  });

  @override
  State<PostImageSlider> createState() => _PostImageSliderState();
}

class _PostImageSliderState extends State<PostImageSlider> {
  int currentIndex = 0;
  final favouriteController = Get.find<FavouriteController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        //------------------------------------------------
        // Image Slider
        //------------------------------------------------

        CarouselSlider.builder(
          itemCount: widget.images.isEmpty ? 1 : widget.images.length,
          itemBuilder: (_, index, __) {

            if (widget.images.isEmpty) {
              return Container(
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image,
                  size: 80,
                  color: Colors.grey,
                ),
              );
            }

            return GestureDetector(
              onTap: () {
                Get.to(
                      () => ImageViewerPage(
                    images: widget.images,
                    productId: widget.product!.id,
                    initialIndex: index,
                    heroTag: widget.product?.id ?? "preview",
                  ),
                );
              },
              child: Hero(
                tag: "${widget.product?.id ?? 'preview'}$index",
                child: _buildImage(widget.images[index]),
              )
            );
          },
          options: CarouselOptions(
            height: 320,
            viewportFraction: 1,
            autoPlay: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),

        //------------------------------------------------
        // Gradient
        //------------------------------------------------

        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: .35),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: .15),
                  ],
                ),
              ),
            ),
          ),
        ),

        //------------------------------------------------
        // Top Buttons
        //------------------------------------------------

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Row(
              children: [

                _circleButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Get.back(),
                ),

                const Spacer(),

               if(!widget.isPreview)
               Obx(() =>  _circleButton(
                 icon: favouriteController.isFavourite(widget.product!.id)
                     ? Icons.favorite
                     : Icons.favorite_border,
                 onTap: () =>  favouriteController.toggleFavourite(widget.product!.id),
                 color: favouriteController.isFavourite(widget.product!.id)
                     ? Colors.red
                     : Colors.grey,
               ),),

                const SizedBox(width: 10),

                if(!widget.isPreview)
                _circleButton(
                  icon: Icons.share_outlined,
                  onTap: () {
                    Get.find<ProductController>().shareProduct(widget.product!.id);

                  },
                ),

              ],
            ),
          ),
        ),

        //------------------------------------------------
        // NEW Badge
        //------------------------------------------------

        if (widget.product!.attributes["condition"] == "new")
          Positioned(
            bottom: 18,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: _badge(
                "NEW",
                Colors.green,
              ),
            ),
          ),

        //------------------------------------------------
        // Featured
        //------------------------------------------------

        if (!widget.isPreview && widget.product!.isFeatured)
          Positioned(
            left: 12,
            bottom: 18,
            child: _badge(
              "FEATURED",
              Colors.orange,
            ),
          ),

        //------------------------------------------------
        // Verified
        //------------------------------------------------

        if (!widget.isPreview && widget.product!.isVerified)
          Positioned(
            right: 12,
            bottom: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [

                  Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: 14,
                  ),

                  SizedBox(width: 4),

                  Text(
                    "Verified",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ],
              ),
            ),
          ),

        //------------------------------------------------
        // Indicator
        //------------------------------------------------

        if (widget.images.length > 1)
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                count: widget.images.length,
                effect: WormEffect(
                  activeDotColor: AppColors.primary,
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: Colors.white70,
                ),
              ),
            ),
          ),

      ],
    );
  }

  Widget _buildImage(ProductImageModel image) {
    if (image.file != null) {
      return SizedBox.expand(
        child: Image.file(
          image.file!,
          fit: BoxFit.cover,
        ),
      );
    }

    return CustomWidget.getImage(
      image.url!,
      width: double.infinity,
      height: double.infinity,
      shape: BoxShape.rectangle,
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
  Color color = Colors.white
  }) {
    return Material(
      color: Colors.black45,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            color: color,
            size: 23,
          ),
        ),
      ),
    );
  }

  Widget _badge(
      String text,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}