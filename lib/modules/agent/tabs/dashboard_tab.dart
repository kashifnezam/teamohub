import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/widgets/custom_widget.dart';
import '../controllers/agent_dashboard_controller.dart';
import '../controllers/agent_main_controller.dart';
import '../models/agent_model.dart';
import '../widgets/dashboard/agent_activity_section.dart';
import '../widgets/dashboard/agent_dashboard_header.dart';
import '../widgets/dashboard/agent_overview_section.dart';
import '../widgets/dashboard/agent_recent_client_section.dart';

class DashboardTab extends GetView<AgentDashboardController> {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return CustomWidget.buildCircularProgressIndicator();
      }

      final agent = controller.agent.value;

      if (agent == null) {
        return const Center(
          child: Text("Agent not found"),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.refreshDashboard,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  0,
                ),
                child: AgentDashboardHeader(
                  agent: agent,
                  greeting: controller.greeting,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 22),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: AgentOverviewSection(
                  pendingRequests: controller.pendingRequests.value,
                  activePromotions: controller.activePromotions.value,
                  clientRequests: controller.clientRequests.value,
                  commission: controller.commissionEarned.value,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 28),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: AgentRecentClientSection(
                  requests: controller.recentRequests,
                  onViewAll: () {
                    Get.find<AgentMainController>().changeTab(1);
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 28),
            ),

            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 20,
            //     ),
            //     child: AgentPromotionSection(
            //       requests:
            //       controller.promotionRequests,
            //       onViewAll: () {
            //         Get.find<AgentMainController>()
            //             .changeTab(2);
            //       },
            //     ),
            //   ),
            // ),

            if (controller.activities.isNotEmpty) ...[
              const SliverToBoxAdapter(
                child: SizedBox(height: 28),
              ),
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
            ],

            const SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
          ],
        ),
      );
    });
  }
}

extension DashboardTabHelper on DashboardTab {
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