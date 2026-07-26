import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/widgets/custom_widget.dart';
import '../../controllers/agent_dashboard_controller.dart';
import '../../models/agent_model.dart';
import '../../widgets/dashboard/agent_activity_section.dart';
import '../../widgets/dashboard/agent_dashboard_header.dart';
import '../../widgets/dashboard/agent_overview_section.dart';
import '../../widgets/dashboard/agent_promotion_section.dart';
import '../../widgets/dashboard/agent_quick_action_section.dart';
import '../../widgets/dashboard/agent_recent_client_section.dart';



class AgentDashboardView extends GetView<AgentDashboardController> {
  const AgentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return CustomWidget.buildCircularProgressIndicator();
          }

          final agent = controller.agent.value;

          if (agent == null) {
            return const Center(
              child: Text("Agent not found."),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.refreshDashboard,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [

                /// Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      12,
                    ),
                    child: AgentDashboardHeader(
                      agent: agent,
                      greeting: controller.greeting,
                    ),
                  ),
                ),

                /// Overview Cards
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: AgentOverviewSection(
                      pendingRequests:
                      controller.pendingRequests.value,
                      activePromotions:
                      controller.activePromotions.value,
                      clientRequests:
                      controller.clientRequests.value,
                      commission:
                      controller.commissionEarned.value,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 28),
                ),

                /// Quick Actions
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: AgentQuickActionSection(
                      pendingRequests:
                      controller.pendingRequests.value,
                      activePromotions:
                      controller.activePromotions.value,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 30),
                ),

                /// Recent Client Requests
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: AgentRecentClientSection(
                      requests: controller.recentRequests,
                      onViewAll: () {
                        Get.toNamed(
                          AppRoutes.agentClientRequests,
                        );
                      },
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 30),
                ),

                /// Promotion Requests
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: AgentPromotionSection(
                      requests:
                      controller.promotionRequests,
                      onViewAll: () {
                        Get.toNamed(
                          AppRoutes.agentPromotionRequests,
                        );
                      },
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 30),
                ),

                /// Activities
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: AgentActivitySection(
                      activities:
                      controller.activities,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 30),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

extension AgentDashboardHelper on AgentDashboardView {
  String serviceArea(AgentModel agent) {
    if (agent.operatingAreas.isEmpty) {
      return "-";
    }

    final area = agent.operatingAreas.first;

    if (area.cities.isNotEmpty) {
      return "${area.cities.first.name}, ${area.state.name}";
    }

    return area.state.name;
  }
}