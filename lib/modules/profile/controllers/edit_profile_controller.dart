import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teamomarket/modules/profile/controllers/profile_controller.dart';

import '../../../app/utils/custom_alert.dart';
import '../../auth/models/user_model.dart';
import '../repository/profile_repository.dart';

class EditProfileController extends GetxController {
  final ProfileRepository _repository = ProfileRepository.instance;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final birthDateController = TextEditingController();

  RxString gender = 'Male'.obs;
  final birthDate = Rx<DateTime?>(null);

  final isLoading = false.obs;
  final errorMessage = "".obs;

  UserModel? _user;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    final profile = Get.find<ProfileController>().user.value;

    if (profile == null) {
      errorMessage.value = "Unable to load profile.";
      return;
    }

    _user = profile;
    nameController.text = profile.name;
    phoneController.text = profile.phone;
    emailController.text = profile.email;

    gender.value = profile.gender ?? "Male";

    birthDate.value = profile.dob;

    _updateBirthDateText();
  }

  Future<void> pickBirthDate(
      BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
      birthDate.value ??
          DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked == null) return;

    birthDate.value = picked;
    _updateBirthDateText();
  }

  void _updateBirthDateText() {
    birthDateController.text = DateFormat(
      "dd MMM yyyy",
    ).format(
      birthDate.value!,
    );
  }

  String? validateName(String? value) {
    value = value?.trim() ?? "";

    if (value.isEmpty) {
      return "Please enter your full name.";
    }

    if (value.length < 3) {
      return "Name must be at least 3 characters.";
    }

    if (value.length > 50) {
      return "Maximum 50 characters allowed.";
    }

    return null;
  }

  String? validatePhone(String? value) {
    value = value?.trim() ?? "";

    if (value.isEmpty) {
      return "Please enter your mobile number.";
    }

    if (!RegExp(
      r'^[0-9]{10}$',
    ).hasMatch(value)) {
      return "Please enter a valid 10 digit mobile number.";
    }

    return null;
  }

  String? validateGender(
      String? value) {
    if (value == null ||
        value.isEmpty) {
      return "Please select gender.";
    }

    return null;
  }

  Future<void> updateProfile() async {
    errorMessage.value = "";

    FocusManager.instance.primaryFocus?.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (birthDate.value == null) {
      errorMessage.value = "Please select your birth date.";
      return;
    }

    if (_user == null) {
      errorMessage.value = "Unable to load profile.";
      return;
    }

    try {
      isLoading.value = true;

      final updatedUser = _user!.copyWith(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        gender: gender.value,
        dob: birthDate.value,
      );

      await _repository.updateProfile(user: updatedUser);

      _user = updatedUser;
      // Update ProfileController
      Get.back(result: true);

      CustomAlert.successAlert(
        "Profile updated successfully.",
      );
    } catch (e) {
      errorMessage.value = e.toString();

      CustomAlert.errorAlert(
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    birthDateController.dispose();
    super.onClose();
  }
}