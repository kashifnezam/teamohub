import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/modules/product/models/product_model.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/utils/custom_alert.dart';
import '../../../../app/widgets/custom_widget.dart';
import '../../../product/views/product_details_page.dart';
import '../../controllers/agent_my_listings_controller.dart';
import '../../models/agent_listing_model.dart';
import '../../models/agent_product_listing_model.dart';

class AgentMyListingsView extends GetView<AgentMyListingsController> {
  const AgentMyListingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        title: const Text("My Listings"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return CustomWidget.buildCircularProgressIndicator();
        }

        if (controller.listings.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 70,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                const Text(
                  "No Listings Yet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Accept a client request to create your first listing.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshListings,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.listings.length,
            separatorBuilder: (_, __) => const SizedBox(height: 18),
            itemBuilder: (_, index) {
              final item = controller.listings[index];
              return _ListingCard(
                item: item,
              );
            },
          ),
        );
      }),
    );
  }
}
class _ListingCard extends GetView<AgentMyListingsController> {
  const _ListingCard({required this.item});

  final AgentProductListingModel item;

  AgentListingModel get listing => item.listing;

  ProductModel get product => item.product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xffE8EAF3),
        ),
      ),
        child: Padding(
          padding:
          const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: product.images.isNotEmpty
                            ? Image.network(
                          product.images.first,
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          width: double.infinity,
                          height: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigo.shade50,
                                Colors.indigo.shade100,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 70,
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 14,
                        left: 14,
                        child: _StatusBadge(product.status),
                      ),

                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "₹ ${product.price.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "${product.city}, ${product.state}",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.sell_outlined,
                              size: 15,
                              color: Colors.indigo.shade700,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              product.categoryName ?? "Others",
                              style: TextStyle(
                                color: Colors.indigo.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffF8F9FD),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xffECEFF5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _MetricItem(
                      icon: Icons.visibility_outlined,
                      title: "Views",
                      value: product.views,
                      color: Colors.indigo,
                    ),
                    _MetricDivider(),
                    _MetricItem(
                      icon: Icons.chat_bubble_outline,
                      title: "Chats",
                      value: product.chats,
                      color: Colors.green,
                    ),
                    // _MetricDivider(),
                    // _MetricItem(
                    //   icon: Icons.share_outlined,
                    //   title: "Shares",
                    //   value: product.shares,
                    //   color: Colors.orange,
                    // ),
                    _MetricDivider(),
                    _MetricItem(
                      icon: Icons.favorite_border,
                      title: "Likes",
                      value: product.likes,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.visibility_outlined),
                      label: const Text(
                        "View Listing",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        Get.to(()=> ProductDetailsPage(product: product));
                      },
                    ),
                  ),

                 /* const SizedBox(width: 12),

                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(
                          AppRoutes.agentCreateListing,
                          arguments: listing,
                        );
                      },
                      child: const Icon(Icons.edit_outlined),
                    ),
                  ),
*/
                  const SizedBox(width: 12),

                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        _showListingActions(
                          context,
                          controller,
                          item,
                        );
                      },
                      child: const Icon(Icons.more_horiz),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
  void _showListingActions(
      BuildContext context,
      AgentMyListingsController controller,
      AgentProductListingModel item,
      ) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              _ActionTile(
                icon: Icons.share_outlined,
                title: "Share Listing",
                onTap: () {
                  Get.back();

                  Get.toNamed(
                    AppRoutes.agentListingShare,
                    arguments: listing.agentProductId,
                  );
                },
              ),

              // _ActionTile(
              //   icon: Icons.edit_outlined,
              //   title: "Edit Listing",
              //   onTap: () {
              //     Get.back();
              //
              //     Get.toNamed(
              //       AppRoutes.agentCreateListing,
              //       arguments: listing,
              //     );
              //   },
              // ),

              if (item.product.status != ProductStatus.sold)

                _ActionTile(
                  icon: Icons.check_circle_outline,
                  title: "Mark as Sold",
                  color: Colors.green,
                  onTap: () async {
                    Get.back();

                    final confirm = await CustomAlert.confirmAlert(
                      title: "Complete Deal",
                      "Mark this listing as sold?",
                    );

                    if (confirm == true) {
                      await controller.markSold(item);
                      controller.refreshListings();
                    }
                  },
                ),

              if (item.product.isActive)

                _ActionTile(
                  icon: Icons.pause_circle_outline,
                  title: "Deactivate Listing",
                  color: Colors.red,
                  onTap: () async {
                    Get.back();

                    final confirm = await CustomAlert.confirmAlert(
                      title: "Deactivate",
                      "Deactivate this listing?",
                    );

                    if (confirm == true) {
                      await controller.deactivate(item);
                      controller.refreshListings();
                    }
                  },
                ),

              if (!item.product.isActive)

                _ActionTile(
                  icon: Icons.play_circle_outline,
                  title: "Activate Listing",
                  color: Colors.green,
                  onTap: () async {
                    Get.back();
                    await controller.activate(item);
                    controller.refreshListings();
                  },
                ),

              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? Colors.black87;

    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: iconColor.withValues(alpha: .12),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
      ),
      onTap: onTap,
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.status);

  final ProductStatus status;

  @override
  Widget build(BuildContext context) {
    late Color background;
    late IconData icon;
    late String text;

    switch (status) {
      case ProductStatus.active:
        background = Colors.green;
        icon = Icons.check_circle;
        text = "LIVE";
        break;

      case ProductStatus.inactive:
        background = Colors.red;
        icon = Icons.pause_circle;
        text = "OFF";
        break;

      case ProductStatus.sold:
        background = Colors.black87;
        icon = Icons.sell;
        text = "SOLD";
        break;

      case ProductStatus.rejected:
        background = Colors.deepOrange;
        icon = Icons.cancel;
        text = "REJECTED";
        break;

      case ProductStatus.expired:
        background = Colors.orange;
        icon = Icons.schedule;
        text = "EXPIRED";
        break;

      default:
        background = Colors.blueGrey;
        icon = Icons.hourglass_empty;
        text = "DRAFT";
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 10,
              letterSpacing: .4,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
class _MetricDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 48,
      color: const Color(0xffE7EAF3),
    );
  }
}
