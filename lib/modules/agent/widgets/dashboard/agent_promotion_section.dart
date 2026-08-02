import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'agent_section_title.dart';

class AgentPromotionSection extends StatelessWidget {
  const AgentPromotionSection({
    super.key,
    required this.requests,
    this.onViewAll,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> requests;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AgentSectionTitle(
          title: "Promotion Requests",
          onViewAll: onViewAll,
        ),

        const SizedBox(height: 16),

        if (requests.isEmpty)
          _buildEmptyState()
        else
          ...requests.take(5).map(
                (doc) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _PromotionCard(
                data: doc.data(),
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
            Icons.campaign_outlined,
            size: 42,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Text(
            "No promotion requests available.",
          ),
        ],
      ),
    );
  }
}

class _PromotionCard extends StatelessWidget {
  const _PromotionCard({
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final status =
    (data["status"] ?? "pending").toString();

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xffE8EAF3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .03),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                /// Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    data["image"] ?? "",
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        width: 64,
                        height: 64,
                        color: const Color(0xffF3F4F6),
                        child: const Icon(
                          Icons.image_outlined,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        data["title"] ?? "-",
                        maxLines: 2,
                        overflow:
                        TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        data["sellerName"] ?? "-",
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 10),

                      _PromotionStatusChip(
                        status: status,
                      ),
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
}

class _PromotionStatusChip extends StatelessWidget {
  final String status;

  const _PromotionStatusChip({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (status.toLowerCase()) {
      case "approved":
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
          color: color.withValues(alpha: .10),
          borderRadius:
          BorderRadius.circular(30),
        ),
        child: Text(
          status.toUpperCase(),
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