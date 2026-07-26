import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/utils/custom_alert.dart';
import '../repositories/agent_listing_share_repository.dart';


class AgentListingShareController extends GetxController {
  final AgentListingShareRepository _repository = AgentListingShareRepository.instance;

  final RxBool isLoading = false.obs;

  late final String listingId;

  late final String shareUrl;

  @override
  void onInit() {
    super.onInit();

    listingId = Get.arguments;

    shareUrl =
    "https://teamomart.web.app/a/$listingId";
  }

  Future<void> shareListing() async {
    try {
      isLoading.value = true;

      await SharePlus.instance.share(
          ShareParams(text: shareUrl, subject: "TeamoMart Listing")
      );
      await _repository.increaseShareCount(listingId);
      await _repository.updateLastShared();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> copyLink() async {
    await Clipboard.setData(
      ClipboardData(text: shareUrl),
    );

    CustomAlert.successAlert(
      title: "Copied",
      "Share link copied.",
    );
  }

  Future<void> openChat() async {
    await _repository.increaseEnquiryCount(
      listingId,
    );

    Get.back(result: true);
  }
}