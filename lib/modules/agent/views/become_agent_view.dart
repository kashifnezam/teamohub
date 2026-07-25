import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/utils/app_colors.dart';
import '../controllers/agent_controller.dart';
import '../widgets/commission_selector.dart';
import '../widgets/profile_image_picker.dart';
import '../widgets/service_area_selector.dart';

class BecomeAgentView extends GetView<AgentController> {
  const BecomeAgentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          controller.isEdit ? "Update Agent" : "Become an Agent",
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const ProfileImagePicker(),

              const SizedBox(height: 24),

              _card(
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(
                        labelText: "Full Name",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Phone is required";
                        }

                        if (value.trim().length < 10) {
                          return "Invalid phone number";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.aboutController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: "About",
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "About is required";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              _card(
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.experienceController,
                      decoration: const InputDecoration(
                        labelText: "Experience",
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                          () => DropdownButtonFormField<int>(
                        initialValue: controller.yearsOfExperience.value,
                        decoration: const InputDecoration(
                          labelText: "Years of Experience",
                        ),
                        items: List.generate(
                          31,
                              (index) => DropdownMenuItem(
                            value: index,
                            child: Text("$index Years"),
                          ),
                        ),
                        onChanged: (value) {
                          if (value != null) {
                            controller.yearsOfExperience.value = value;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text("Languages"),
                      subtitle: Obx(
                            () => controller.selectedLanguages.isEmpty
                            ? const Text("Select languages")
                            : Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: controller.selectedLanguages
                              .map(
                                (e) => Chip(
                              label: Text(e),
                              onDeleted: () => controller
                                  .selectedLanguages
                                  .remove(e),
                            ),
                          )
                              .toList(),
                        ),
                      ),
                      trailing:
                      const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () async {
                        /// Open your existing multi-language picker.
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const ServiceAreaSelector(),

              const SizedBox(height: 16),

              const CommissionSelector(),

              const SizedBox(height: 16),

              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Obx(
                      () => CheckboxListTile(
                    value: controller.acceptTerms.value,
                    onChanged: (value) {
                      controller.acceptTerms.value =
                          value ?? false;
                    },
                    title: const Text(
                      "I agree to the Terms & Conditions",
                    ),
                    controlAffinity:
                    ListTileControlAffinity.leading,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Obx(
                    () => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      controller.isEdit
                          ? "Update Agent"
                          : "Become an Agent",
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}