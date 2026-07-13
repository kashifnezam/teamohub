import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/utils/app_colors.dart';
import '../../../../../modules/product/models/product_model.dart';
import '../models/product_image_model.dart';
import '../views/image_viewer_page.dart';

class PostImageSlider extends StatefulWidget {
  final List<ProductImageModel> images;

  /// Null while previewing
  final ProductModel? post;

  /// Preview Mode
  final bool isPreview;

  const PostImageSlider({
    super.key,
    required this.images,
    this.post,
    this.isPreview = false,
  });

  @override
  State<PostImageSlider> createState() => _PostImageSliderState();
}

class _PostImageSliderState extends State<PostImageSlider> {
  int currentIndex = 0;

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
                    initialIndex: index,
                    heroTag: widget.post?.id ?? "preview",
                  ),
                );
              },
              child: Hero(
                tag: "${widget.post?.id ?? 'preview'}$index",
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
                    Colors.black.withOpacity(.35),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(.15),
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

                _circleButton(
                  icon: Icons.favorite_border,
                  onTap: () {},
                ),

                const SizedBox(width: 10),

                _circleButton(
                  icon: Icons.share_outlined,
                  onTap: () {},
                ),

              ],
            ),
          ),
        ),

        //------------------------------------------------
        // NEW Badge
        //------------------------------------------------

        if (!widget.isPreview && widget.post!.isNew)
          Positioned(
            left: 12,
            top: 80,
            child: _badge(
              "NEW",
              Colors.green,
            ),
          ),

        //------------------------------------------------
        // Featured
        //------------------------------------------------

        if (!widget.isPreview && widget.post!.isFeatured)
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

        if (!widget.isPreview && widget.post!.isVerified)
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
      return Image.file(
        image.file!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return Image.network(
      image.url!,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) {
        return Container(
          color: Colors.grey.shade200,
          child: const Icon(Icons.broken_image),
        );
      },
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.black45,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
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