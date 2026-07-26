import 'package:get/get.dart';

import '../controllers/agent_promotion_requests_controller.dart';

class AgentPromotionRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgentPromotionRequestsController>(
          () => AgentPromotionRequestsController(),
    );
  }
}