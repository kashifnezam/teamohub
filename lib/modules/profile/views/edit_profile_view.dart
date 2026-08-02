import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  Future<void> _pickBirthDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
      controller.birthDate.value ??
          DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      controller.birthDate.value = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor:
        const Color(0xffF6F7FB),

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: false,
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        bottomNavigationBar: SafeArea(
          minimum:
          const EdgeInsets.fromLTRB(
            24,
            12,
            24,
            20,
          ),
          child: SizedBox(
            height: 56,
            child: FilledButton(
              style:
              FilledButton.styleFrom(
                backgroundColor:
                AppColors.primary,
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    16,
                  ),
                ),
              ),
              onPressed:
              controller.isLoading.value
                  ? null
                  : controller
                  .updateProfile,
              child:
              controller.isLoading.value
                  ? const SizedBox(
                width: 22,
                height: 22,
                child:
                CircularProgressIndicator(
                  strokeWidth: 2,
                  color:
                  Colors.white,
                ),
              )
                  : const Text(
                "Save Changes",
                style:
                TextStyle(
                  fontSize: 16,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        body: Form(
          key: controller.formKey,
          child: ListView(
            padding:
            const EdgeInsets.all(24),
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                decoration:
                BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(
                    24,
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor:
                      AppColors.primary
                          .withValues(
                        alpha: .08,
                      ),
                      child: Icon(
                        Icons.person,
                        color:
                        AppColors.primary,
                        size: 42,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    const Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      "Keep your information updated for a better TeamoMart experience.",
                      textAlign:
                      TextAlign.center,
                      style: TextStyle(
                        color: Colors
                            .grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),
              _buildFieldLabel(
                "Full Name",
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller:
                controller.nameController,
                textCapitalization:
                TextCapitalization.words,
                decoration: _inputDecoration(
                  hint: "Enter your full name",
                  icon: Icons.badge_outlined,
                ),
                validator:
                controller.validateName,
              ),

              const SizedBox(height: 20),

              _buildFieldLabel(
                "Gender",
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                initialValue: controller.gender.value,
                decoration: _inputDecoration(
                  hint: "Select gender",
                  icon: Icons.person_outline,
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Male",
                    child: Text("Male"),
                  ),
                  DropdownMenuItem(
                    value: "Female",
                    child: Text("Female"),
                  ),
                  DropdownMenuItem(
                    value: "Other",
                    child: Text("Other"),
                  ),
                ],
                validator: controller.validateGender,
                onChanged: (value) {
                  controller.gender.value = value!;
                },
              ),

              const SizedBox(height: 20),

              _buildFieldLabel(
                "Phone Number",
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller:
                controller.phoneController,
                keyboardType:
                TextInputType.phone,
                maxLength: 10,
                decoration:
                _inputDecoration(
                  hint:
                  "Enter mobile number",
                  icon: Icons.call_outlined,
                ).copyWith(
                  counterText: "",
                ),
                validator:
                controller.validatePhone,
              ),

              const SizedBox(height: 20),

              _buildFieldLabel(
                "Birth Date",
              ),

              const SizedBox(height: 8),

              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => controller.pickBirthDate(context),
                child: IgnorePointer(
                  child: TextFormField(
                    controller: controller.birthDateController,
                    decoration: _inputDecoration(
                      hint: "Select birth date",
                      icon: Icons.cake_outlined,
                    ).copyWith(
                      suffixIcon: const Icon(
                        Icons.calendar_today_outlined,
                      ),
                    ),
                    validator: (_) {
                      if (controller.birthDate.value == null) {
                        return "Please select your birth date.";
                      }

                      return null;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              _buildFieldLabel(
                "Email Address",
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller:
                controller.emailController,
                readOnly: true,
                decoration:
                _inputDecoration(
                  hint: "",
                  icon: Icons
                      .alternate_email,
                ).copyWith(
                  suffixIcon:
                  const Icon(
                    Icons.lock_outline,
                  ),
                ),
              ),

              if (controller
                  .errorMessage
                  .value
                  .isNotEmpty) ...[
                const SizedBox(
                  height: 24,
                ),

                Container(
                  width:
                  double.infinity,
                  padding:
                  const EdgeInsets.all(
                    16,
                  ),
                  decoration:
                  BoxDecoration(
                    color: Colors.red
                        .withValues(
                      alpha: .08,
                    ),
                    borderRadius:
                    BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color:
                        Colors.red,
                      ),

                      const SizedBox(
                        width: 12,
                      ),

                      Expanded(
                        child: Text(
                          controller
                              .errorMessage
                              .value,
                          style:
                          const TextStyle(
                            color:
                            Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    });
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: AppColors.primary,
      ),
      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}