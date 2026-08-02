import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class AgentOverviewSection extends StatelessWidget {
  final int pendingRequests;
  final int activePromotions;
  final int clientRequests;
  final double commission;

  const AgentOverviewSection({
    super.key,
    required this.pendingRequests,
    required this.activePromotions,
    required this.clientRequests,
    required this.commission,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xffE8EAF3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              8,
            ),
            child: Row(
              children: [

                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xffEEF2FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.notifications_active_rounded,
                    color: Color(0xff4F46E5),
                  ),
                ),

                const SizedBox(width: 14),

                const Expanded(
                  child: Text(
                    "Needs Attention",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          _ActionTile(
            color: Colors.orange,
            icon: Icons.people_alt_outlined,
            title: "Client Requests",
            count: clientRequests,
            onTap: () {
              Get.toNamed(
                AppRoutes.agentClientRequests,
              );
            },
          ),

          // _ActionTile(
          //   color: Colors.indigo,
          //   icon: Icons.campaign_outlined,
          //   title: "Promotion Requests",
          //   count: pendingRequests,
          //   onTap: () {
          //     Get.toNamed(
          //       AppRoutes.agentPromotionRequests,
          //     );
          //   },
          // ),

          // _ActionTile(
          //   color: Colors.green,
          //   icon: Icons.storefront_outlined,
          //   title: "Active Promotions",
          //   count: activePromotions,
          //   onTap: () {},
          // ),

          const Divider(
            height: 1,
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xffECFDF3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(width: 16),

                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Total Commission",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),

                      SizedBox(height: 3),

                      Text(
                        "Earned till now",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  "₹${commission.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final int count;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Row(
          children: [

            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF4F5F7),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 8),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}