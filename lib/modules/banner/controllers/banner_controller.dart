import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/routes/app_routes.dart';

import '../../../app/utils/custom_alert.dart';
import '../../../app/widgets/custom_widget.dart';
import '../models/banner_model.dart';
import '../repository/banner_repository.dart';

class BannerController extends GetxController {
  final BannerRepository _repository = BannerRepository();

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final actionValueController = TextEditingController();
  final orderController = TextEditingController(text: "1");

  final Rx<File?> image = Rx<File?>(null);

  final RxString actionType = "none".obs;
  final RxBool isActive = true.obs;
  final RxBool isSaving = false.obs;

  BannerModel? banner;

  bool get isEdit => banner != null;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      banner = Get.arguments as BannerModel;

      titleController.text = banner!.title ?? "";
      subtitleController.text = banner!.subtitle ?? "";
      actionValueController.text = banner!.actionValue ?? "";
      orderController.text = banner!.order.toString();

      actionType.value = banner!.actionType ?? "none";
      isActive.value = banner!.isActive;
    }
  }

  Future<void> pickImage() async {
    final picked = await CustomWidget.imagePickFrom();

    if (picked == null) return;

    final compressed = await CustomWidget.compressImage(picked.path);

    image.value = compressed;
  }

  void removeImage() {
    image.value = null;
  }

  Future<void> saveBanner() async {
    if (!isEdit && image.value == null) {
      CustomAlert.infoAlert(
        title: "Banner Image",
        "Please select a banner image.",
      );
      return;
    }

    if (titleController.text.trim().isEmpty) {
      CustomAlert.infoAlert(
        title: "Title",
        "Please enter banner title.",
      );
      return;
    }

    if (orderController.text.trim().isEmpty) {
      CustomAlert.infoAlert(
        title: "Display Order",
        "Please enter display order.",
      );
      return;
    }

    isSaving.value = true;
    CustomAlert.loadAlert("Uploading banner...");
    try {
      final model = BannerModel(
        id: banner?.id ?? "",
        imageUrl: banner?.imageUrl ?? "",
        title: titleController.text.trim(),
        subtitle: subtitleController.text.trim(),
        actionType: actionType.value,
        actionValue: actionValueController.text.trim(),
        order: int.parse(orderController.text),
        isActive: isActive.value,
        createdAt: banner?.createdAt ?? DateTime.now(),
        updatedAt: banner?.updatedAt ?? DateTime.now(),
      );

      if (isEdit) {
        await _repository.updateBanner(
          banner: model,
          image: image.value,
        );
      } else {
        await _repository.createBanner(
          banner: model,
          image: image.value!,
        );
      }
      CustomAlert.dismissAlert();
      Get.back(result: true);
      CustomAlert.successAlert(
        title: "Success",
        isEdit ? "Banner updated successfully.": "Banner created successfully.",
      );


    } catch (e) {
      CustomAlert.errorAlert(
        title: "Error",
        e.toString(),
      );
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    subtitleController.dispose();
    actionValueController.dispose();
    orderController.dispose();
    super.onClose();
  }
}