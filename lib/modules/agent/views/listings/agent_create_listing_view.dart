import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/utils/custom_alert.dart';
import '../../controllers/agent_create_listing_controller.dart';

class AgentCreateListingView extends GetView<AgentCreateListingController> {
  const AgentCreateListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Create Listing",
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            16,
            20,
            20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          ),
          child: Obx(
                () => FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(16),
                ),
              ),
              onPressed: controller.isSaving.value
                  ? null
                  : () async {
                CustomAlert.loadAlert(
                  "Saving...",
                );

                try {
                  await controller
                      .createListing();

                  CustomAlert.dismissAlert();

                  CustomAlert.successAlert(
                    title: "Listing Created",
                    "Your agent listing is ready.",
                  );
                } catch (e) {
                  CustomAlert.dismissAlert();

                  CustomAlert.errorAlert(
                    title: "Failed",
                    e.toString(),
                  );
                }
              },
              child: controller.isSaving.value
                  ? const SizedBox(
                height: 22,
                width: 22,
                child:
                CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text(
                "Create Listing",
              ),
            ),
          ),
        ),
      ),

      body: Form(
        key: controller.formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isDesktop =
                constraints.maxWidth > 900;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints:
                  const BoxConstraints(
                    maxWidth: 1100,
                  ),
                  child: isDesktop
                      ? Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: const [
                            _ProductPreviewCard(),
                            SizedBox(height: 24),
                            _ListingFormCard(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Expanded(
                        flex: 3,
                        child: _OriginalProductCard(),
                      ),
                    ],
                  )
                      : Column(
                    children: const [
                      _ProductPreviewCard(),
                      SizedBox(height: 24),
                      _OriginalProductCard(),
                      SizedBox(height: 24),
                      _ListingFormCard(),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ListingFormCard extends GetView<
    AgentCreateListingController> {
  const _ListingFormCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(.04),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .08),
                  borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
                ),
                child: Icon(
                  Icons.edit_note,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      "Listing Details",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Provide complete information to attract buyers.",
                      style: TextStyle(
                        color:
                        Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          TextFormField(
            controller:
            controller.titleController,
            textInputAction:
            TextInputAction.next,
            decoration: InputDecoration(
              labelText: "Listing Title",
              prefixIcon: const Icon(
                Icons.title,
              ),
              filled: true,
              fillColor:
              const Color(0xffF8F9FC),
              border:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(
                  16,
                ),
                borderSide:
                BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty) {
                return "Title is required";
              }

              return null;
            },
          ),

          const SizedBox(height: 18),

          TextFormField(
            controller: controller
                .descriptionController,
            minLines: 5,
            maxLines: 8,
            decoration: InputDecoration(
              labelText: "Description",
              alignLabelWithHint: true,
              prefixIcon:
              const Padding(
                padding:
                EdgeInsets.only(
                  bottom: 90,
                ),
                child: Icon(
                  Icons.description,
                ),
              ),
              filled: true,
              fillColor:
              const Color(0xffF8F9FC),
              border:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(
                  16,
                ),
                borderSide:
                BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty) {
                return "Description is required";
              }

              return null;
            },
          ),

          const SizedBox(height: 18),

          TextFormField(
            controller: controller
                .sellingNotesController,
            minLines: 4,
            maxLines: 6,
            decoration: InputDecoration(
              labelText:
              "Selling Notes",
              hintText:
              "Negotiation, urgency, delivery, warranty...",
              alignLabelWithHint: true,
              prefixIcon:
              const Padding(
                padding:
                EdgeInsets.only(
                  bottom: 65,
                ),
                child: Icon(
                  Icons.lightbulb_outline,
                ),
              ),
              filled: true,
              fillColor:
              const Color(0xffF8F9FC),
              border:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(
                  16,
                ),
                borderSide:
                BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductPreviewCard
    extends GetView<AgentCreateListingController> {
  const _ProductPreviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(.04),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (controller.images.isEmpty) {
              return Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius:
                  const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                ),
                child: Icon(
                  Icons.image_outlined,
                  size: 70,
                  color: Colors.grey.shade400,
                ),
              );
            }

            return ClipRRect(
              borderRadius:
              const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
              child: Image.network(
                controller.images.first,
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                  height: 260,
                  color: Colors.grey.shade100,
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 70,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            );
          }),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  controller
                      .promotion["productTitle"] ??
                      "Product",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "₹${controller.promotion["productPrice"]}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                    color: AppColors.primary,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Obx(() {
                  if (controller.images.length <= 1) {
                    return const SizedBox();
                  }

                  return SizedBox(
                    height: 72,
                    child: ListView.separated(
                      scrollDirection:
                      Axis.horizontal,
                      itemCount:
                      controller.images.length,
                      separatorBuilder:
                          (_, __) =>
                      const SizedBox(
                        width: 12,
                      ),
                      itemBuilder:
                          (_, index) {
                        return ClipRRect(
                          borderRadius:
                          BorderRadius
                              .circular(
                            14,
                          ),
                          child:
                          Image.network(
                            controller
                                .images[index],
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __,
                                ___) =>
                                Container(
                                  width: 72,
                                  color: Colors
                                      .grey
                                      .shade200,
                                  child:
                                  const Icon(
                                    Icons.image,
                                  ),
                                ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OriginalProductCard
    extends GetView<AgentCreateListingController> {
  const _OriginalProductCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(.04),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange
                      .withOpacity(.10),
                  borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  "Original Product",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          _InfoTile(
            icon: Icons.badge_outlined,
            title: "Product ID",
            value:
            controller.promotion["productId"],
          ),

          const Divider(height: 28),

          _InfoTile(
            icon: Icons.person_outline,
            title: "Seller",
            value:
            controller.promotion["sellerName"],
          ),

          const Divider(height: 28),

          _InfoTile(
            icon:
            Icons.payments_outlined,
            title: "Price",
            value:
            "₹${controller.promotion["productPrice"]}",
          ),

          const Divider(height: 28),

          _InfoTile(
            icon:
            Icons.workspace_premium_outlined,
            title: "Commission",
            value:
            "${controller.promotion["commissionValue"]} ${controller.promotion["commissionType"]}",
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value?.toString() ?? "-",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.08),
            borderRadius:
            BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: TextStyle(
                    color:
                    Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _CardContainer extends StatelessWidget {
  const _CardContainer({
    required this.child,
    this.padding =
    const EdgeInsets.all(24),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            offset: const Offset(0, 5),
            color:
            Colors.black.withOpacity(.04),
          ),
        ],
      ),
      child: child,
    );
  }
}