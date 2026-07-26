import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'agent_section_title.dart';

class AgentRecentClientSection extends StatelessWidget {
  const AgentRecentClientSection({
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
          title: "Recent Client Requests",
          onViewAll: onViewAll,
        ),

        const SizedBox(height: 16),

        if (requests.isEmpty)
          _buildEmptyState()
        else
          ...requests.take(5).map(
                (doc) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ClientRequestCard(
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
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor:
                Colors.blue.withOpacity(.08),
                child: const Icon(
                  Icons.person_outline,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["category"] ?? "-",
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      data["location"] ?? "-",
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              Chip(
                label: Text(
                  data["status"] ?? "",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}