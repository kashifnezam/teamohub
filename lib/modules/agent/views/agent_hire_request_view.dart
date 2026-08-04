import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/agent_hire_request_controller.dart';
import '../models/agent_model.dart';

class AgentHireRequestView
    extends GetView<AgentHireRequestController> {
  const AgentHireRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        title: const Text("Hire Agent"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _AgentCard(agent: controller.agent),

          const SizedBox(height: 28),

          Text(
            "What do you need help with?",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Choose how you'd like this agent to assist you.",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 24),

          _ActionCard(
            icon: Icons.sell_outlined,
            color: Colors.blue,
            title: "Sell a Product",
            subtitle:
            "Create a new product listing and let this agent help you sell it.",
            onTap: () {
              controller.sellProduct();
            },
          ),

          const SizedBox(height: 16),

          _ActionCard(
            icon: Icons.shopping_cart_outlined,
            color: Colors.green,
            title: "Buy a Product",
            subtitle:
            "Tell the agent what you're looking for and receive offers.",
            onTap: () {
              controller.buyProduct();
            },
            enabled: false,
          ),

          const SizedBox(height: 16),

          _ActionCard(
            icon: Icons.campaign_outlined,
            color: Colors.orange,
            title: "Promote My Product",
            subtitle:
            "Boost one of your existing listings to reach more buyers.",
            onTap: () {
              controller.promoteProduct();
            },
            enabled: false,
          ),
        ],
      ),
    );
  }
}

class _AgentCard extends StatelessWidget {
  const _AgentCard({
    required this.agent,
  });

  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 4),
            color: Colors.black.withValues(alpha: .04),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor:
            AppColors.primary.withValues(alpha: .1),
            backgroundImage:
            agent.profileImage.isNotEmpty
                ? NetworkImage(agent.profileImage)
                : null,
            child: agent.profileImage.isEmpty
                ? Icon(
              Icons.person,
              color: AppColors.primary,
              size: 34,
            )
                : null,
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  agent.agentName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.verified,
                      size: 18,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Verified Agent",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        agent.operatingAreas
                            .map((area) =>"${area.state} (${area.cities.map((city) => city.name).join(", ")})").join("\n"),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          height: 1.4,
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
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: enabled ? onTap : null,
        child: Opacity(
          opacity: enabled ? 1 : .55,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          if (!enabled)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Coming Soon",
                                style: TextStyle(
                                  color: Colors.orange.shade800,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  enabled
                      ? Icons.arrow_forward_ios_rounded
                      : Icons.lock_outline_rounded,
                  color: Colors.grey.shade400,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}