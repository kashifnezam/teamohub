import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/description_card.dart';
import '../widgets/post_image_slider.dart';
import '../widgets/post_info_card.dart';
import '../widgets/seller_card.dart';

class PostDetailsPage extends StatelessWidget {
  final ProductModel post;

  const PostDetailsPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),

      body: CustomScrollView(
        slivers: [

          //------------------------------------------------
          // Image Slider
          //------------------------------------------------

          SliverToBoxAdapter(
            child: PostImageSlider(
              images: post.images,
              post: post,
            ),
          ),

          //------------------------------------------------
          // Product Info
          //------------------------------------------------

          SliverToBoxAdapter(
            child: PostInfoCard(
              post: post,
            ),
          ),

          //------------------------------------------------
          // Description
          //------------------------------------------------

          SliverToBoxAdapter(
            child: DescriptionCard(
             post: post,
            ),
          ),

          //------------------------------------------------
          // Seller
          //------------------------------------------------

          SliverToBoxAdapter(
            child: SellerCard(
              userId: post.sellerId,
            ),
          ),

          //------------------------------------------------
          // Safety Tips
          //------------------------------------------------

        /*  const SliverToBoxAdapter(
            child: SafetyTips(),
          ),
*/
          //------------------------------------------------
          // Similar Products
          //------------------------------------------------

         /* SliverToBoxAdapter(
            child: SimilarProducts(
              categoryId: post.categoryId,
            ),
          ),*/

          const SliverPadding(
            padding: EdgeInsets.only(bottom: 100),
          ),
        ],
      ),

      bottomNavigationBar: BottomActionBar(
        post: post,
      ),
    );
  }
}