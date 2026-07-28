import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/utils/custom_alert.dart';
import '../models/agent_model.dart';
import '../repositories/agent_hire_request_repository.dart';

class AgentHireRequestController extends GetxController {
  final AgentHireRequestRepository _repository = AgentHireRequestRepository.instance;

  final formKey = GlobalKey<FormState>();
  final categoryController = TextEditingController();
  final requirementController = TextEditingController();
  final locationController = TextEditingController();
  final budgetController = TextEditingController();
  late final AgentModel agent;

  @override
  void onInit() {
    super.onInit();

    agent = Get.arguments;
  }

  Future<void> submit({required String productId}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    CustomAlert.loadAlert("Submitting...");

    try {
      await _repository.submitRequest(
        agentId: agent.uid,
        // agentName: agent.agentName,
       productId: productId
      );

      CustomAlert.dismissAlert();

      Get.back();

      CustomAlert.successAlert(
        title: "Success",
        "Your request has been sent to the agent.",
      );

    } catch (e) {
      CustomAlert.dismissAlert();

      CustomAlert.errorAlert(
        title: "Failed",
        e.toString(),
      );
    }
  }
  void sellProduct() {
    Get.toNamed(AppRoutes.categories,arguments: {
      "agentId": agent.uid,
    },);
  }

  void buyProduct() {}

  void promoteProduct() {}
  @override
  void onClose() {
    categoryController.dispose();
    requirementController.dispose();
    locationController.dispose();
    budgetController.dispose();
    super.onClose();
  }
}