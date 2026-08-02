import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';

class ProfileAgentCard extends StatelessWidget {
  const ProfileAgentCard({
    super.key,
    required this.isAgent,
  });

  final bool isAgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(
                alpha: .18,
              ),
              borderRadius:
              BorderRadius.circular(14),
            ),
            child: Icon(
              isAgent
                  ? Icons.workspace_premium
                  : Icons.support_agent,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  isAgent
                      ? "You're a Teamo Agent"
                      : "Become a Teamo Agent",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  isAgent
                      ? "Manage your clients and promotions."
                      : "Earn commission by helping buyers.",
                  style: TextStyle(
                    color: Colors.white
                        .withValues(alpha: .9),
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    FilledButton(
                      style:
                      FilledButton.styleFrom(
                        backgroundColor:
                        Colors.white,
                        foregroundColor:
                        AppColors.primary,
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (isAgent) {
                          Get.toNamed(
                            AppRoutes.agentMain,
                          );
                        } else {
                          Get.toNamed(
                            AppRoutes.agent,
                          );
                        }
                      },
                      child: Text(
                        isAgent
                            ? "Agent Dashboard"
                            : "Become Agent",
                      ),
                    ),

                    const SizedBox(width: 8),

                    IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                          Container(
                            padding:
                            const EdgeInsets.all(
                              24,
                            ),
                            decoration:
                            const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.vertical(
                                top:
                                Radius.circular(
                                  28,
                                ),
                              ),
                            ),
                            child: SafeArea(
                              child: Column(
                                mainAxisSize:
                                MainAxisSize.min,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Teamo Agent",
                                    style:
                                    TextStyle(
                                      fontSize:
                                      20,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                      height:
                                      18),

                                  const Row(
                                    children: [
                                      Icon(Icons.check_circle,
                                          color:
                                          Colors.green),
                                      SizedBox(
                                          width:
                                          10),
                                      Expanded(
                                        child:
                                        Text(
                                          "Earn commission on successful sales.",
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                      height:
                                      14),

                                  Row(
                                    children: const [
                                      Icon(Icons.check_circle,
                                          color:
                                          Colors.green),
                                      SizedBox(
                                          width:
                                          10),
                                      Expanded(
                                        child:
                                        Text(
                                          "Promote products in your local area.",
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                      height:
                                      14),

                                  Row(
                                    children: const [
                                      Icon(Icons.check_circle,
                                          color:
                                          Colors.green),
                                      SizedBox(
                                          width:
                                          10),
                                      Expanded(
                                        child:
                                        Text(
                                          "Help buyers and grow your income.",
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height:
                                      26),

                                  SizedBox(
                                    width:
                                    double.infinity,
                                    child:
                                    FilledButton(
                                      onPressed:
                                          () {
                                        Get.back();

                                        if (isAgent) {
                                          Get.toNamed(
                                            AppRoutes
                                                .agentMain,
                                          );
                                        } else {
                                          Get.toNamed(
                                            AppRoutes.agent,
                                          );
                                        }
                                      },
                                      child: Text(
                                        isAgent
                                            ? "Open Dashboard"
                                            : "Become Agent",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
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