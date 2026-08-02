import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../product/models/product_model.dart';
import '../../product/repositories/product_repository.dart';
import '../models/agent_client_request_model.dart';
import '../models/agent_model.dart';
import '../models/agent_request_model.dart';
import '../repositories/agent_dashboard_repository.dart';

class AgentDashboardController extends GetxController {
  final AgentDashboardRepository _repository = AgentDashboardRepository.instance;
  final ProductRepository _productRepository = ProductRepository();
  final isLoading = true.obs;
  final agent = Rxn<AgentModel>();
  final pendingRequests = 0.obs;
  final activePromotions = 0.obs;
  final clientRequests = 0.obs;
  final commissionEarned = 0.0.obs;
  final recentRequests = <AgentClientRequestModel>[].obs;
  final promotionRequests = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  final activities =<QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  final List<StreamSubscription> _subscriptions = [];

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  @override
  void onClose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    super.onClose();
  }

  Future<void> _initialize() async {
    isLoading.value = true;

    try {
      agent.value = await _repository.getAgent();

      _listenStreams();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    agent.value = await _repository.getAgent();
  }

  void _listenStreams() {
    _subscriptions.addAll([
      _repository
          .pendingRequestCount()
          .listen((value) => pendingRequests.value = value),

      _repository
          .activePromotionCount()
          .listen((value) => activePromotions.value = value),

      _repository
          .clientRequestCount()
          .listen((value) => clientRequests.value = value),

      _repository
          .commissionEarned()
          .listen((value) => commissionEarned.value = value),

      _repository
          .recentPromotionRequests()
          .listen((event) {
        promotionRequests.assignAll(event.docs);
      }),

      _repository
          .recentActivities()
          .listen((event) {
        activities.assignAll(event.docs);
      }),

      _repository
          .recentClientRequests()
          .asyncMap(_buildRecentRequests)
          .listen(recentRequests.assignAll),
    ]);
  }

  Future<List<AgentClientRequestModel>>
  _buildRecentRequests(
      List<AgentRequestModel> requests,
      ) async {
    final futures = requests.map(
          (request) async {
        try {
          final ProductModel? product =
          await _productRepository.getProduct(
            request.productId,
          );

          if (product == null) {
            return null;
          }

          return AgentClientRequestModel(
            id: request.id,
            request: request.toJson(),
            product: product,
          );
        } catch (_) {
          return null;
        }
      },
    );

    final results = await Future.wait(futures);

    return results
        .whereType<AgentClientRequestModel>()
        .toList();
  }

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning";

    if (hour < 17) return "Good Afternoon";

    return "Good Evening";
  }
}