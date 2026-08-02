import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';

import '../controllers/agent_promotion_requests_controller.dart';
import '../views/promotion_requests/agent_promotion_requests_view.dart';

class PromotionsTab extends GetView<AgentPromotionRequestsController> {
  const PromotionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const TabBar(
              tabAlignment: TabAlignment.fill,
              tabs: [
                Tab(text: "Pending"),
                Tab(text: "Active"),
                Tab(text: "Completed"),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return CustomWidget.buildCircularProgressIndicator();
              }

              return TabBarView(
                children: [
                  AgentPromotionRequestsBody(
                    requests: controller.pendingPromotions,
                  ),
                  AgentPromotionRequestsBody(
                    requests: controller.activePromotions,
                  ),
                  AgentPromotionRequestsBody(
                    requests: controller.completedPromotions,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}