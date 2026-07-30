import 'dart:async';

import 'package:get/get.dart';

import '../models/agent_product_listing_model.dart';
import '../repositories/agent_listing_repository.dart';

class AgentMyListingsController extends GetxController {
  final AgentListingRepository _repository =
      AgentListingRepository.instance;

  final isLoading = true.obs;

  final listings = <AgentProductListingModel>[].obs;

  StreamSubscription<List<AgentProductListingModel>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    loadListings();
  }

  void loadListings() {
    _subscription?.cancel();

    isLoading.value = true;

    _subscription = _repository.myListings().listen(
          (items) {
        listings.assignAll(items);
        isLoading.value = false;
      },
      onError: (_) {
        isLoading.value = false;
      },
    );
  }

  Future<void> refreshListings() async {
    loadListings();
  }

  Future<void> markSold(
      AgentProductListingModel item,
      ) async {
    await _repository.markSold(item.listing.id);
  }

  Future<void> activate(
      AgentProductListingModel item,
      ) async {
    await _repository.activate(item.listing.id);
  }

  Future<void> deactivate(
      AgentProductListingModel item,
      ) async {
    await _repository.deactivate(item.listing.id);
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}