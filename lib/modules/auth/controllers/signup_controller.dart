import 'package:get/get.dart';
import '../../../app/utils/custom_alert.dart';
import '../services/auth_service.dart';

class SignupController extends GetxController {
  final AuthService _authService = AuthService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> signUp({
    required String fullName,
    required String mobile,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      isLoading(true);
      errorMessage('');

      //--------------------------------------------------
      // Validation
      //--------------------------------------------------

      if (fullName.trim().isEmpty) {
        throw "Please enter your full name.";
      }

      if (mobile.trim().isEmpty) {
        throw "Please enter your mobile number.";
      }

      if (!GetUtils.isPhoneNumber(mobile.trim()) ||
          mobile.trim().length != 10) {
        throw "Please enter a valid 10-digit mobile number.";
      }

      if (email.trim().isEmpty) {
        throw "Please enter your email address.";
      }

      if (!GetUtils.isEmail(email.trim())) {
        throw "Please enter a valid email address.";
      }

      if (password.isEmpty) {
        throw "Please enter a password.";
      }

      if (password.length < 6) {
        throw "Password must be at least 6 characters.";
      }

      if (password != confirmPassword) {
        throw "Passwords do not match.";
      }

      //--------------------------------------------------
      // Create Account
      //--------------------------------------------------

      await _authService.signUp(
        fullName: fullName.trim(),
        mobile: mobile.trim(),
        email: email.trim().toLowerCase(),
        password: password,
      );
      Get.back();

      CustomAlert.successAlert(
        "Account created successfully.\nPlease verify your email before logging in.",
        title: "Success",
      );

      // OR
      // Get.offNamed(Routes.login);
    } catch (e) {
      errorMessage(e.toString());

      CustomAlert.errorAlert(
        e.toString(),
        title: "Sign Up Failed",
      );
    } finally {
      isLoading(false);
    }
  }
}