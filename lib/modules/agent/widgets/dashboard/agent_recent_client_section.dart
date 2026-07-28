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
    return Column(
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
    );
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
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomWidget.getImage(
                  product.images.isEmpty
                      ? ""
                      : product.images.first,
                  width: 70,
                  height: 70,
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
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "₹ ${product.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "${product.city}, ${product.state}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              _StatusChip(request.status),
            ],
          ),
        ),
      ),
    );
  }

  void onTap() {
    Get.toNamed(AppRoutes.agentClientRequests);
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
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}