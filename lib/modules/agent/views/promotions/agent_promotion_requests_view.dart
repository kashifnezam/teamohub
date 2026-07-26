import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../controllers/agent_promotion_requests_controller.dart';

class AgentPromotionRequestsView extends GetView<AgentPromotionRequestsController> {
  const AgentPromotionRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xffF7F8FC),
        appBar: AppBar(
          title: const Text("Promotion Requests"),
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Active"),
              Tab(text: "Completed"),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return CustomWidget.buildCircularProgressIndicator();
          }

          return TabBarView(
            children: [
              _PromotionList(
                promotions: controller.pendingPromotions,
                isPending: true,
              ),
              _PromotionList(
                promotions: controller.activePromotions,
              ),
              _PromotionList(
                promotions: controller.completedPromotions,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _PromotionList
    extends GetView<AgentPromotionRequestsController> {
  const _PromotionList({
    required this.promotions,
    this.isPending = false,
  });

  final List promotions;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    if (promotions.isEmpty) {
      return const Center(
        child: Text(
          "No promotion requests found.",
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: promotions.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: 16),
      itemBuilder: (_, index) {
        final data = promotions[index].data();

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    data["productImage"] ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: Colors.grey.shade100,
                        child: const Icon(
                          Icons.image_outlined,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            data["productTitle"] ?? "",
                            maxLines: 2,
                            overflow:
                            TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                        ),

                        Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary
                                .withValues(alpha: .08),
                            borderRadius:
                            BorderRadius.circular(
                              30,
                            ),
                          ),
                          child: Text(
                            data["status"],
                            style: TextStyle(
                              color:
                              AppColors.primary,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [

                        Text(
                          "₹${data["productPrice"]}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const Spacer(),

                        const Icon(
                          Icons.person_outline,
                          size: 18,
                        ),

                        const SizedBox(width: 5),

                        Flexible(
                          child: Text(
                            data["sellerName"] ?? "",
                            overflow:
                            TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [

                        const Icon(
                          Icons.location_on_outlined,
                          size: 18,
                        ),

                        const SizedBox(width: 5),

                        Expanded(
                          child: Text(
                            data["location"] ?? "",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [

                        const Icon(
                          Icons.payments_outlined,
                          size: 18,
                        ),

                        const SizedBox(width: 5),

                        Text(
                          "${data["commissionValue"]} ${data["commissionType"]}",
                          style: const TextStyle(
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [

                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(
                              Icons.visibility,
                            ),
                            label:
                            const Text("View"),
                            onPressed: () {
                              Get.toNamed(
                                AppRoutes
                                    .productDetails,
                                arguments:
                                data["productId"],
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(
                              Icons.chat_outlined,
                            ),
                            label:
                            const Text("Chat"),
                            onPressed: () {
                              Get.toNamed(
                                AppRoutes.chat,
                                arguments:
                                data["chatId"],
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    if (!isPending &&
                        data["status"] ==
                            "accepted") ...[
                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          icon: const Icon(
                            Icons.add_business,
                          ),
                          label: const Text(
                            "Create Agent Listing",
                          ),
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.agentCreateListing,
                              arguments: data,
                            );
                          },
                        ),
                      ),
                    ],

                    if (isPending) ...[
                      const SizedBox(height: 14),

                      Row(
                        children: [

                          Expanded(
                            child: FilledButton(
                              style:
                              FilledButton.styleFrom(
                                backgroundColor:
                                Colors.green,
                              ),
                              onPressed: () {
                                controller
                                    .acceptPromotion(
                                  promotions[index]
                                      .id,
                                );
                              },
                              child: const Text(
                                "Accept",
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: FilledButton(
                              style:
                              FilledButton.styleFrom(
                                backgroundColor:
                                Colors.red,
                              ),
                              onPressed: () {
                                controller
                                    .rejectPromotion(
                                  promotions[index]
                                      .id,
                                );
                              },
                              child: const Text(
                                "Reject",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}