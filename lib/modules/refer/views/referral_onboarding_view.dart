import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/utils/custom_alert.dart';
import '../controllers/refer_controller.dart';

class ReferralOnboardingView extends GetView<ReferController> {
  ReferralOnboardingView({super.key});

  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Column(
                children: [

                  const SizedBox(height: 20),

                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: .08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.card_giftcard_rounded,
                      size: 52,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Got a Referral Code?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Enter your friend's referral code and both of you will instantly receive 10 Reward Points.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 36),

                  TextField(
                    controller: codeController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: "Referral Code",
                      prefixIcon: const Icon(Icons.qr_code_rounded),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.redeem_rounded),
                      label: const Text("Apply Referral"),
                      onPressed: () async {
                        final code =
                        codeController.text.trim().toUpperCase();

                        if (code.isEmpty) {
                          CustomAlert.infoAlert(
                            "Please enter referral code.",
                          );
                          return;
                        }

                        try {
                          CustomAlert.loadAlert("Please wait...");

                          final valid = await controller.validateReferral(code);

                          if (!valid) {
                            CustomAlert.dismissAlert();

                            CustomAlert.errorAlert(
                              "Invalid referral code.",
                            );

                            return;
                          }

                          await controller.applyReferral(code);

                          CustomAlert.dismissAlert();

                          CustomAlert.successAlert(
                            "Congratulations!\n10 Reward Points added.",
                          );

                          Get.offAllNamed(AppRoutes.splash);
                        } on FirebaseFunctionsException catch (e) {
                          CustomAlert.dismissAlert();

                          switch (e.code) {
                            case 'not-found':
                              CustomAlert.errorAlert("Invalid referral code.");
                              break;

                            case 'failed-precondition':
                              CustomAlert.errorAlert(e.message ?? "Referral cannot be applied.");
                              break;

                            case 'already-exists':
                              CustomAlert.errorAlert("Referral has already been used.");
                              break;

                            case 'invalid-argument':
                              CustomAlert.errorAlert("Please enter a valid referral code.");
                              break;

                            case 'unauthenticated':
                              CustomAlert.errorAlert("Please login again.");
                              break;

                            case 'permission-denied':
                              CustomAlert.errorAlert("Permission denied.");
                              break;

                            default:
                              CustomAlert.errorAlert(
                                e.message ?? "Something went wrong. Please try again.",
                              );
                          }
                        } catch (e) {
                          CustomAlert.dismissAlert();

                          CustomAlert.errorAlert(
                            "Something went wrong. Please try again.",
                          );
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.splash);
                    },
                    child: const Text("Skip for now"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}