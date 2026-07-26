import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../repositories/agent_request_repository.dart';

class AgentClientRequestsController extends GetxController {
  final AgentRequestRepository _repository = AgentRequestRepository.instance;

  final RxBool isLoading = true.obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>>
  pendingRequests =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>>
  activeRequests =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>>
  completedRequests =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenRequests();
  }

  void _listenRequests() {
    _repository.pendingRequests().listen((event) {
      pendingRequests.assignAll(event.docs);
      isLoading.value = false;
    });

    _repository.activeRequests().listen((event) {
      activeRequests.assignAll(event.docs);
    });

    _repository.completedRequests().listen((event) {
      completedRequests.assignAll(event.docs);
    });
  }

  Future<void> acceptRequest(String requestId) {
    return _repository.acceptRequest(requestId);
  }

  Future<void> rejectRequest(
      String requestId, {
        String? reason,
      }) {
    return _repository.rejectRequest(
      requestId: requestId,
      reason: reason,
    );
  }

  Future<void> completeRequest(String requestId) {
    return _repository.markCompleted(requestId);
  }
}