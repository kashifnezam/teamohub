import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/agent_controller.dart';

class CommissionSelector extends GetView<AgentController> {
  const CommissionSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Card(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Commission",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: controller.selectedCommissionType.value,
                decoration: const InputDecoration(
                  labelText: "Commission Type",
                ),
                borderRadius: BorderRadius.circular(12),
                items: const [
                  DropdownMenuItem(
                    value: "Percentage",
                    child: Text("Percentage"),
                  ),
                  DropdownMenuItem(
                    value: "Fixed",
                    child: Text("Fixed"),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedCommissionType.value = value;
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.commissionController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: controller.selectedCommissionType.value ==
                      "Percentage"
                      ? "Commission (%)"
                      : "Commission Amount",
                  prefixIcon: Icon(
                    controller.selectedCommissionType.value ==
                        "Percentage"
                        ? Icons.percent
                        : Icons.currency_rupee,
                    color: AppColors.primary,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Commission is required";
                  }

                  final amount = double.tryParse(value);

                  if (amount == null || amount <= 0) {
                    return "Enter valid commission";
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}