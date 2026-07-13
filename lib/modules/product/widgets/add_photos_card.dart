import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/utils/app_colors.dart';

import '../controllers/product_controller.dart';
import '../models/product_image_model.dart';

class AddPhotosCard extends GetView<ProductController> {
  const AddPhotosCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Obx(() {
          final images = controller.images;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //------------------------------------------------
              // Header
              //------------------------------------------------

              Row(
                children: [

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Product Photos",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "The first photo will be your cover photo.",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _countBadge(
                    images.length,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              //------------------------------------------------
              // Grid
              //------------------------------------------------

              AnimatedContainer(
                duration:
                const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(18),
                  border: Border.all(
                    color: controller.imagesError.value
                        ? theme.colorScheme.error
                        : Colors.transparent,
                  ),
                ),
                child: images.isEmpty
                    ? _buildEmptyState(theme)
                    : _buildGrid(images),
              ),

              //------------------------------------------------
              // Error
              //------------------------------------------------

              if (controller.imagesError.value)
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10),
                  child: Text(
                    "Please upload at least one photo.",
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              //------------------------------------------------
              // Tip
              //------------------------------------------------

              Row(
                children: [

                  Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: Colors.amber.shade700,
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: Text(
                      "Listings with 5+ photos usually get more buyer interest.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),

                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  //------------------------------------------------
  // Empty State
  //------------------------------------------------

  Widget _buildEmptyState(
      ThemeData theme,
      ) {
    return InkWell(
      borderRadius:
      BorderRadius.circular(18),
      onTap: controller.pickImages,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius:
          BorderRadius.circular(18),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 28,
              backgroundColor:
              theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.add_photo_alternate_outlined,
                color:
                theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Add Product Photos",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "Tap to select up to 20 photos",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //------------------------------------------------
  // Grid
  //------------------------------------------------

  Widget _buildGrid(
      List<ProductImageModel> images,
      ) {
    return GridView.builder(
      shrinkWrap: true,
      physics:
      const NeverScrollableScrollPhysics(),
      itemCount:
      controller.canAddMoreImages
          ? images.length + 1
          : images.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (_, index) {

        //------------------------------------------------
        // Add Button
        //------------------------------------------------

        if (controller.canAddMoreImages &&
            index == images.length) {
          return InkWell(
            borderRadius:
            BorderRadius.circular(16),
            onTap: controller.pickImages,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius:
                BorderRadius.circular(16),
                border: Border.all(
                  color:
                  Colors.grey.shade300,
                ),
              ),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: const [

                  Icon(Icons.add),

                  SizedBox(height: 6),

                  Text(
                    "Add",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final image = images[index];

        return Stack(
          children: [

            //------------------------------------------------
            // Image
            //------------------------------------------------

            ClipRRect(
              borderRadius:
              BorderRadius.circular(16),
              child: Image(
                image:
                image.imageProvider,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            //------------------------------------------------
            // Delete
            //------------------------------------------------

            Positioned(
              top: 6,
              right: 6,
              child: Material(
                color: Colors.white,
                shape:
                const CircleBorder(),
                elevation: 2,
                child: InkWell(
                  customBorder:
                  const CircleBorder(),
                  onTap: () =>
                      controller.removeImage(
                          index),
                  child: const Padding(
                    padding:
                    EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),

            //------------------------------------------------
            // Cover Badge
            //------------------------------------------------

            if (image.isCover)
              Positioned(
                left: 6,
                bottom: 6,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius:
                    BorderRadius.circular(
                        30),
                  ),
                  child: const Row(
                    mainAxisSize:
                    MainAxisSize.min,
                    children: [

                      Icon(
                        Icons.star,
                        size: 10,
                        color:
                        Colors.white,
                      ),

                      SizedBox(width: 4),

                      Text(
                        "Cover",
                        style: TextStyle(
                          color:
                          Colors.white,
                          fontSize: 10,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  //------------------------------------------------
  // Counter Badge
  //------------------------------------------------

  Widget _countBadge(int count) {

    Color color;

    if (count == 0) {
      color = Colors.red;
    } else if (count < 5) {
      color = Colors.orange;
    } else {
      color = Colors.green;
    }

    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius:
        BorderRadius.circular(30),
      ),
      child: Text(
        "$count/${ProductController.maxImages}",
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}