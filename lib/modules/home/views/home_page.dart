import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/theme/app_colors.dart';
import 'package:teamomarket/modules/banner/controllers/banner_management_controller.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/middlewares/auth_helper.dart';
import '../../product/widgets/product_card.dart';
import '../../product/widgets/post_card_shimmer.dart';
import '../../product/widgets/product_tile.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_agent_banner.dart';
import '../widgets/home_banner_slider.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});
  final BannerManagementController _bannerManagementController = Get.put(BannerManagementController());
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.white,
       toolbarHeight: 0, // Hide the AppBar
       elevation: 0,
     ),
     body: RefreshIndicator(
       color: AppColors.primary,
       onRefresh: () async {
         _bannerManagementController.loadActiveBanners();
         await controller.fetchProducts();
       },
       child: CustomScrollView(
         controller: controller.scrollController,
         physics: const AlwaysScrollableScrollPhysics(),
         slivers: [

           // Header comes here
           SliverAppBar(
             pinned: true,
             floating: false,
             snap: false,

             automaticallyImplyLeading: false,

             backgroundColor: Colors.white,
             surfaceTintColor: Colors.white,
             elevation: 2,

             toolbarHeight: 110,

             titleSpacing: 0,

             title: SafeArea(
               bottom: false,
               child: Padding(
                 padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                 child: Column(
                   children: [

                     /// Top Row

                     Row(
                       children: [

                         Text.rich(
                           const TextSpan(
                             children: [

                               TextSpan(
                                 text: "Teamo",
                                 style: TextStyle(
                                   color: Colors.black87,
                                   fontWeight: FontWeight.w800,
                                 ),
                               ),

                               TextSpan(
                                 text: "Mart",
                                 style: TextStyle(
                                   color: AppColors.primary,
                                   fontWeight: FontWeight.w800,
                                 ),
                               ),

                             ],
                           ),
                           style: const TextStyle(
                             fontSize: 24,
                             letterSpacing: -.3,
                           ),
                         ),

                         const Spacer(),

                         InkWell(
                           borderRadius: BorderRadius.circular(12),
                           onTap: () {
                             Get.toNamed(AppRoutes.locationPicker);
                           },
                           child: Padding(
                             padding: const EdgeInsets.symmetric(
                               horizontal: 6,
                               vertical: 4,
                             ),
                             child: Row(
                               children: [

                                 const Icon(
                                   Icons.location_on_rounded,
                                   color: AppColors.primary,
                                   size: 20,
                                 ),

                                 const SizedBox(width: 6),

                                 Column(
                                   crossAxisAlignment:
                                   CrossAxisAlignment.start,
                                   children: const [

                                     Text(
                                       "Patna",
                                       style: TextStyle(
                                         fontSize: 14,
                                         fontWeight: FontWeight.w700,
                                       ),
                                     ),

                                     Text(
                                       "Bihar",
                                       style: TextStyle(
                                         fontSize: 11,
                                         color: Colors.grey,
                                       ),
                                     ),

                                   ],
                                 ),

                                 const Icon(
                                   Icons.keyboard_arrow_down_rounded,
                                 ),

                               ],
                             ),
                           ),
                         ),
                       ],
                     ),

                     const SizedBox(height: 14),

                     Row(
                       children: [

                         Expanded(
                           child: InkWell(
                             borderRadius:
                             BorderRadius.circular(16),
                             onTap: () {
                               Get.toNamed(AppRoutes.search);
                             },
                             child: Container(
                               height: 48,
                               padding: const EdgeInsets.symmetric(
                                 horizontal: 16,
                               ),
                               decoration: BoxDecoration(
                                 color: const Color(0xffF7F8FA),
                                 borderRadius:
                                 BorderRadius.circular(16),
                                 border: Border.all(
                                   color: Colors.grey.shade300,
                                 ),
                               ),
                               child: Row(
                                 children: [

                                   const Icon(
                                     Icons.search_rounded,
                                     color: Colors.grey,
                                   ),

                                   const SizedBox(width: 10),

                                   Expanded(
                                     child: Text(
                                       "Search products...",
                                       style: TextStyle(
                                         color: Colors.grey.shade600,
                                       ),
                                     ),
                                   ),

                                 ],
                               ),
                             ),
                           ),
                         ),

                         const SizedBox(width: 10),

                         Material(
                           color: const Color(0xffF7F8FA),
                           borderRadius:
                           BorderRadius.circular(16),
                           child: InkWell(
                             borderRadius:
                             BorderRadius.circular(16),
                             onTap: () async {

                               if (!await AuthHelper.requireLogin(
                                 message:
                                 "Login to access your favourite products.",
                               )) {
                                 return;
                               }

                               Get.toNamed(AppRoutes.favourites);

                             },
                             child: Container(
                               width: 48,
                               height: 48,
                               decoration: BoxDecoration(
                                 border: Border.all(
                                   color: Colors.grey.shade300,
                                 ),
                                 borderRadius:
                                 BorderRadius.circular(16),
                               ),
                               child: const Icon(
                                 Icons.favorite_border_rounded,
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
             ),
           ),
           // Banner comes here
           SliverToBoxAdapter(
             child: Obx(() {
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
           ),

           const SliverToBoxAdapter(
             child: SizedBox(height: 20),
           ),

           const SliverToBoxAdapter(
             child: HomeAgentHelpCard(),
           ),

           const SliverToBoxAdapter(
             child: SizedBox(height: 24),
           ),

           // Products come here
           const SliverToBoxAdapter(
             child: SizedBox(height: 20),
           ),

           /* Padding(
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

                const SizedBox(height: 25),*/
           Obx(() {

             if (controller.isLoading.value) {
               return SliverPadding(
                 padding: const EdgeInsets.symmetric(horizontal: 10),
                 sliver: SliverGrid(
                   delegate: SliverChildBuilderDelegate(
                         (_, __) => const PostCardShimmer(),
                     childCount: 6,
                   ),
                   gridDelegate:
                   const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     crossAxisSpacing: 8,
                     mainAxisSpacing: 8,
                     mainAxisExtent: 285,
                   ),
                 ),
               );
             }

             if (controller.products.isEmpty) {
               return const SliverFillRemaining(
                 hasScrollBody: false,
                 child: Center(
                   child: Text("No products found"),
                 ),
               );
             }

             return SliverPadding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               sliver: SliverGrid(
                 delegate: SliverChildBuilderDelegate(
                       (context, index) {

                     return ProductTile(
                       index: index,
                     );

                   },
                   childCount: controller.products.length,
                 ),
                 gridDelegate:
                 const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   crossAxisSpacing: 8,
                   mainAxisSpacing: 8,
                   mainAxisExtent: 275,
                 ),
               ),
             );
           }),
           SliverToBoxAdapter(
             child: Obx(() {

               if (!controller.isLoadingMore.value) {
                 return const SizedBox.shrink();
               }

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
                   mainAxisExtent: 285,
                 ),
                 itemBuilder: (_, __) => const PostCardShimmer(),
               );

             }),
           ),
           const SliverToBoxAdapter(
             child: SizedBox(height: 20),
           ),

         ],
       ),
     ),
    );
  }}