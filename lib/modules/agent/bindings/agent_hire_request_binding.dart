import 'package:get/get.dart';

import '../controllers/agent_hire_request_controller.dart';

class AgentHireRequestBinding
    extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => AgentHireRequestController(),
    );
  }
}