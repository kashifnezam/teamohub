import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/views/marketplace_user/dashboard/dashboard_screen.dart';
import '../../utils/app_colors.dart';

class AuthenticationView extends StatelessWidget {
  AuthenticationView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final RxBool _obscurePassword = true.obs;

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

  //-------------------------------------------------------------
  /// MOBILE
  //-------------------------------------------------------------

  Widget _buildMobileLayout() {

    return Column(
      children: [
        const SizedBox(height: 25),
        Image.asset(
          "assets/logo/logo.png",
          height: 100,
        ),

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

                color: Colors.black.withOpacity(.06),

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

  //-------------------------------------------------------------
  /// DESKTOP
  //-------------------------------------------------------------

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

            color: Colors.black.withOpacity(.06),

            blurRadius: 35,

            offset: const Offset(0, 10),

          ),

        ],

      ),

      child: Padding(

        padding: const EdgeInsets.all(25),

        child: Row(

          children: [

            //-------------------------------------------------
            /// LEFT
            //-------------------------------------------------

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
                    "TeamoMarket",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(

                    "India's Smart Marketplace\nPowered by Trusted Deal Agents",

                    textAlign: TextAlign.center,

                    style: TextStyle(

                      fontSize: 18,

                      color: AppColors.grey,

                      height: 1.6,

                    ),

                  ),

                ],

              ),

            ),

            const SizedBox(width: 60),

            //-------------------------------------------------
            /// RIGHT
            //-------------------------------------------------

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

  //==============================================================
  // PART 2 STARTS HERE
  // Widget _buildForm()
  //==============================================================

  Widget _buildForm() {
    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          const Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),

          SizedBox(height: 10),

          const Text(
            "Login in to continue.",
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 15,
            ),
          ),

          SizedBox(height: 8),
          //----------------------------------------------------
          // Email
          //----------------------------------------------------

          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration(
              "Enter your email",
              Icons.email_outlined,
            ),
          ),

          const SizedBox(height: 25),

          //----------------------------------------------------
          // Password

          TextField(
            controller: _passController,
            obscureText: _obscurePassword.value,
            decoration: _inputDecoration(
              "Enter your password",
              Icons.lock_outline,
            ).copyWith(
              suffixIcon: IconButton(
                splashRadius: 20,
                onPressed: () {
                  _obscurePassword.toggle();
                },
                icon: Icon(
                  _obscurePassword.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.grey,
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),

          //----------------------------------------------------
          // Forgot Password
          //----------------------------------------------------

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {

                if (_emailController.text.isEmpty) {
                  Get.snackbar(
                    "Email Required",
                    "Please enter your email first.",
                  );
                  return;
                }

              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),

          //----------------------------------------------------
          // Gradient Login Button
          //----------------------------------------------------

          SizedBox(
            height: 56,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.primary
              ),
              child: ElevatedButton(
                onPressed: () {
                    Get.to(()=> DashboardScreen());
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          //----------------------------------------------------
          // Divider
          //----------------------------------------------------

          Row(
            children: [

              const Expanded(
                child: Divider(
                  thickness: 1,
                  color: AppColors.border,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "OR",
                  style: TextStyle(
                    color: AppColors.grey.withOpacity(.7),
                  ),
                ),
              ),

              const Expanded(
                child: Divider(
                  thickness: 1,
                  color: AppColors.border,
                ),
              ),

            ],
          ),

          const SizedBox(height: 30),

          //----------------------------------------------------
          // Create Account
          //----------------------------------------------------

          OutlinedButton(
            onPressed: () {

              // Get.to(() => CreateAccountView());

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
              "Create an Account",
              style: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              "Secure login protected with encryption",
              style: TextStyle(
                color: AppColors.grey.withOpacity(.8),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
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
          color: AppColors.secondary.withOpacity(.08),
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