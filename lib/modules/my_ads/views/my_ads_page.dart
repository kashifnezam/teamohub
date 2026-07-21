import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/modules/product/controllers/product_controller.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/widgets/custom_widget.dart';
import '../../product/models/product_model.dart';
import '../controllers/my_ads_controller.dart';

class MyAdsPage extends GetView<MyAdsController> {
  const MyAdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("My Ads"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.categories);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CustomWidget.buildCircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.refreshAds,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              //--------------------------------------------------
              // Statistics
              //--------------------------------------------------
          /*    Row(
                children: [
                  Expanded(
                    child: _statCard(
                      context,
                      title: "Total",
                      value: controller.totalAds.toString(),
                      icon: Icons.inventory_2_outlined,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _statCard(
                      context,
                      title: "Active",
                      value: controller.activeAds.toString(),
                      icon: Icons.check_circle_outline,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      context,
                      title: "Sold",
                      value: controller.soldAds.toString(),
                      icon: Icons.sell_outlined,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _statCard(
                      context,
                      title: "Draft",
                      value: controller.draftAds.toString(),
                      icon: Icons.edit_note_outlined,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
*/
              //--------------------------------------------------
              // Search
              //--------------------------------------------------
              TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: "Search your ads...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: controller.searchController.text.isEmpty
                      ? null
                      : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: controller.clearSearch,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //--------------------------------------------------
              // Filters
              //--------------------------------------------------
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _filterChip("All"),
                    _filterChip("Active"),
                    _filterChip("Inactive"),
                    _filterChip("Sold"),
                    _filterChip("Rejected"),
                    _filterChip("Draft"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //--------------------------------------------------
              // Products
              //--------------------------------------------------
              Obx(() {
                if (controller.filteredProducts.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 40,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 72,
                          color: Colors.grey.shade400,
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "No Ads Found",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          controller.searchController.text.isNotEmpty
                              ? "No ads match your search."
                              : "You haven't posted anything yet.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),

                        const SizedBox(height: 24),

                        FilledButton.icon(
                          onPressed: () {
                            Get.toNamed(Routes.categories);
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Sell Product"),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.filteredProducts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];
                    return GestureDetector(
                        onTap: () => ProductController().getProductDetail(product.id),
                        child: _productCard(context, product));
                  },
                );
              }),

              const SizedBox(height: 100),
            ],
          ),
        );
      }),
    );
  }

  //--------------------------------------------------
  // Filter Chip
  //--------------------------------------------------

  Widget _filterChip(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Obx(() {
        final selected = controller.selectedFilter.value == title;

        return FilterChip(
          label: Text(title),
          selected: selected,
          onSelected: (_) => controller.changeFilter(title),
        );
      }),
    );
  }
  //--------------------------------------------------
  // Product Card
  //--------------------------------------------------

  Widget _productCard(BuildContext context, ProductModel product) {
    final location = [
      product.area,
      product.city,
      product.state,
    ].where((e) => e != null && e.trim().isNotEmpty).join(', ');

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CustomWidget.getImage(
                    product.images.isNotEmpty ? product.images.first : "",
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "₹ ${product.price}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        location,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 8),

                      _statusBadge(product.status.name),
                    ],
                  ),
                ),

                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case "edit":
                        controller.editProduct(product);
                        break;

                      case "share":
                        controller.shareProduct(product);
                        break;

                      case "sold":
                        controller.markSold(product);
                        break;

                      case "activate":
                        controller.updateStatus(product, active: true);
                        break;

                      case "inactive":
                        controller.updateStatus(product);
                        break;

                      case "delete":
                        CustomWidget.confirmDialogue(
                          title: "Delete Product",
                          content: "Delete this product permanently?",
                          confirm: "Delete",
                        ).then((ok) {
                          if (ok == true) {
                            controller.deleteProduct(product);
                          }
                        });
                        break;
                    }
                  },
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: "edit",
                      child: Text("Edit"),
                    ),
                    const PopupMenuItem(
                      value: "share",
                      child: Text("Share"),
                    ),
                    const PopupMenuItem(
                      value: "sold",
                      child: Text("Mark Sold"),
                    ),

                    // Show Activate or Deactivate based on current status
                    if (product.status.name.toLowerCase() == "inactive")
                      const PopupMenuItem(
                        value: "activate",
                        child: Text("Activate"),
                      )
                    else if (product.status.name.toLowerCase() == "active")
                      const PopupMenuItem(
                        value: "inactive",
                        child: Text("Deactivate"),
                      ),

                    const PopupMenuDivider(),

                    const PopupMenuItem(
                      value: "delete",
                      child: Text("Delete"),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------------------------
  // Status Badge
  //--------------------------------------------------

  Widget _statusBadge(String status) {
    print(status);
    Color color;

    switch (status.toLowerCase()) {
      case "active":
        color = Colors.green;
        break;

      case "sold":
        color = Colors.blue;
        break;

      case "inactive":
        color = Colors.orange;
        break;

      case "draft":
        color = Colors.grey;
        break;

      case "rejected":
        color = Colors.red;
        break;

      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }

  //--------------------------------------------------
  // Statistics Card
  //--------------------------------------------------

  Widget _statCard(
      BuildContext context, {
        required String title,
        required String value,
        required IconData icon,
      }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),

          const SizedBox(height: 12),

          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Text(title, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
