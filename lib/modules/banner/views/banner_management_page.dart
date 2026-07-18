import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/utils/app_colors.dart';
import '../../../app/widgets/custom_widget.dart';
import '../controllers/banner_management_controller.dart';
import '../models/banner_model.dart';

class BannerManagementPage extends GetView<BannerManagementController> {
  const BannerManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Banner Management"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Row(
              children: [
                Obx(
                      () => Text(
                    "${controller.allBanners.length} Banner(s)",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),

                const Spacer(),

                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () async {
                    final result = await Get.toNamed(
                      Routes.bannerForm,
                    );

                    if (result == true) {
                      controller.loadAllBanners();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Banner"),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.allBanners.isEmpty) {
                return RefreshIndicator(
                  onRefresh: controller.loadAllBanners,
                  child: ListView(
                    children: const [

                      SizedBox(height: 120),

                      Icon(
                        Icons.photo_library_outlined,
                        size: 70,
                        color: Colors.grey,
                      ),

                      SizedBox(height: 16),

                      Center(
                        child: Text(
                          "No banners found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(height: 8),

                      Center(
                        child: Text(
                          "Tap Add Banner to create one.",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.loadAllBanners,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  itemCount: controller.allBanners.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
                  itemBuilder: (_, index) {
                    final banner = controller.allBanners[index];

                    return _BannerCard(
                      banner: banner,
                      onEdit: () async {
                        final result = await Get.toNamed(
                          Routes.bannerForm,
                          arguments: banner,
                        );

                        if (result == true) {
                          controller.loadAllBanners();
                        }
                      },
                      onDelete: () {
                        controller.deleteBanner(banner);
                      },
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({
    required this.banner,
    required this.onEdit,
    required this.onDelete,
  });

  final BannerModel banner;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Banner Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: CustomWidget.getImage(
                    banner.imageUrl,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),

              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: Colors.white.withValues(alpha: .95),
                  borderRadius: BorderRadius.circular(20),
                  child: PopupMenuButton<String>(
                    splashRadius: 20,
                    onSelected: (value) {
                      switch (value) {
                        case "edit":
                          onEdit();
                          break;

                        case "delete":
                          onDelete();
                          break;
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: "edit",
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, size: 18),
                            SizedBox(width: 10),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "delete",
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: 18,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
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

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  banner.title ?? "-",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                if ((banner.subtitle ?? "").isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    banner.subtitle!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      height: 1.35,
                    ),
                  ),
                ],

                const SizedBox(height: 14),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(
                      icon: banner.isActive
                          ? Icons.check_circle
                          : Icons.cancel,
                      text: banner.isActive
                          ? "Active"
                          : "Inactive",
                      color: banner.isActive
                          ? Colors.green
                          : Colors.red,
                    ),

                    _InfoChip(
                      icon: Icons.touch_app_outlined,
                      text: banner.actionType ?? "None",
                      color: Colors.blue,
                    ),

                    _InfoChip(
                      icon: Icons.sort,
                      text: "Order ${banner.order}",
                      color: Colors.deepPurple,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}