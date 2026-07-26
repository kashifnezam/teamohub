import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../controllers/agent_client_requests_controller.dart';

class AgentClientRequestsView
    extends GetView<AgentClientRequestsController> {
  const AgentClientRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xffF7F8FC),
        appBar: AppBar(
          elevation: 0,
          title: const Text("Client Requests"),
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
              _RequestList(
                requests: controller.pendingRequests,
                isPending: true,
              ),
              _RequestList(
                requests: controller.activeRequests,
              ),
              _RequestList(
                requests: controller.completedRequests,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _RequestList extends GetView<AgentClientRequestsController> {
  const _RequestList({
    required this.requests,
    this.isPending = false,
  });

  final List requests;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const Center(
        child: Text(
          "No requests found.",
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: requests.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: 14),
      itemBuilder: (_, index) {
        final data = requests[index].data();

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                Row(
                  children: [

                    CircleAvatar(
                      radius: 24,
                      backgroundImage:
                      (data["userImage"] ?? "")
                          .toString()
                          .isNotEmpty
                          ? NetworkImage(
                        data["userImage"],
                      )
                          : null,
                      child: (data["userImage"] ?? "")
                          .toString()
                          .isEmpty
                          ? const Icon(Icons.person)
                          : null,
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            data["userName"] ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            data["category"] ?? "",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: .08),
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                      child: Text(
                        data["status"],
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [

                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                    ),

                    const SizedBox(width: 6),

                    Expanded(
                      child: Text(
                        data["location"] ?? "",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    const Icon(
                      Icons.description_outlined,
                      size: 18,
                    ),

                    const SizedBox(width: 6),

                    Expanded(
                      child: Text(
                        data["requirement"] ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                if ((data["budget"] ?? 0) > 0) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [

                      const Icon(
                        Icons.account_balance_wallet,
                        size: 18,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        "Budget : ₹${data["budget"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 18),

                Row(
                  children: [

                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.chat,
                            arguments:
                            data["chatId"],
                          );
                        },
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                        ),
                        label: const Text("Chat"),
                      ),
                    ),

                    if (!isPending &&
                        data["status"] ==
                            "accepted") ...[
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.agentCreateListing,
                              arguments: data,
                            );
                          },
                          icon: const Icon(
                            Icons.inventory_2_outlined,
                          ),
                          label: const Text(
                            "Create Listing",
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                if (isPending) ...[
                  const SizedBox(height: 12),

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
                            controller.acceptRequest(
                              requests[index].id,
                            );
                          },
                          child:
                          const Text("Accept"),
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
                            controller.rejectRequest(
                              requests[index].id,
                            );
                          },
                          child:
                          const Text("Reject"),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}