import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/agent_controller.dart';

class AgentRejectedView extends GetView<AgentController> {
  const AgentRejectedView({super.key});

  @override
  Widget build(BuildContext context) {
    final agent = controller.agent.value!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.red.shade200,
              ),
            ),
            child: Column(
              children: [

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cancel_rounded,
                    color: Colors.white,
                    size: 38,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Application Rejected",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Your application couldn't be approved at this time. Please review the reason below, update your information, and submit again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 24),

          _SectionCard(
            title: "Reason for Rejection",
            icon: Icons.report_problem_outlined,
            child: Text(
              agent.rejectedReason?.isNotEmpty == true
                  ? agent.rejectedReason!
                  : "No rejection reason was provided.",
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 18),

          _SectionCard(
            title: "What You Can Do",
            icon: Icons.lightbulb_outline,
            child: const Column(
              children: [

                _TipRow(
                  icon: Icons.check_circle_outline,
                  text: "Update incorrect or incomplete information.",
                ),

                SizedBox(height: 12),

                _TipRow(
                  icon: Icons.badge_outlined,
                  text: "Upload a clear government-issued ID.",
                ),

                SizedBox(height: 12),

                _TipRow(
                  icon: Icons.photo_camera_outlined,
                  text: "Ensure profile photo is clear and recent.",
                ),

                SizedBox(height: 12),

                _TipRow(
                  icon: Icons.location_on_outlined,
                  text: "Verify your service areas and languages.",
                ),

              ],
            ),
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Icon(
                  Icons.info_outline,
                  color: AppColors.primary,
                ),

                SizedBox(width: 12),

                Expanded(
                  child: Text(
                    "After updating your application, our team will review it again. You can resubmit as soon as you've corrected the issues above.",
                    style: TextStyle(
                      height: 1.5,
                    ),
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: FilledButton.icon(
              onPressed: controller.openEditProfile,
              icon: const Icon(Icons.edit_outlined),
              label: const Text("Update & Resubmit"),
            ),
          ),

        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Icon(
                  icon,
                  color: AppColors.primary,
                ),

                const SizedBox(width: 10),

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 16),

            child,

          ],
        ),
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TipRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Icon(
          icon,
          size: 20,
          color: Colors.green,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              height: 1.5,
            ),
          ),
        ),

      ],
    );
  }
}