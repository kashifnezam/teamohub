import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/agent_controller.dart';
import '../models/agent_location_model.dart';

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
                "Operating Areas",
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 4),

              Text(
                "Choose up to 3 states and 10 cities.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: controller.totalStates >=
                      AgentController.maxStates
                      ? null
                      : controller.openStatePicker,
                  icon: const Icon(Icons.add),
                  label: const Text("Add State"),
                ),
              ),

              if (controller.operatingAreas.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                  ),
                  child: Center(
                    child: Text(
                      "No operating areas selected.",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),

              ...controller.operatingAreas.map(
                    (area) => _StateCard(
                  area: area,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class _StateCard extends GetView<AgentController> {
  final AgentLocationModel area;

  const _StateCard({
    required this.area,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(
        top: 16,
      ),
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Icon(
                  Icons.location_on,
                  color: Colors.indigo,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    area.state.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () =>
                      controller.removeState(area),
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [

                ...area.cities.map(
                      (city) => Chip(
                    label: Text(city.name),
                    onDeleted: () =>
                        controller.removeCity(
                          area,
                          city,
                        ),
                  ),
                ),

                if (controller.totalCities <
                    AgentController.maxCities)
                  ActionChip(
                    avatar: const Icon(
                      Icons.add,
                      size: 18,
                    ),
                    label: const Text(
                      "Add City",
                    ),
                    onPressed: () =>
                        controller.openCityPicker(
                          area,
                        ),
                  ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}