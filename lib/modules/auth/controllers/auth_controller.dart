import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/constants/app_constants.dart';
import 'package:teamomarket/app/utils/offline_data.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/utils/custom_alert.dart';
import '../../splash/views/splashscreen.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/device_service_modal.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final DeviceService _deviceService = DeviceService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxBool isUsernameAvailable = false.obs;
  final RxString usernameError = ''.obs;
  final Rxn<User> firebaseUser = Rxn<User>();
  RxBool isLoggingOut = false.obs;

  @override
  void onInit() {
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
    super.onInit();
  }

  bool get isLoggedIn => firebaseUser.value != null;

  Future<void> logout() async {
    if (isLoggingOut.value) return;
    CustomAlert.loadAlert("Logging out...");
    isLoggingOut.value = true;
    try {
      await AuthService.logout();
      CustomAlert.dismissAlert();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      CustomAlert.dismissAlert();
      CustomAlert.errorAlert(
        "Couldn't logout properly. Please try again.",
        title: "Logout Failed",
      );
    } finally {
      isLoggingOut.value = false;
    }
  }

  Future<UserModel> getCurrentUser() async {
    return _authService.getUserData(userInfo?['id']);
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading(true);
      errorMessage('');

      final user = await _authService.login(email, password);
      await _deviceService.updateDeviceInfo(user.id);

      Get.offAll(() => const SplashScreen());

    } on FirebaseAuthException catch (e) {
      AppConstants.log.i(e.code);

      final message = _getFriendlyAuthMessage(e);
      errorMessage(message);
      CustomAlert.errorAlert(message);

    } catch (e) {
      CustomAlert.errorAlert(e.toString());
    } finally {
      isLoading(false);
    }
  }

  String _getFriendlyAuthMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'invalid-email':
        return "Invalid email or password.";

      case 'user-not-found':
        return "No account found with this email.";

      case 'user-disabled':
        return "This account has been disabled.";

      case 'too-many-requests':
        return "Too many attempts. Please try again later.";

      case 'network-request-failed':
        return "Check your internet connection.";

      default:
        return "Login failed. Please try again.";
    }
  }

  Future<void> signUp({
    required String fullName,
    required String mobile,
    required String email,
    required String password,
    required String accountType,
  }) async {
    try {
      isLoading(true);
      errorMessage('');

      await _authService.signUp(
        fullName: fullName,
        mobile: mobile,
        email: email,
        password: password,
      );

      CustomAlert.successAlert(
        'Account created. Please verify your email.',
      );
      Get.back(); // Return to login screen
    } catch (e) {
      errorMessage(e.toString());
      CustomAlert.errorAlert(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      isLoading(true);
      await _authService.sendPasswordResetEmail(email);
      CustomAlert.successAlert('Password reset link sent to $email');
    } catch (e) {
      errorMessage(e.toString());
      CustomAlert.errorAlert(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
