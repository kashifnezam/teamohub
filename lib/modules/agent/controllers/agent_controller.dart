import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/utils/custom_alert.dart';
import '../models/agent_model.dart';
import '../repositories/agent_repository.dart';

class AgentController extends GetxController {
  final AgentRepository _repository = AgentRepository.instance;

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();
  final experienceController = TextEditingController();
  final commissionController = TextEditingController();

  final RxBool isLoading = false.obs;

  final Rx<File?> profileImage = Rx<File?>(null);

  final RxString profileImageUrl = ''.obs;

  final RxString selectedCommissionType = 'Percentage'.obs;

  final RxList<String> selectedStates = <String>[].obs;
  final RxList<String> selectedCities = <String>[].obs;
  final RxList<String> selectedLanguages = <String>[].obs;

  final RxInt yearsOfExperience = 0.obs;

  final RxBool acceptTerms = false.obs;

  final Rx<AgentModel?> agent = Rx<AgentModel?>(null);

  bool get isEdit => agent.value?.isAgent == true;

  @override
  void onInit() {
    super.onInit();
    fetchAgent();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    aboutController.dispose();
    experienceController.dispose();
    commissionController.dispose();
    super.onClose();
  }

  Future<void> fetchAgent() async {
    try {
      final data = await _repository.getAgentDetails();

      if (data == null) return;

      if (!data.isAgent) return;

      agent.value = data;

      populateForm(data);
    } catch (_) {}
  }

  void populateForm(AgentModel data) {
    nameController.text = data.agentName;
    phoneController.text = data.phone;
    aboutController.text = data.about;
    experienceController.text = data.experience;

    yearsOfExperience.value = data.yearsOfExperience;

    commissionController.text =
        data.commissionValue.toStringAsFixed(
          data.commissionValue % 1 == 0 ? 0 : 2,
        );

    profileImageUrl.value = data.profileImage;

    selectedCommissionType.value = data.commissionType;

    selectedStates.assignAll(data.serviceStates);
    selectedCities.assignAll(data.serviceCities);
    selectedLanguages.assignAll(data.languages);
  }

  Future<void> pickProfileImage() async {
    /// Use your existing image picker here.
    ///
    /// Example:
    ///
    /// final file = await ImagePickerService.pickCompressImage();
    ///
    /// if(file!=null){
    ///    profileImage.value=file;
    /// }
  }

  bool validateForm() {
    if (!(formKey.currentState?.validate() ?? false)) {
      return false;
    }

    if (profileImage.value == null &&
        profileImageUrl.value.isEmpty) {
      CustomAlert.errorAlert(
        "Please select profile image.",
      );
      return false;
    }

    if (selectedStates.isEmpty ||
        selectedCities.isEmpty) {
      CustomAlert.errorAlert(
        "Please select service area.",
      );
      return false;
    }

    if (commissionController.text.trim().isEmpty) {
      CustomAlert.errorAlert(
        "Please enter commission.",
      );
      return false;
    }

    if (!acceptTerms.value) {
      CustomAlert.errorAlert(
        "Please accept terms & conditions.",
      );
      return false;
    }

    return true;
  }

  Future<void> submit() async {
    if (isLoading.value) return;

    if (!validateForm()) return;

    try {
      isLoading.value = true;

      CustomAlert.loadAlert("Loading...");

      final model = AgentModel(
        uid: agent.value?.uid ?? '',
        isAgent: true,
        agentStatus: agent.value?.agentStatus ?? "pending",
        agentName: nameController.text.trim(),
        phone: phoneController.text.trim(),
        profileImage: profileImageUrl.value,
        about: aboutController.text.trim(),
        experience: experienceController.text.trim(),
        yearsOfExperience: yearsOfExperience.value,
        languages: selectedLanguages.toList(),
        serviceStates: selectedStates.toList(),
        serviceCities: selectedCities.toList(),
        commissionType: selectedCommissionType.value,
        commissionValue:
        double.tryParse(commissionController.text) ??
            0,
        verificationStatus:
        agent.value?.verificationStatus ??
            "pending",
        createdAt: agent.value?.createdAt,
        updatedAt: null,
      );

      await _repository.saveAgent(
        agent: model,
        imageFile: profileImage.value,
      );

      CustomAlert.dismissAlert();

      CustomAlert.successAlert(
        isEdit
            ? "Agent profile updated successfully."
            : "Agent registration submitted successfully.",
      );

      Get.back(result: true);
    } catch (e) {
      CustomAlert.dismissAlert();

      CustomAlert.errorAlert(
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}