import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../repositories/agent_listing_repository.dart';

class AgentMyListingsController extends GetxController {
  final AgentListingRepository _repository = AgentListingRepository.instance;

  final RxBool isLoading = true.obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>> listings =
      <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenListings();
  }

  void _listenListings() {
    _repository.myListings().listen((event) {
      listings.assignAll(event.docs);
      isLoading.value = false;
    });
  }

  Future<void> refreshListings() async {
    isLoading.value = true;
    _listenListings();
  }

  Future<void> markSold(String listingId) {
    return _repository.markSold(listingId);
  }

  Future<void> deactivate(String listingId) {
    return _repository.deactivateListing(listingId);
  }
}