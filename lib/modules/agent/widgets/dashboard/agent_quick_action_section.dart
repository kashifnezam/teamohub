import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import 'agent_quick_action_card.dart';
import 'agent_section_title.dart';

class AgentQuickActionSection extends StatelessWidget {
  const AgentQuickActionSection({
    super.key,
    required this.pendingRequests,
    required this.activePromotions,
  });

  final int pendingRequests;
  final int activePromotions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AgentSectionTitle(
          title: "Quick Actions",
        ),

        const SizedBox(height: 18),

        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            int columns;

            if (width >= 1200) {
              columns = 6;
            } else if (width >= 900) {
              columns = 5;
            } else if (width >= 700) {
              columns = 2;
            } else {
              columns = 2;
            }

            const spacing = 12.0;

            final itemWidth =
                (width - ((columns - 1) * spacing)) /
                    columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                SizedBox(
                  width: itemWidth,
                  child: AgentQuickActionCard(
                    title: "Clients",
                    icon: Icons.people_alt_outlined,
                    badge: pendingRequests.toString(),
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.agentClientRequests,
                      );
                    },
                  ),
                ),

                SizedBox(
                  width: itemWidth,
                  child: AgentQuickActionCard(
                    title: "Promotions",
                    icon: Icons.campaign_outlined,
                    badge:
                    activePromotions.toString(),
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.agentPromotionRequests,
                      );
                    },
                  ),
                ),

                SizedBox(
                  width: itemWidth,
                  child: AgentQuickActionCard(
                    title: "Listings",
                    icon: Icons.inventory_2_outlined,
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.agentListings,
                      );
                    },
                  ),
                ),

                SizedBox(
                  width: itemWidth,
                  child: AgentQuickActionCard(
                    title: "Analytics",
                    icon: Icons.analytics_outlined,
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.agentAnalytics,
                      );
                    },
                  ),
                ),

                SizedBox(
                  width: itemWidth,
                  child: AgentQuickActionCard(
                    title: "Chats",
                    icon: Icons.chat_bubble_outline,
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.chat,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}