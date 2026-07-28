import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../product/models/product_model.dart';
import '../../product/repositories/product_repository.dart';
import '../models/agent_client_request_model.dart';
import '../models/agent_model.dart';
import '../models/agent_request_model.dart';
import '../repositories/agent_dashboard_repository.dart';

class AgentDashboardController extends GetxController {
  final AgentDashboardRepository _repository =
      AgentDashboardRepository.instance;

  final ProductRepository _productRepository =
  ProductRepository();

  final RxBool isLoading = true.obs;

  final Rxn<AgentModel> agent = Rxn<AgentModel>();

  final RxInt pendingRequests = 0.obs;
  final RxInt activePromotions = 0.obs;
  final RxInt clientRequests = 0.obs;
  final RxDouble commissionEarned = 0.0.obs;

  final RxList<AgentClientRequestModel> recentRequests =
      <AgentClientRequestModel>[].obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>>
  promotionRequests =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>>
  activities =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    isLoading.value = true;

    try {
      agent.value = await _repository.getAgent();

      _listenPendingRequests();
      _listenActivePromotions();
      _listenClientRequests();
      _listenCommission();
      _listenRecentRequests();
      _listenPromotionRequests();
      _listenActivities();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    await _loadDashboard();
  }

  void _listenPendingRequests() {
    _repository.pendingRequestCount().listen(
          (count) {
        pendingRequests.value = count;
      },
    );
  }

  void _listenActivePromotions() {
    _repository.activePromotionCount().listen(
          (count) {
        activePromotions.value = count;
      },
    );
  }

  void _listenClientRequests() {
    _repository.clientRequestCount().listen(
          (count) {
        clientRequests.value = count;
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
          (requests) async {
        final items = await _buildRecentRequests(requests);
        recentRequests.assignAll(items);
      },
    );
  }

  Future<List<AgentClientRequestModel>> _buildRecentRequests(
      List<AgentRequestModel> requests,
      ) async {
    final List<AgentClientRequestModel> list = [];

    for (final request in requests) {
      try {
        final ProductModel? product =
        await _productRepository.getProduct(
          request.productId,
        );

        if (product == null) continue;

        list.add(
          AgentClientRequestModel(
            id: request.id,
            request: request.toJson(),
            product: product,
          ),
        );
      } catch (_) {}
    }

    return list;
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