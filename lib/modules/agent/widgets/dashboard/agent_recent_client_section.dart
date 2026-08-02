import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';

import '../../../../app/routes/app_routes.dart';
import '../../models/agent_client_request_model.dart';
import 'agent_section_title.dart';

class AgentRecentClientSection extends StatelessWidget {
  const AgentRecentClientSection({
    super.key,
    required this.requests,
    this.onViewAll,
  });

  final List<AgentClientRequestModel> requests;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AgentSectionTitle(
          title: "Recent Client Requests",
          onViewAll: onViewAll,
        ),

        const SizedBox(height: 16),

        if (requests.isEmpty)
          _buildEmptyState()
        else
          ...requests.take(5).map(
                (request) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ClientRequestCard(
                request: request,
              ),
            ),
          ),
      ],
    ));
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 42,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Text(
            "No client requests available.",
          ),
        ],
      ),
    );
  }
}

class _ClientRequestCard extends StatelessWidget {
  const _ClientRequestCard({
    required this.request,
  });

  final AgentClientRequestModel request;

  @override
  Widget build(BuildContext context) {
    final product = request.product;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xffE8EAF3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.03),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CustomWidget.getImage(
                    product.images.isEmpty
                        ? ""
                        : product.images.first,
                    width: 64,
                    height: 64,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "₹ ${product.price}",
                        style: const TextStyle(
                          color: Color(0xff4F46E5),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [

                          Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: Colors.grey.shade600,
                          ),

                          const SizedBox(width: 4),

                          Expanded(
                            child: Text(
                              "${product.city}, ${product.state}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      _StatusChip(request.status),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTap() {
    Get.toNamed(
      AppRoutes.agentClientRequests,
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

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(.10),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          status.replaceAll("_", " ").toUpperCase(),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}