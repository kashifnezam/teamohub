import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/agent_controller.dart';

class AgentPendingView extends GetView<AgentController> {
  const AgentPendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.orange.shade200,
              ),
            ),
            child: Column(
              children: [

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.hourglass_top_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Application Submitted",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Your application has been received successfully.\n\nOur verification team is reviewing your profile and documents.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [

                      Icon(
                        Icons.schedule,
                        color: Colors.orange,
                      ),

                      SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          "Expected verification within 2–3 business days.",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _TimelineItem(
            title: "Application Submitted",
            completed: true,
          ),

          _TimelineItem(
            title: "Documents Verification",
            current: true,
          ),

          _TimelineItem(
            title: "Verified Agent",
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: controller.openEditProfile,
              icon: const Icon(Icons.edit),
              label: const Text("Edit Application"),
            ),
          ),

        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final bool completed;
  final bool current;

  const _TimelineItem({
    required this.title,
    this.completed = false,
    this.current = false,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey;

    IconData icon = Icons.radio_button_unchecked;

    if (completed) {
      color = Colors.green;
      icon = Icons.check_circle;
    }

    if (current) {
      color = AppColors.primary;
      icon = Icons.hourglass_top;
    }

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight:
          current ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }
}