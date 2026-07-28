import 'package:get/get.dart';

import '../models/agent_model.dart';
import '../repositories/agent_directory_repository.dart';

class AgentDirectoryController extends GetxController {
  final AgentDirectoryRepository _repository = AgentDirectoryRepository.instance;

  final RxBool isLoading = true.obs;

  final RxList<AgentModel> agents =
      <AgentModel>[].obs;

  final RxList<AgentModel> filteredAgents =
      <AgentModel>[].obs;

  final RxString search = ''.obs;

  @override
  void onInit() {
    super.onInit();

    _repository.streamVerifiedAgents().listen(
          (data) {
        agents.assignAll(data);
        _filter();
        isLoading.value = false;
      },
    );

    debounce(
      search,
          (_) => _filter(),
      time: const Duration(
        milliseconds: 300,
      ),
    );
  }

  void updateSearch(String value) {
    search.value = value;
  }

  void _filter() {
    if (search.value.trim().isEmpty) {
      filteredAgents.assignAll(agents);
      return;
    }

    final keyword =
    search.value.toLowerCase();

    filteredAgents.assignAll(
      agents.where((agent) {
        return agent.agentName
            .toLowerCase()
            .contains(keyword) ||
            agent.about
                .toLowerCase()
                .contains(keyword) ||
            agent.experience
                .toLowerCase()
                .contains(keyword) ||
            agent.languages.any(
                  (e) => e
                  .toLowerCase()
                  .contains(keyword),
            ) ||
            agent.operatingAreas.any(
                  (e) =>
              e.state.name.toLowerCase()
                  .contains(keyword) ||
                  e.cities.first.toString().toLowerCase()
                      .contains(keyword),
            );
      }),
    );
  }
}