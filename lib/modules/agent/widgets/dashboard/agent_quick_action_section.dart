import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class AgentQuickActionSection extends StatelessWidget {
  final int pendingRequests;
  final int activePromotions;

  const AgentQuickActionSection({
    super.key,
    required this.pendingRequests,
    required this.activePromotions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 1.35,
          children: [

            _ActionCard(
              title: "Client Requests",
              subtitle: "$pendingRequests Pending",
              icon: Icons.people_alt_outlined,
              color: const Color(0xff4F46E5),
              onTap: () {
                Get.toNamed(
                  AppRoutes.agentClientRequests,
                );
              },
            ),

            _ActionCard(
              title: "Promotions",
              subtitle: "$activePromotions Active",
              icon: Icons.campaign_outlined,
              color: Colors.orange,
              onTap: () {
                Get.toNamed(
                  AppRoutes.agentPromotionRequests,
                );
              },
            ),

            _ActionCard(
              title: "My Listings",
              subtitle: "Manage Products",
              icon: Icons.inventory_2_outlined,
              color: Colors.green,
              onTap: () {
                Get.toNamed(
                  AppRoutes.agentMyListings,
                );
              },
            ),

            _ActionCard(
              title: "Profile",
              subtitle: "Account Settings",
              icon: Icons.person_outline,
              color: Colors.pink,
              onTap: () {
                Get.toNamed(
                  AppRoutes.agentProfile,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xffE7EAF4),
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
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .12),
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),

                const Spacer(),

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}