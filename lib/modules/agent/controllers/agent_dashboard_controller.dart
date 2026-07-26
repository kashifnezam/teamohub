import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/agent_model.dart';
import '../repositories/agent_dashboard_repository.dart';

class AgentDashboardController extends GetxController {
  final AgentDashboardRepository _repository =
      AgentDashboardRepository.instance;

  final RxBool isLoading = true.obs;

  final Rxn<AgentModel> agent = Rxn<AgentModel>();

  final RxInt pendingRequests = 0.obs;
  final RxInt activePromotions = 0.obs;
  final RxInt clientRequests = 0.obs;
  final RxDouble commissionEarned = 0.0.obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>> recentRequests =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>>
  promotionRequests =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>> activities =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    isLoading.value = true;

    agent.value = await _repository.getAgent();

    _listenPendingRequests();

    _listenActivePromotions();

    _listenClientRequests();

    _listenCommission();

    _listenRecentRequests();

    _listenPromotionRequests();

    _listenActivities();

    isLoading.value = false;
  }

  Future<void> refreshDashboard() async {
    await _loadDashboard();
  }

  void _listenPendingRequests() {
    _repository.pendingRequestCount().listen(
          (value) {
        pendingRequests.value = value;
      },
    );
  }

  void _listenActivePromotions() {
    _repository.activePromotionCount().listen(
          (value) {
        activePromotions.value = value;
      },
    );
  }

  void _listenClientRequests() {
    _repository.clientRequestCount().listen(
          (value) {
        clientRequests.value = value;
      },
    );
  }

  void _listenCommission() {
    _repository.commissionEarned().listen(
          (value) {
        commissionEarned.value = value;
      },
    );
  }

  void _listenRecentRequests() {
    _repository.recentClientRequests().listen(
          (event) {
        recentRequests.assignAll(event.docs);
      },
    );
  }

  void _listenPromotionRequests() {
    _repository.recentPromotionRequests().listen(
          (event) {
        promotionRequests.assignAll(event.docs);
      },
    );
  }

  void _listenActivities() {
    _repository.recentActivities().listen(
          (event) {
        activities.assignAll(event.docs);
      },
    );
  }

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    }

    if (hour < 17) {
      return 'Good Afternoon';
    }

    return 'Good Evening';
  }
}