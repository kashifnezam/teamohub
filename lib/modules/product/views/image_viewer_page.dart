import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/utils/app_colors.dart';
import '../../favourite/controllers/favourite_controller.dart';
import '../models/product_image_model.dart';

class ImageViewerPage extends StatefulWidget {
  final List<ProductImageModel> images;
  final int initialIndex;
  final String heroTag;
  final String productId;
  /// Hide favourite/share while previewing
  final bool isPreview;

  const ImageViewerPage({
    super.key,
    required this.images,
    required this.productId,
    this.initialIndex = 0,
    required this.heroTag,
    this.isPreview = false,
  });

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  late final PageController _controller;
  late int currentIndex;
  final FavouriteController favouriteController =  Get.find<FavouriteController>();

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    _controller = PageController(
      initialPage: widget.initialIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [

          //--------------------------------------------------
          // Gallery
          //--------------------------------------------------

          PhotoViewGallery.builder(
            pageController: _controller,
            itemCount: widget.images.length,

            builder: (_, index) {

              final image = widget.images[index];

              return PhotoViewGalleryPageOptions(
                imageProvider: image.file != null
                    ? FileImage(image.file!)
                    : CachedNetworkImageProvider(image.url!),
                heroAttributes: PhotoViewHeroAttributes(
                  tag: "${widget.heroTag}$index",
                ),

                minScale: PhotoViewComputedScale.contained,

                maxScale: PhotoViewComputedScale.covered * 4,
              );
            },

            loadingBuilder: (_, __) =>
            const Center(
              child: CircularProgressIndicator(),
            ),

            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),

          //--------------------------------------------------
          // Top Bar
          //--------------------------------------------------

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [

                  _circleButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Get.back(),
                  ),

                  const Spacer(),

                  if (!widget.isPreview) ...[

                    Obx(() =>  _circleButton(
                      icon: favouriteController.isFavourite(widget.productId)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      onTap: () =>  favouriteController.toggleFavourite(widget.productId),
                      color: favouriteController.isFavourite(widget.productId)
                          ? Colors.red
                          : Colors.grey,
                    ),),


                    const SizedBox(width: 10),

                    _circleButton(
                      icon: Icons.share_outlined,
                      onTap: () {},
                    ),

                  ],

                ],
              ),
            ),
          ),

          //--------------------------------------------------
          // Indicator
          //--------------------------------------------------

          if (widget.images.length > 1)

            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: currentIndex,
                  count: widget.images.length,
                  effect: WormEffect(
                    activeDotColor:
                    AppColors.primary,
                    dotColor:
                    Colors.white38,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
              ),
            ),
        ],
      ),
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
          width: 42,
          height: 42,
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
      ),
    );
  }
}