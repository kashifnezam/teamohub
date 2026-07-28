import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/routes/app_routes.dart';
import 'package:teamomarket/app/theme/app_colors.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';
import 'package:teamomarket/modules/agent/controllers/agent_client_requests_controller.dart';
import 'package:teamomarket/modules/agent/models/agent_client_request_model.dart';
import 'package:teamomarket/modules/chat/controllers/chat_controller.dart';

class AgentRequestCard extends GetView<AgentClientRequestsController> {
  const AgentRequestCard({
    super.key,
    required this.request,
  });

  final AgentClientRequestModel request;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          //----------------------------------------
          // Product
          //----------------------------------------

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CustomWidget.getImage(
                    request.product.images.first,
                    width: 95,
                    height: 95,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              request.product.title,
                              maxLines: 2,
                              overflow:
                              TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),

                          _StatusChip(
                            request.status,
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "₹ ${request.product.price}",
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "${request.product.categoryName} • ${request.product.subCategoryName}",
                        style: TextStyle(
                          color:
                          Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color:
                            Colors.grey.shade600,
                          ),

                          const SizedBox(width: 4),

                          Expanded(
                            child: Text(
                              "${request.product.city}, ${request.product.state}",
                              style: TextStyle(
                                color: Colors
                                    .grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            color: Colors.grey.shade200,
          ),

          //----------------------------------------
          // Customer
          //----------------------------------------

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage:
                  request.userImage.isNotEmpty
                      ? NetworkImage(
                    request.userImage,
                  )
                      : null,
                  child: request.userImage.isEmpty
                      ? const Icon(Icons.person)
                      : null,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Requested By",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        request.userName,
                        style: const TextStyle(
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //----------------------------------------
          // Actions
          //----------------------------------------

          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              16,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.find<ChatController>()
                              .openAgentChat(
                            request: {
                              ...request.request,
                              "id": request.id,
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                        ),
                        label:
                        const Text("Chat"),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.productDetails,
                            arguments:
                            request.product,
                          );
                        },
                        icon: const Icon(
                          Icons.visibility_outlined,
                        ),
                        label:
                        const Text("View"),
                      ),
                    ),
                  ],
                ),

                if (request.isPending) ...[
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
                              request.id,
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
                            controller.rejectRequest(
                              request.id,
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

                if (request.isAccepted) ...[
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style:
                      FilledButton.styleFrom(
                        backgroundColor:
                        AppColors.primary,
                      ),
                      onPressed: () {
                        controller.completeRequest(
                          request.id,
                        );
                      },
                      icon: const Icon(
                        Icons.check_circle,
                      ),
                      label: const Text(
                        "Mark Completed",
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (status) {
      case "accepted":
      case "in_progress":
        color = Colors.green;
        break;

      case "completed":
        color = Colors.blue;
        break;

      case "rejected":
        color = Colors.red;
        break;

      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status.replaceAll("_", " ").toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}