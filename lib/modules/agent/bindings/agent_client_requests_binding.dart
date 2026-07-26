import 'package:get/get.dart';

import '../controllers/agent_client_requests_controller.dart';

class AgentClientRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgentClientRequestsController>(
          () => AgentClientRequestsController(),
    );
  }
}