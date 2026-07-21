import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/utils/app_colors.dart';
import 'package:teamomarket/modules/banner/controllers/banner_management_controller.dart';
import 'package:teamomarket/modules/home/widgets/image_category.dart';
import '../../product/widgets/post_card.dart';
import '../../category/repositories/category_list.dart';
import '../../product/widgets/post_card_shimmer.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_banner_slider.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});
  final BannerManagementController _bannerManagementController = Get.put(BannerManagementController());
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: AppColors.primary,
       toolbarHeight: 0, // Hide the AppBar
       elevation: 0,
     ),
    body: Column(
      children: [

      Material(
      elevation: 1,
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
          child: Column(
            children: [

              Row(
                children: [

                  Text.rich(
                    const TextSpan(
                      children: [
                        TextSpan(
                          text: "Teamo",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "Mart",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),

                  const Spacer(),

                  // InkWell(
                  //   borderRadius: BorderRadius.circular(20),
                  //   onTap: () {},
                  //   child: const Padding(
                  //     padding: EdgeInsets.all(6),
                  //     child: Icon(
                  //       Icons.notifications_none_rounded,
                  //       size: 22,
                  //     ),
                  //   ),
                  // ),
                  //
                  // InkWell(
                  //   borderRadius: BorderRadius.circular(20),
                  //   onTap: () {},
                  //   child: const Padding(
                  //     padding: EdgeInsets.all(6),
                  //     child: Icon(
                  //       Icons.person_outline_rounded,
                  //       size: 22,
                  //     ),
                  //   ),
                  // ),

                ],
              ),

              const SizedBox(height: 8),

              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xffE5E7EB),
                    ),
                  ),
                  child: Row(
                    children: [

                      const Icon(
                        Icons.search_rounded,
                        size: 20,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 10),

                      const Expanded(
                        child: Text(
                          "Search products...",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 3),
                            Text(
                              "Patna",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ),

        SizedBox(height: 5),
        /// IMPORTANT
        Expanded(
          child: RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              _bannerManagementController.loadActiveBanners();
              controller.fetchProducts();
            },
            child: ListView(
              controller: controller.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 20),
              children: [

                //----------------------------------
                // Banner
                //----------------------------------

                Obx(() {
                  if (_bannerManagementController.activeBanners.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return HomeBannerSlider(
                    isNetwork: true,
                    images: _bannerManagementController.activeBanners
                        .map((e) => e.imageUrl)
                        .toList(),
                    onTap: (index) {
                      _bannerManagementController.onBannerTap(
                        _bannerManagementController.activeBanners[index],
                      );
                    },
                  );
                }),

                const SizedBox(height: 20),

                //----------------------------------
                // Categories
                //----------------------------------

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: LayoutBuilder(
                    builder: (context, constraints) {

                      const itemWidth = 65.0;

                      final itemsPerRow =
                      (constraints.maxWidth / itemWidth)
                          .floor()
                          .clamp(3, 6);

                      final spacing = itemsPerRow > 1
                          ? (constraints.maxWidth -
                          (itemsPerRow * itemWidth)) /
                          (itemsPerRow - 1)
                          : 0.0;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: 10,
                        children: categories
                            .map(
                              (category) => SizedBox(
                            width: itemWidth,
                            child: ImageCategory(
                              image: category.image,
                              title: category.name,
                            ),
                          ),
                        )
                            .toList(),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                //----------------------------------
                // Latest Posts
                //----------------------------------

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Latest Listings",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Obx(() {
                  if (controller.isLoading.value) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: 6,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.61,
                      ),
                      itemBuilder: (_, __) => const PostCardShimmer(),
                    );
                  }

                  if (controller.products.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("No products found"),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: controller.products.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.61,
                    ),
                    itemBuilder: (context, index) {
                      return PostCard(
                        post: controller.products[index],
                      );
                    },
                  );
                }),
                Obx(() {
                  if (!controller.isLoadingMore.value) {
                    return const SizedBox.shrink();
                  }

                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

      ],
    ),
    );
  }}