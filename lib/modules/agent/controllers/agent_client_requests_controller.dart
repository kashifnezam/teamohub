import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/utils/custom_alert.dart';
import '../../product/models/product_model.dart';
import '../../product/repositories/product_repository.dart';
import '../models/agent_client_request_model.dart';
import '../models/agent_request_model.dart';
import '../repositories/agent_request_repository.dart';

class AgentClientRequestsController extends GetxController {
  final AgentRequestRepository _repository = AgentRequestRepository.instance;

  final ProductRepository _productRepository = ProductRepository();

  final RxBool isLoading = true.obs;

  final RxList<AgentClientRequestModel> pendingRequests = <AgentClientRequestModel>[].obs;

  final RxList<AgentClientRequestModel> activeRequests = <AgentClientRequestModel>[].obs;

  final RxList<AgentClientRequestModel> completedRequests = <AgentClientRequestModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenRequests();
  }

  void _listenRequests() {
    _repository.streamPendingRequests().listen((requests) async {
      pendingRequests.assignAll(
        await _buildRequestList(requests),
      );
      isLoading.value = false;
    });

    _repository.streamAcceptedRequests().listen((requests) async {
      activeRequests.assignAll(
        await _buildRequestList(requests),
      );
    });

    _repository.streamCompletedRequests().listen((requests) async {
      completedRequests.assignAll(
        await _buildRequestList(requests),
      );
    });
  }

  Future<List<AgentClientRequestModel>> _buildRequestList(
      List<AgentRequestModel> requests,
      ) async {
    final List<AgentClientRequestModel> list = [];

    for (final request in requests) {
      ProductModel? product;

      try {
        product = await _productRepository.getProduct(
          request.productId,
        );
      } catch (_) {}

      if (product == null) continue;

      list.add(
        AgentClientRequestModel(
          id: request.id,
          request: request.toJson(),
          product: product,
        ),
      );
    }

    return list;
  }

  Future<void> acceptRequest({
    required AgentClientRequestModel request,
  }) async {
    CustomAlert.loadAlert(
      "Accepting request...",
    );

    try {
      // await _repository.acceptRequest(
      //   request.id,
      // );

      CustomAlert.dismissAlert();

      Get.toNamed(
        AppRoutes.agentCreateListing,
        arguments: request,
      );
    } catch (e) {
      CustomAlert.dismissAlert();

      CustomAlert.errorAlert(
        title: "Failed",
        e.toString(),
      );
    }
  }

  Future<void> rejectRequest(String requestId) async {
    await _repository.rejectRequest(requestId);
  }

  Future<void> completeRequest(String requestId) async {
    await _repository.completeRequest(requestId);
  }
}