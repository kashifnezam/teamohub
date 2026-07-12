import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/utils/app_colors.dart';
import '../../../app/utils/custom_alert.dart';
import '../controllers/signup_controller.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  final _formKey = GlobalKey<FormState>();
  final SignupController signupController = Get.put(SignupController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  final RxBool _obscurePassword = true.obs;
  final RxBool _obscureConfirmPassword = true.obs;

  final RxBool acceptTerms = false.obs;

  final RxString selectedRole = "Buyer".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isDesktop = constraints.maxWidth > 900;
          final bool isMobile = constraints.maxWidth < 600;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffF4FBFF),
                  Colors.white,
                ],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 40,
                  vertical: isMobile ? 30 : 60,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1000,
                  ),
                  child: isDesktop
                      ? _buildDesktopLayout()
                      : _buildMobileLayout(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //----------------------------------------------------------
  // MOBILE LAYOUT
  //----------------------------------------------------------

  Widget _buildMobileLayout() {
    return Column(
      children: [
        const SizedBox(height: 25),

        Image.asset(
          "assets/logo/logo.png",
          height: 100,
        ),

        const SizedBox(height: 10),

        const Text(
          "TeamoMart",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .06),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: _buildForm(),
        ),
      ],
    );
  }

  //----------------------------------------------------------
  // DESKTOP LAYOUT
  //----------------------------------------------------------

  Widget _buildDesktopLayout() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 35,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Row(
          children: [
            //------------------------------------------------
            // LEFT PANEL
            //------------------------------------------------

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo/logo.png",
                    height: 170,
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Join TeamoMart",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Buy • Sell • Earn\nIndia's Smart Marketplace",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.grey,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Icon(
                    Icons.storefront_rounded,
                    size: 80,
                    color: AppColors.secondary.withValues(alpha: .25),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 60),

            //------------------------------------------------
            // RIGHT PANEL
            //------------------------------------------------

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: _buildForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------
  // FORM
  //----------------------------------------------------------

  Widget _buildForm() {
    return Obx(
          () => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Join TeamoMart and start buying or selling today.",
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            //-------------------------------------------------
            // Full Name
            //-------------------------------------------------

            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter your full name";
                }
                return null;
              },
              decoration: _inputDecoration(
                "Full Name",
                Icons.person_outline,
              ),
            ),

            const SizedBox(height: 18),

            //-------------------------------------------------
            // Mobile Number
            //-------------------------------------------------

            TextFormField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().length != 10) {
                  return "Enter valid mobile number";
                }
                return null;
              },
              decoration: _inputDecoration(
                "Mobile Number",
                Icons.phone_outlined,
              ),
            ),

            const SizedBox(height: 18),

            //-------------------------------------------------
            // Email
            //-------------------------------------------------

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter email";
                }

                if (!GetUtils.isEmail(value.trim())) {
                  return "Enter valid email";
                }

                return null;
              },
              decoration: _inputDecoration(
                "Email Address",
                Icons.email_outlined,
              ),
            ),

            const SizedBox(height: 18),

            //-------------------------------------------------
            // Password
            //-------------------------------------------------

            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword.value,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
              decoration: _inputDecoration(
                "Password",
                Icons.lock_outline,
              ).copyWith(
                suffixIcon: IconButton(
                  splashRadius: 20,
                  onPressed: _obscurePassword.toggle,
                  icon: Icon(
                    _obscurePassword.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            //-------------------------------------------------
            // Confirm Password
            //-------------------------------------------------

            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword.value,
              validator: (value) {
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
              decoration: _inputDecoration(
                "Confirm Password",
                Icons.lock_reset_outlined,
              ).copyWith(
                suffixIcon: IconButton(
                  splashRadius: 20,
                  onPressed: _obscureConfirmPassword.toggle,
                  icon: Icon(
                    _obscureConfirmPassword.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),

            //-------------------------------------------------
            // Terms
            //-------------------------------------------------

            Material(
              color: Colors.transparent,
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: acceptTerms.value,
                onChanged: (value) {
                  acceptTerms.value = value ?? false;
                },
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  "I agree to the Terms & Conditions",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),

            const SizedBox(height: 18),

            //-------------------------------------------------
            // Create Account
            //-------------------------------------------------

            SizedBox(
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: signupController.isLoading.value
                    ? null
                    : () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  if (!acceptTerms.value) {
                    CustomAlert.infoAlert(
                      "Please accept the Terms & Conditions to continue.",
                      title: "Terms Required",
                    );
                    return;
                  }

                  await signupController.signUp(
                    fullName: _nameController.text.trim(),
                    mobile: _mobileController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                    confirmPassword:
                    _confirmPasswordController.text.trim(),
                  );
                },
                child: signupController.isLoading.value
                    ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
                    : const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),

            Row(
              children: [
                const Expanded(child: Divider()),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),

                const Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 24),

            OutlinedButton(
              onPressed: () {
                Get.back();
                // or
                // Get.offNamed(Routes.login);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                side: const BorderSide(
                  color: AppColors.secondary,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Already have an account? Login",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                "Your information is securely encrypted.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------
  // INPUT DECORATION
  //----------------------------------------------------------

  //----------------------------------------------------------
// INPUT DECORATION
//----------------------------------------------------------

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: AppColors.grey,
        fontSize: 15,
      ),

      prefixIcon: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: .08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: AppColors.secondary,
          size: 22,
        ),
      ),

      filled: true,
      fillColor: const Color(0xffFAFBFC),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.border,
          width: 1.2,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.secondary,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
    );
  }
}

