import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/utils/custom_alert.dart';
import '../../../app/widgets/custom_widget.dart';
import '../../auth/models/user_model.dart';
import '../repository/profile_repository.dart';
import '../widgets/ProfileImagePreview.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repository = ProfileRepository.instance;
  final Rx<File?> selectedProfileImage = Rx<File?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Rxn<UserModel> user = Rxn<UserModel>();

  final RxBool isLoading = true.obs;
  final RxBool isUploadingImage = false.obs;

  StreamSubscription<UserModel>? _userSubscription;

  String get uid => _auth.currentUser?.uid ?? '';

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  @override
  void onClose() {
    _userSubscription?.cancel();
    super.onClose();
  }

  void loadProfile() {
    if (uid.isEmpty) {
      isLoading(false);
      return;
    }

    isLoading(true);

    _userSubscription?.cancel();

    _userSubscription = _repository.streamUser(uid).listen(
          (profile) {
        user.value = profile;
        isLoading(false);

      },
      onError: (e) {
        isLoading(false);
        print(e.toString());
        CustomAlert.errorAlert(
          title: "Error",
          e.toString(),
        );
      },
    );
  }

  Future<void> pickProfileImage() async {
    try {
      final File? image = await CustomWidget.imagePickFrom();

      if (image == null) return;

      final bool? shouldUpload = await showDialog<bool>(
        context: Get.context!,
        builder: (_) => ProfileImagePreview(
          image: image,
        ),
      );

      if (shouldUpload != true) {
        return;
      }
      selectedProfileImage.value = image;
      isUploadingImage(true);

      // CustomAlert.loadAlert("Uploading profile photo...");

      final File compressed = await CustomWidget.compressImage(image.path);

      final String photoUrl =
      await _repository.uploadProfileImage(
        uid: uid,
        image: compressed,
      );

      await _repository.updatePhoto(
        uid: uid,
        photoUrl: photoUrl,
      );

      CustomAlert.dismissAlert();

      isUploadingImage(false);

      CustomAlert.successAlert(
        title: "Success",
        "Profile photo updated.",
      );
    } catch (e) {
      CustomAlert.dismissAlert();
      isUploadingImage(false);

      CustomAlert.errorAlert(
        title: "Upload Failed",
        e.toString(),
      );
    }
  }

  void editProfile() {
    // TODO:
    // Get.toNamed(AppRoutes.editProfile);
  }

  void changeLocation() {
    // TODO:
    // Get.toNamed(AppRoutes.locationPicker);
  }

  void openMyAds() {
    Get.toNamed(Routes.myAds);
  }

  void openFavourites() {
    Get.toNamed(Routes.bannerForm);
  }

  void openChats() {
    Get.toNamed(Routes.chats);
  }

  void openNotifications() {
    // TODO:
    Get.toNamed(Routes.bannerManagement);
  }

  void openPrivacyPolicy() {
    // TODO:
    // Get.toNamed(AppRoutes.privacyPolicy);
  }

  void openTerms() {
    // TODO:
    // Get.toNamed(AppRoutes.terms);
  }

  void openHelpSupport() {
    // TODO:
    // Get.toNamed(AppRoutes.helpSupport);
  }

  Future<void> deleteAccount() async {
    final bool? confirm =
    await CustomWidget.confirmDialogue(
      title: "Delete Account",
      content: "This feature will be available soon.\n\nDo you want to continue?",
      confirm: "Continue",
    );

    if (confirm != true) return;

    CustomAlert.infoAlert(
      title: "Coming Soon",
      "Delete account is not implemented yet.",
    );
  }
}