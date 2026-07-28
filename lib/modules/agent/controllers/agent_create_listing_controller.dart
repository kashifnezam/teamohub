import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repositories/agent_listing_repository.dart';

class AgentCreateListingController extends GetxController {
  final AgentListingRepository _repository = AgentListingRepository.instance;

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final sellingNotesController = TextEditingController();

  final RxBool isSaving = false.obs;

  final RxList<String> images = <String>[].obs;

  late final Map<String, dynamic> promotion;

  @override
  void onInit() {
    super.onInit();

    promotion = Map<String, dynamic>.from(Get.arguments);

    titleController.text = promotion["productTitle"] ?? "";
    descriptionController.text = promotion["description"] ?? "";

    images.assignAll(
      List<String>.from(
        promotion["images"] ?? [],
      ),
    );
  }

  Future<void> createListing() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    isSaving.value = true;

    final listingId =
    await _repository.createAgentListing(
      originalProductId: promotion["productId"],
      sellerId: promotion["sellerId"],
      promotionRequestId: promotion["id"],
      title: titleController.text.trim(),
      description:
      descriptionController.text.trim(),
      images: images,
      sellingNotes:
      sellingNotesController.text.trim(),
    );

    final shareUrl =
        "https://teamomart.web.app/a/$listingId";

    await _repository.updateShareUrl(
      listingId: listingId,
      url: shareUrl,
    );

    isSaving.value = false;

    Get.back(result: true);
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    sellingNotesController.dispose();
    super.onClose();
  }
}