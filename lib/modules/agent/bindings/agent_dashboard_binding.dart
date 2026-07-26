import 'package:get/get.dart';

import '../controllers/agent_dashboard_controller.dart';

class AgentDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgentDashboardController>(
          () => AgentDashboardController(),
      fenix: true,
    );
  }
}