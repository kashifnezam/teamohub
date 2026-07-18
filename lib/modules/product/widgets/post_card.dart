import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';
import 'package:teamomarket/modules/product/views/product_details_page.dart';
import '../../../app/utils/app_colors.dart';
import '../models/product_model.dart';

class PostCard extends StatelessWidget {
  final ProductModel post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final condition = post.attributes["condition"];
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Get.to(()=> ProductDetailsPage(product: post));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Image
            Stack(
              children: [

                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: post.images.isEmpty
                      ? Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image, size: 40),
                  )
                      : CustomWidget.getImage(post.images.first, shape: BoxShape.rectangle),
                ),

                if (post.attributes["condition"] == "new")
                  Positioned(
                    top: 8,
                    left: 8,
                    child: _badge(
                      "NEW",
                      Colors.green,
                    ),
                  ),

                if (post.isFeatured)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: _badge(
                      "FEATURED",
                      Colors.orange,
                    ),
                  ),

                if (post.isVerified)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: _badge(
                      "VERIFIED",
                      Colors.blue,
                    ),
                  ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.grey.shade700,
                      size: 18,
                    ),
                  ),
                ),

              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [

                      Text(
                        "₹${post.price.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),

                      const Spacer(),
                      if (condition != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            condition,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),

                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          post.city,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [

                      Icon(
                        Icons.remove_red_eye_outlined,
                        size: 13,
                        color: Colors.grey.shade600,
                      ),

                      const SizedBox(width: 2),

                      Text(
                        "${post.views}",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const Spacer(),

                      Icon(
                        Icons.favorite_border,
                        size: 13,
                        color: Colors.grey.shade600,
                      ),

                      const SizedBox(width: 2),

                      Text(
                        "${post.likes}",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
