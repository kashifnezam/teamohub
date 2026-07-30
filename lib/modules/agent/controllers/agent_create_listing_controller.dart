import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/constants/app_constants.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/utils/custom_alert.dart';
import '../../product/models/product_model.dart';
import '../models/agent_client_request_model.dart';
import '../repositories/agent_listing_repository.dart';

class AgentCreateListingController extends GetxController {
  final AgentListingRepository _repository = AgentListingRepository.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final sellingNotesController = TextEditingController();

  final priceController = TextEditingController();

  final RxBool isSaving = false.obs;

  final RxList<String> images = <String>[].obs;

  late final AgentClientRequestModel request;

  late final ProductModel product;

  @override
  void onInit() {
    super.onInit();

    request = Get.arguments as AgentClientRequestModel;

    product = request.product;

    _fillProduct();
  }

  void _fillProduct() {
    titleController.text = product.title;

    descriptionController.text = product.description;

    priceController.text = product.price.toString();

    sellingNotesController.clear();

    images.assignAll(product.images);
  }

  Future<void> createListing() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final double? price = double.tryParse(priceController.text);

    if (price == null || price <= 0) {
      CustomAlert.errorAlert(
        title: "Invalid Price",
        "Enter a valid selling price.",
      );
      return;
    }

    isSaving.value = true;

    try {
      final prodId = await _repository.createAgentProduct(
          product: product,
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          price: price);
        AppConstants.log.i(prodId);
      final listingId = await _repository.createListing(
        agentProductId: prodId,
        requestId: request.id,
        originalProductId: product.id,
        sellingNotes: sellingNotesController.text.trim(),
      );

      CustomAlert.successAlert(
        title: "Listing Created",
        "Your listing is now live.",
      );

      Get.offAllNamed(
        AppRoutes.agentMyListings,
        arguments: listingId,
      );
    } catch (e) {
      CustomAlert.errorAlert(
        title: "Failed",
        e.toString(),
      );
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    sellingNotesController.dispose();
    priceController.dispose();

    super.onClose();
  }
}