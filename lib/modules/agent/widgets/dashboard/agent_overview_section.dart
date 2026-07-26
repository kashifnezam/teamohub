import 'package:flutter/material.dart';

import 'agent_overview_card.dart';

class AgentOverviewSection extends StatelessWidget {
  const AgentOverviewSection({
    super.key,
    required this.pendingRequests,
    required this.activePromotions,
    required this.clientRequests,
    required this.commission,
  });

  final int pendingRequests;
  final int activePromotions;
  final int clientRequests;
  final double commission;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        int columns = 2;

        if (width >= 1100) {
          columns = 4;
        } else if (width >= 700) {
          columns = 2;
        }

        const spacing = 16.0;

        final itemWidth =
            (width - ((columns - 1) * spacing)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            SizedBox(
              width: itemWidth,
              child: AgentOverviewCard(
                title: "Pending Requests",
                value: pendingRequests.toString(),
                icon: Icons.pending_actions_outlined,
              ),
            ),

            SizedBox(
              width: itemWidth,
              child: AgentOverviewCard(
                title: "Active Promotions",
                value: activePromotions.toString(),
                icon: Icons.campaign_outlined,
              ),
            ),

            SizedBox(
              width: itemWidth,
              child: AgentOverviewCard(
                title: "Client Requests",
                value: clientRequests.toString(),
                icon: Icons.groups_outlined,
              ),
            ),

            SizedBox(
              width: itemWidth,
              child: AgentOverviewCard(
                title: "Commission",
                value:
                "₹${commission.toStringAsFixed(0)}",
                icon:
                Icons.account_balance_wallet_outlined,
              ),
            ),
          ],
        );
      },
    );
  }
}