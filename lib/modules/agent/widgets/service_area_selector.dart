import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/agent_controller.dart';

class ServiceAreaSelector extends GetView<AgentController> {
  const ServiceAreaSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Service Area",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("States"),
                subtitle: controller.selectedStates.isEmpty
                    ? const Text("Select service states")
                    : Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: controller.selectedStates
                      .map(
                        (e) => Chip(
                      label: Text(e),
                      onDeleted: () {
                        controller.selectedStates.remove(e);
                      },
                    ),
                  )
                      .toList(),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () async {
                  /// Open your existing State Picker here.
                  ///
                  /// Example:
                  /// final result = await Get.to(...)
                  /// if(result!=null){
                  ///   controller.selectedStates.assignAll(result);
                  /// }
                },
              ),

              const Divider(),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Cities"),
                subtitle: controller.selectedCities.isEmpty
                    ? const Text("Select service cities")
                    : Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: controller.selectedCities
                      .map(
                        (e) => Chip(
                      label: Text(e),
                      onDeleted: () {
                        controller.selectedCities.remove(e);
                      },
                    ),
                  )
                      .toList(),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () async {
                  /// Open your existing City Picker here.
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}