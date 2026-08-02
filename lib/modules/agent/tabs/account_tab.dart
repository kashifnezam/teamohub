import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/modules/agent/controllers/agent_dashboard_controller.dart';
import 'package:teamomarket/modules/agent/controllers/agent_main_controller.dart';

import '../../../../app/routes/app_routes.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Agent Account",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          "Manage your TeamoMart agent account.",
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 24),

        _SwitchAccountCard(),

        const SizedBox(height: 28),

        _MenuTile(
          icon: Icons.person_outline,
          title: "My Profile",
          subtitle: "View and manage profile",
          onTap: () {
            Get.toNamed(
              AppRoutes.agentProfile,
              arguments: Get.find<AgentDashboardController>()
                  .agent
                  .value
                  ?.uid,
              parameters: {
                "showHireButton": "false",
              },
            );
          },
        ),

        _MenuTile(
          icon: Icons.star_outline,
          title: "Reviews & Ratings",
          subtitle: "Coming soon",
          enabled: false,
        ),

        _MenuTile(
          icon: Icons.settings_outlined,
          title: "Account Settings",
          subtitle: "Coming soon",
          enabled: false,
        ),

        _MenuTile(
          icon: Icons.help_outline,
          title: "Help & Support",
          subtitle: "Coming soon",
          enabled: false,
        ),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.enabled = true,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(18),
        side: const BorderSide(
          color: Color(0xffE8EAF3),
        ),
      ),
      child: ListTile(
        enabled: enabled,
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor:
          const Color(0xffEEF2FF),
          child: Icon(
            icon,
            color: const Color(0xff4F46E5),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.chevron_right_rounded,
        ),
      ),
    );
  }
}

class _SwitchAccountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xffEEF2FF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.swap_horiz,
              color: Color(0xff4F46E5),
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Text(
              "Personal Account",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const Text("Personal Account"),
                  content: const Text(
                    "Switch back to your regular TeamoMart account to browse, buy, sell, and manage your personal profile. You can return to your Agent Dashboard anytime.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: Get.back,
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.info_outline,
              size: 20,
            ),
          ),

          const SizedBox(width: 8),

          FilledButton(
            onPressed: () {
              Get.find<AgentMainController>()
                  .changeTab(0);

              Get.back();
            },
            child: const Text("Switch"),
          ),
        ],
      ),
    );
  }
}