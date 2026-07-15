import 'package:flutter/material.dart';
import '../../../app/utils/app_colors.dart';
import '../../../../../modules/product/models/product_model.dart';

class PostInfoCard extends StatelessWidget {
  final ProductModel post;

  const PostInfoCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //------------------------------------------------
            // Price + Condition
            //------------------------------------------------

            Row(
              children: [

                Expanded(
                  child: Text(
                    "₹${post.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                _conditionChip(
                  post.attributes["condition"] as String?,
                ),

              ],
            ),

            const SizedBox(height: 8),

            //------------------------------------------------
            // Product Title
            //------------------------------------------------

            Text(
              post.title,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            //------------------------------------------------
            // Badges
            //------------------------------------------------

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [

                if (post.isNegotiable)
                  _chip(
                    Icons.handshake_outlined,
                    "Negotiable",
                  ),

                if (post.isFeatured)
                  _chip(
                    Icons.star,
                    "Featured",
                  ),

                if (post.isVerified)
                  _chip(
                    Icons.verified,
                    "Verified",
                  ),

                if (post.isUrgent)
                  _chip(
                    Icons.local_fire_department,
                    "Urgent",
                  ),

              ],
            ),

            const SizedBox(height: 18),

            const Divider(),

            const SizedBox(height: 10),

            //------------------------------------------------
            // Location
            //------------------------------------------------

            Row(
              children: [

                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.red,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    [
                      if (post.area?.trim().isNotEmpty ?? false) post.area,
                      post.city,
                      post.state,
                    ].join(", "),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 14),

            //------------------------------------------------
            // Stats
            //------------------------------------------------

            Row(
              children: [

                _info(
                  Icons.remove_red_eye_outlined,
                  "${post.views} Views",
                ),

                const SizedBox(width: 18),

                _info(
                  Icons.favorite_border,
                  "${post.likes} Likes",
                ),

                const Spacer(),

                Text(
                  _timeAgo(post.createdAt),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
  Widget _chip(
      IconData icon,
      String text,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            size: 16,
            color: AppColors.primary,
          ),

          const SizedBox(width: 6),

          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

        ],
      ),
    );
  }

  Widget _info(
      IconData icon,
      String value,
      ) {
    return Row(
      children: [

        Icon(
          icon,
          size: 18,
          color: Colors.grey,
        ),

        const SizedBox(width: 5),

        Text(
          value,
          style: TextStyle(
            color: Colors.grey.shade700,
          ),
        ),

      ],
    );
  }

  String _timeAgo(DateTime date) {
    final difference = DateTime.now().difference(date);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    }

    if (difference.inHours < 24) {
      return "${difference.inHours} hrs ago";
    }

    if (difference.inDays < 30) {
      return "${difference.inDays} days ago";
    }

    return "${date.day}/${date.month}/${date.year}";
  }

  String _conditionText(String value) {
    return value
        .split('_')
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .join(' ');
  }
  Widget _conditionChip(String? condition) {
    if (condition == null || condition.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _conditionText(condition),
        style: const TextStyle(fontSize: 10),
      ),
    );
  }}