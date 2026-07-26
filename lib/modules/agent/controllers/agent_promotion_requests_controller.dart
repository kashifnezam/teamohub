import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../repositories/agent_promotion_repository.dart';

class AgentPromotionRequestsController extends GetxController {
  final AgentPromotionRepository _repository = AgentPromotionRepository.instance;

  final RxBool isLoading = true.obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>>
  pendingPromotions = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>>
  activePromotions = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>>
  completedPromotions = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenPromotions();
  }

  void _listenPromotions() {
    _repository.pendingPromotions().listen((event) {
      pendingPromotions.assignAll(event.docs);
      isLoading.value = false;
    });

    _repository.activePromotions().listen((event) {
      activePromotions.assignAll(event.docs);
    });

    _repository.completedPromotions().listen((event) {
      completedPromotions.assignAll(event.docs);
    });
  }

  Future<void> acceptPromotion(String id) {
    return _repository.acceptPromotion(id);
  }

  Future<void> rejectPromotion(
      String id, {
        String? reason,
      }) {
    return _repository.rejectPromotion(
      id,
      reason: reason,
    );
  }

  Future<void> completePromotion(String id) {
    return _repository.markCompleted(id);
  }
}