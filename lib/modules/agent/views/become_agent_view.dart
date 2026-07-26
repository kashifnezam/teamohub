import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';
import 'package:teamomarket/modules/agent/views/agent_rejected_view.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/agent_controller.dart';
import '../widgets/commission_selector.dart';
import '../widgets/profile_image_picker.dart';
import '../widgets/service_area_selector.dart';
import 'agent_pending_view.dart';
import 'language_picker_page.dart';

class BecomeAgentView extends GetView<AgentController> {
  const BecomeAgentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Obx(() => Text(
          controller.hasAgentProfile
              ? "Update Agent Profile"
              : "Become an Agent",
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),)
      ),

      body: Obx(() {
        if (controller.isLoadingAgent.value) {
          return CustomWidget.buildCircularProgressIndicator();
        }

        if (controller.editMode.value) {
          return const AgentRegistrationForm();
        }

        final agent = controller.agent.value;

        if (agent == null) {
          return const AgentRegistrationForm();
        }

        switch (agent.agentStatus) {
          case "pending":
            return const AgentPendingView();

          case 'rejected':
            return const AgentRejectedView();

          default:
            return const AgentRegistrationForm();
        }
      })
    );
  }
}

class AgentRegistrationForm extends GetView<AgentController> {
  const AgentRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.primary,
                    Color(0xff5B7CFA),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [

                  const ProfileImagePicker(),

                  const SizedBox(height: 18),

                  Obx(() =>  Text(
                    controller.hasAgentProfile
                        ? "Update Your Agent Profile"
                        : "Become a Verified Agent",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    "Help buyers and sellers close better deals, promote products, and earn commissions through TeamoMart.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: const [

                      _FeatureChip(
                        icon: Icons.verified_rounded,
                        text: "Verified",
                      ),

                      _FeatureChip(
                        icon: Icons.payments_rounded,
                        text: "Earn Commission",
                      ),

                      _FeatureChip(
                        icon: Icons.support_agent_rounded,
                        text: "Trusted Agent",
                      ),

                    ],
                  ),

                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Personal Information",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            _card(
              child: Column(
                children: [

                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffF6F7FB),
                      prefixIcon: const Icon(Icons.person_outline),
                      labelText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffF6F7FB),
                      prefixIcon: const Icon(Icons.phone_outlined),
                      labelText: "Phone Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
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
                    minLines: 4,
                    maxLines: 6,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffF6F7FB),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 80),
                        child: Icon(Icons.description_outlined),
                      ),
                      labelText: "Tell buyers about yourself",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
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

            const SizedBox(height: 24),

            const Text(
              "Professional Details",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TextFormField(
                    controller: controller.experienceController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffF6F7FB),
                      prefixIcon: const Icon(Icons.work_outline),
                      labelText: "Professional Background",
                      hintText: "Ex. Real Estate Consultant",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Years of Experience",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Obx(
                        () => DropdownButtonFormField<int>(
                      initialValue: controller.yearsOfExperience.value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffF6F7FB),
                        prefixIcon: const Icon(Icons.timeline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: List.generate(
                        31,
                            (index) => DropdownMenuItem(
                          value: index,
                          child: Text(
                            index == 0
                                ? "Fresher"
                                : "$index Years",
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          controller.yearsOfExperience.value = value;
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 22),

                  Row(
                    children: [

                      const Icon(
                        Icons.language,
                        color: AppColors.primary,
                        size: 20,
                      ),

                      const SizedBox(width: 8),

                      const Expanded(
                        child: Text(
                          "Languages",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      TextButton.icon(
                        onPressed: () async {
                          await Get.to(
                                () => const LanguagePickerPage(),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Add"),
                      ),

                    ],
                  ),

                  const SizedBox(height: 10),

                  Obx(() {

                    if (controller.selectedLanguages.isEmpty) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffF6F7FB),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text(
                            "No language selected",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }

                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.selectedLanguages
                          .map(
                            (language) => Chip(
                          elevation: 0,
                          backgroundColor:
                          AppColors.primary.withValues(alpha: .08),
                          side: BorderSide.none,
                          avatar: const Icon(
                            Icons.check_circle,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          label: Text(language),
                          deleteIcon: const Icon(
                            Icons.close,
                            size: 18,
                          ),
                          onDeleted: () {
                            controller.selectedLanguages.remove(
                              language,
                            );
                          },
                        ),
                      )
                          .toList(),
                    );

                  }),

                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Service Areas",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const ServiceAreaSelector(),

            const SizedBox(height: 24),

            const Text(
              "Commission",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const CommissionSelector(),

            const SizedBox(height: 10),
            const SizedBox(height: 24),

            const Text(
              "Verification (Optional)",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.verified_user_outlined,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Official Identity Document",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "Upload Aadhaar or any government-issued ID to increase buyer trust and speed up verification.",
                              style: TextStyle(
                                color: Colors.grey,
                                height: 1.4,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 18),

                  Obx(
                        () => InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: controller.pickVerificationDocument,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xffF6F7FB),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Column(
                          children: [

                            const Icon(
                              Icons.upload_file_rounded,
                              size: 36,
                              color: AppColors.primary,
                            ),

                            const SizedBox(height: 10),

                            Text(
                              controller.verificationDocumentName.value.isEmpty
                                  ? "Choose ZIP or PDF"
                                  : controller.verificationDocumentName.value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              "Accepted: PDF or ZIP\nMaximum file size: 1 MB",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
              ),
              child: Obx(
                    () => Column(
                  children: [

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Checkbox(
                          value: controller.acceptTerms.value,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            controller.acceptTerms.value =
                                value ?? false;
                          },
                        ),

                        const SizedBox(width: 4),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                                children: const [

                                  TextSpan(
                                    text:
                                    "I agree to the ",
                                  ),

                                  TextSpan(
                                    text:
                                    "Agent Terms & Conditions",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  TextSpan(
                                    text:
                                    " and understand that TeamoMart may verify my information before approving my Agent account.",
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xffEEF3FF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.verified_user_outlined,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Why become an Agent?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "• Promote products in your area\n"
                              "• Help buyers & sellers negotiate\n"
                              "• Build trust with verified listings\n"
                              "• Earn commission on successful deals",
                          style: TextStyle(
                            height: 1.6,
                            color: Colors.black87,
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            SafeArea(
              top: false,
              child: Obx(
                    () => SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.submit,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                      AppColors.primary.withValues(alpha: .6),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(16),
                      ),
                    ),
                    icon: controller.isLoading.value
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                      CircularProgressIndicator(
                        strokeWidth: 2.2,
                        color: Colors.white,
                      ),
                    )
                        : Icon(
                      controller.hasAgentProfile
                          ? Icons.save_outlined
                          : Icons.workspace_premium,
                    ),
                    label: Text(
                      controller.hasAgentProfile
                          ? "Update Agent Profile"
                          : "Become an Agent",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

          ],
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

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureChip({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}