import 'package:get/get.dart';

import '../models/agent_model.dart';
import '../repositories/agent_profile_repository.dart';

class AgentProfileController extends GetxController {
  final AgentProfileRepository _repository = AgentProfileRepository.instance;

  final RxBool isLoading = true.obs;

  final Rxn<AgentModel> agent =
  Rxn<AgentModel>();

  late final String agentId;

  @override
  void onInit() {
    super.onInit();

    agentId = Get.arguments;

    loadAgent();
  }

  Future<void> loadAgent() async {
    agent.value =
    await _repository.getAgent(agentId);

    isLoading.value = false;
  }
}