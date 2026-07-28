import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../repositories/agent_analytics_repository.dart';

class AgentAnalyticsController extends GetxController {
  final AgentAnalyticsRepository _repository = AgentAnalyticsRepository.instance;

  final RxBool isLoading = true.obs;

  final RxInt totalListings = 0.obs;
  final RxInt activeListings = 0.obs;
  final RxInt completedDeals = 0.obs;

  final RxInt totalViews = 0.obs;
  final RxInt totalShares = 0.obs;
  final RxInt totalChats = 0.obs;
  final RxInt totalEnquiries = 0.obs;

  final RxDouble totalCommission = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    _repository.myListings().listen(_calculateAnalytics);
  }

  void _calculateAnalytics(
      QuerySnapshot<Map<String, dynamic>> snapshot,
      ) {
    totalListings.value = snapshot.docs.length;

    int active = 0;
    int completed = 0;

    int views = 0;
    int shares = 0;
    int chats = 0;
    int enquiries = 0;

    double commission = 0;

    for (final doc in snapshot.docs) {
      final data = doc.data();

      if (data["status"] == "active") {
        active++;
      }

      if (data["dealStatus"] == "completed") {
        completed++;
      }

      views += (data["viewCount"] ?? 0) as int;
      shares += (data["shareCount"] ?? 0) as int;
      chats += (data["chatCount"] ?? 0) as int;
      enquiries += (data["enquiryCount"] ?? 0) as int;

      commission +=
          ((data["commissionEarned"] ?? 0) as num)
              .toDouble();
    }

    activeListings.value = active;
    completedDeals.value = completed;

    totalViews.value = views;
    totalShares.value = shares;
    totalChats.value = chats;
    totalEnquiries.value = enquiries;

    totalCommission.value = commission;

    isLoading.value = false;
  }
}