import 'package:get/get.dart';
import 'package:teamomarket/modules/agent/controllers/agent_my_listings_controller.dart';

import '../controllers/agent_client_requests_controller.dart';
import '../controllers/agent_dashboard_controller.dart';
import '../controllers/agent_main_controller.dart';
import '../controllers/agent_promotion_requests_controller.dart';

class AgentMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgentMainController>(
          () => AgentMainController(),
    );

    Get.lazyPut<AgentDashboardController>(
          () => AgentDashboardController(),
    );

    Get.lazyPut<AgentClientRequestsController>(
          () => AgentClientRequestsController(),
    );

    Get.lazyPut<AgentMyListingsController>(
          () => AgentMyListingsController(),
    );
  }
}