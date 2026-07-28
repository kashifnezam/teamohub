import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';
import '../../controllers/agent_analytics_controller.dart';
import '../../widgets/dashboard/agent_overview_card.dart';

class AgentAnalyticsView
    extends GetView<AgentAnalyticsController> {
  const AgentAnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        title: const Text("Analytics"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return CustomWidget.buildCircularProgressIndicator();
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            int columns;

            if (width >= 1400) {
              columns = 5;
            } else if (width >= 1100) {
              columns = 4;
            } else if (width >= 800) {
              columns = 3;
            } else {
              columns = 2;
            }

            const spacing = 16.0;

            final itemWidth =
                (width - ((columns - 1) * spacing) - 40) /
                    columns;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: AgentOverviewCard(
                      title: "Listings",
                      value: controller.totalListings.value
                          .toString(),
                      icon: Icons.inventory_2_outlined,
                    ),
                  ),

                  SizedBox(
                    width: itemWidth,
                    child: AgentOverviewCard(
                      title: "Active",
                      value: controller.activeListings.value
                          .toString(),
                      icon: Icons.check_circle_outline,
                    ),
                  ),

                  SizedBox(
                    width: itemWidth,
                    child: AgentOverviewCard(
                      title: "Deals",
                      value:
                      controller.completedDeals.value
                          .toString(),
                      icon: Icons.handshake_outlined,
                    ),
                  ),

                  SizedBox(
                    width: itemWidth,
                    child: AgentOverviewCard(
                      title: "Commission",
                      value:
                      "₹${controller.totalCommission.value.toStringAsFixed(0)}",
                      icon: Icons.payments_outlined,
                    ),
                  ),

                  SizedBox(
                    width: itemWidth,
                    child: AgentOverviewCard(
                      title: "Views",
                      value:
                      controller.totalViews.value
                          .toString(),
                      icon: Icons.visibility_outlined,
                    ),
                  ),

                  SizedBox(
                    width: itemWidth,
                    child: AgentOverviewCard(
                      title: "Shares",
                      value:
                      controller.totalShares.value
                          .toString(),
                      icon: Icons.share_outlined,
                    ),
                  ),

                  SizedBox(
                    width: itemWidth,
                    child: AgentOverviewCard(
                      title: "Chats",
                      value:
                      controller.totalChats.value
                          .toString(),
                      icon: Icons.chat_outlined,
                    ),
                  ),

                  SizedBox(
                    width: itemWidth,
                    child: AgentOverviewCard(
                      title: "Enquiries",
                      value: controller
                          .totalEnquiries.value
                          .toString(),
                      icon:
                      Icons.support_agent_outlined,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}