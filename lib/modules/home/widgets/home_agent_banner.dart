import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/routes/middlewares/auth_helper.dart';
import '../../../app/theme/app_colors.dart';

class HomeAgentHelpCard extends StatelessWidget {
  const HomeAgentHelpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () async {
          if (!await AuthHelper.requireLogin(
          message: "Login to post your ad.",
          )) return;

          Get.toNamed(AppRoutes.agentDirectory);
        },
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffEEF4FF),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: .12),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.support_agent_rounded,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Hire a Verified Agent",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Buy • Sell • Promote",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Explore",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}