import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';

import '../controllers/agent_directory_controller.dart';
import '../widgets/agent_card.dart';
import '../../../app/routes/app_routes.dart';

class AgentDirectoryView
    extends GetView<AgentDirectoryController> {
  const AgentDirectoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verified Agents"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged:
              controller.updateSearch,
              decoration:
              const InputDecoration(
                prefixIcon:
                Icon(Icons.search),
                hintText:
                "Search agent, city, language...",
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return CustomWidget.buildCircularProgressIndicator();
              }

              if (controller
                  .filteredAgents.isEmpty) {
                return const Center(
                  child: Text(
                    "No verified agents found.",
                  ),
                );
              }

              return ListView.separated(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                itemBuilder:
                    (context, index) {
                  final agent = controller
                      .filteredAgents[index];

                  return AgentCard(
                    agent: agent,
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.agentProfile,
                        arguments: agent.uid,
                      );
                    },
                  );
                },
                separatorBuilder:
                    (_, __) =>
                const SizedBox(
                  height: 14,
                ),
                itemCount: controller
                    .filteredAgents.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}