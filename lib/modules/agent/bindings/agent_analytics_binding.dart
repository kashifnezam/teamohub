import 'package:get/get.dart';

import '../controllers/agent_analytics_controller.dart';

class AgentAnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => AgentAnalyticsController(),
    );
  }
}