import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class AgentAccountView extends StatelessWidget {
  const AgentAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          _MenuTile(
            icon: Icons.person_outline,
            title: "My Profile",
            subtitle: "View your agent profile",
            onTap: () {
              Get.toNamed(AppRoutes.agentProfile);
            },
          ),

          _MenuTile(
            icon: Icons.account_balance_wallet_outlined,
            title: "Commission",
            subtitle: "View earnings",
            onTap: () {},
          ),

          _MenuTile(
            icon: Icons.location_on_outlined,
            title: "Service Areas",
            subtitle: "Manage locations",
            onTap: () {},
          ),

          _MenuTile(
            icon: Icons.star_border_rounded,
            title: "Reviews",
            subtitle: "Customer feedback",
            onTap: () {},
          ),

          _MenuTile(
            icon: Icons.settings_outlined,
            title: "Settings",
            subtitle: "App preferences",
            onTap: () {},
          ),

          const SizedBox(height: 30),

          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(54),
            ),
            onPressed: () {},
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: Color(0xffE8EAF3),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xffEEF2FF),
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
        onTap: onTap,
      ),
    );
  }
}