import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/routes/app_routes.dart';

import '../../../app/services/location_api_service.dart';
import '../../../app/utils/custom_alert.dart';
import '../../../app/widgets/custom_widget.dart';
import '../../location/models/city_model.dart';
import '../../location/models/state_model.dart';
import '../../profile/widgets/ProfileImagePreview.dart';
import '../models/agent_location_model.dart';
import '../models/agent_model.dart';
import '../repositories/agent_repository.dart';
import '../views/city_picker_page.dart';
import '../views/state_picker_page.dart';

class AgentController extends GetxController {
  final AgentRepository _repository = AgentRepository.instance;

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();
  final experienceController = TextEditingController();
  final commissionController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingAgent = true.obs;

  final Rx<File?> profileImage = Rx<File?>(null);

  final RxString profileImageUrl = ''.obs;

  final RxString selectedCommissionType = 'Percentage'.obs;

  final RxList<String> selectedStates = <String>[].obs;
  final RxList<String> selectedCities = <String>[].obs;
  final RxList<String> selectedLanguages = <String>[].obs;

  final RxInt yearsOfExperience = 0.obs;
  final RxBool acceptTerms = false.obs;
  final RxString verificationDocumentName = "".obs;
  File? verificationDocument;

  static const int maxStates = 3;
  static const int maxCities = 10;
  final RxBool loadingStates = false.obs;
  final RxBool loadingCities = false.obs;
  final RxList<StateModel> states = <StateModel>[].obs;
  final RxList<CityModel> cities = <CityModel>[].obs;
  final RxList<AgentLocationModel> operatingAreas = <AgentLocationModel>[].obs;
  final Rx<AgentModel?> agent = Rx<AgentModel?>(null);
  final RxBool editMode = false.obs;
  bool get hasAgentProfile => agent.value != null;
  final LocationApiService _locationService = LocationApiService();

  @override
  void onInit() {
    super.onInit();
    fetchAgent();
    loadStates();
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

  int get totalStates => operatingAreas.length;

  int get totalCities =>
      operatingAreas.fold(
        0,
            (value, element) => value + element.cities.length,
      );

  Future<void> loadStates() async {
    try {
      loadingStates(true);

      final result = await _locationService.getStates(
        "India",
      );

      states.assignAll(result);
    } finally {
      loadingStates(false);
    }
  }
  Future<void> loadCities(
      String state,
      ) async {
    try {
      loadingCities(true);

      final result = await _locationService.getCities(
        "India",
        state,
      );

      cities.assignAll(result);
    } finally {
      loadingCities(false);
    }
  }

  void removeState(
      AgentLocationModel area,
      ) {
    operatingAreas.remove(area);
  }

  void removeCity(
      AgentLocationModel area,
      CityModel city,
      ) {
    final index =
    operatingAreas.indexOf(area);

    if (index == -1) return;

    final updated =
    List<CityModel>.from(area.cities);

    updated.remove(city);

    operatingAreas[index] =
        area.copyWith(cities: updated);
  }

  Future<void> openStatePicker() async {

    final StateModel? state = await Get.to<StateModel>( () => const StatePickerPage(),);

    if (state == null) {
      return;
    }

    operatingAreas.add(
      AgentLocationModel(
        state: state,
      ),
    );
  }

  Future<void> openCityPicker(
      AgentLocationModel area,
      ) async {

    if (totalCities >= maxCities) {
      Get.snackbar(
        "Limit Reached",
        "Maximum 10 cities allowed.",
      );
      return;
    }

    final CityModel? city = await Get.to<CityModel>(() => CityPickerPage(area: area));

    if (city == null) {
      return;
    }

    final index = operatingAreas.indexOf(area);

    if (index == -1) {
      return;
    }

    final cities = List<CityModel>.from(area.cities);

    if (cities.any((e) => e.id == city.id)) {
      return;
    }
    cities.add(city);
    operatingAreas[index] = area.copyWith(cities: cities);
  }

  Future<void> pickVerificationDocument() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'zip'],
    );

    if (result == null) return;

    final file = File(result.files.single.path!);

    if (await file.length() > 1024 * 1024) {
      CustomAlert.errorAlert("File size must be less than 1 MB.");
      return;
    }

    verificationDocument = file;
    verificationDocumentName.value = result.files.single.name;
  }

  Future<void> fetchAgent() async {
    try {
      final data = await _repository.getAgentDetails();
      if (data == null) return;
      if (!data.isAgent) return;
      agent.value = data;
      populateForm(data);
    } catch (_) {}
    finally{
      isLoadingAgent.value = false;
    }
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

    selectedLanguages.assignAll(data.languages);
    operatingAreas.assignAll(data.operatingAreas);
  }

  Future<void> pickProfileImage() async {
    final File? image = await CustomWidget.imagePickFrom();

    if (image == null) return;

    final bool? shouldUpload = await showDialog<bool>(
      context: Get.context!,
      builder: (_) => ProfileImagePreview(image: image),
    );

    if (shouldUpload != true) return;

    profileImage.value =
    await CustomWidget.compressImage(image.path);
  }


  bool validateForm() {
    if (!(formKey.currentState?.validate() ?? false)) {
      return false;
    }

    if (profileImage.value == null &&
        profileImageUrl.value.isEmpty) {
      CustomAlert.errorAlert(
        "Please select a profile image.",
      );
      return false;
    }

    if (operatingAreas.isEmpty) {
      CustomAlert.errorAlert(
        "Please add at least one operating area.",
      );
      return false;
    }

    if (totalCities == 0) {
      CustomAlert.errorAlert(
        "Please add at least one operating city.",
      );
      return false;
    }

    if (selectedLanguages.isEmpty) {
      CustomAlert.errorAlert(
        "Please select at least one language.",
      );
      return false;
    }

    if (commissionController.text.trim().isEmpty) {
      CustomAlert.errorAlert(
        "Please enter your commission.",
      );
      return false;
    }

    if (!acceptTerms.value) {
      CustomAlert.errorAlert(
        "Please accept the Terms & Conditions.",
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

      CustomAlert.loadAlert("Submitting...");

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
        operatingAreas: operatingAreas.toList(),
        commissionType: selectedCommissionType.value,
        commissionValue: double.tryParse(commissionController.text) ?? 0,
        verificationStatus: agent.value?.verificationStatus ?? "pending",
        createdAt: agent.value?.createdAt,
        updatedAt: null,
      );

      await _repository.saveAgent(
        agent: model,
        imageFile: profileImage.value,
        verificationFile: verificationDocument,
      );

      CustomAlert.dismissAlert();
      Get.back(result: true);
      CustomAlert.successAlert(
        hasAgentProfile
            ? "Agent profile updated successfully."
            : "Agent registration submitted successfully.",
      );

    } catch (e) {
      CustomAlert.dismissAlert();

      CustomAlert.errorAlert(
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void addLanguage(String language) {
    if (selectedLanguages.contains(language)) {
      return;
    }

    selectedLanguages.add(language);
  }

  void removeLanguage(String language) {
    selectedLanguages.remove(language);
  }

  void openEditProfile() {
    editMode.value = true;
    Get.toNamed(AppRoutes.agent);
  }

}