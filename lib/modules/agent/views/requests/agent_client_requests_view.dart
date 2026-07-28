import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';

import '../../controllers/agent_client_requests_controller.dart';
import '../../widgets/dashboard/agent_request_card.dart';

class AgentClientRequestsView extends GetView<AgentClientRequestsController> {
  const AgentClientRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xffF7F8FC),
        appBar: AppBar(
          elevation: 0,
          title: const Text("Client Requests"),
          centerTitle: false,
          bottom: const TabBar(
            tabAlignment: TabAlignment.fill,
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Active"),
              Tab(text: "Completed"),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return CustomWidget.buildCircularProgressIndicator();
          }

          return TabBarView(
            children: [
              _RequestTab(
                requests: controller.pendingRequests,
              ),

              _RequestTab(
                requests: controller.activeRequests,
              ),

              _RequestTab(
                requests: controller.completedRequests,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _RequestTab extends StatelessWidget {
  const _RequestTab({
    required this.requests,
  });

  final List requests;

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 70,
                color: Colors.grey.shade400,
              ),

              const SizedBox(height: 20),

              const Text(
                "No Requests Yet",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Product requests from customers\nwill appear here.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        Get.find<AgentClientRequestsController>().onInit();
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: requests.length,
        separatorBuilder: (_, __) =>
        const SizedBox(height: 16),
        itemBuilder: (_, index) {
          return AgentRequestCard(
            request: requests[index],
          );
        },
      ),
    );
  }
}