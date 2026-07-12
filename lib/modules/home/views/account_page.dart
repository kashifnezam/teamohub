import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/utils/app_colors.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/services/auth_service.dart';

class AccountPage extends GetView<ProfileController> {
  AccountPage({super.key});
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text(
          "My Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          /// Profile Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [

                const CircleAvatar(
                  radius: 34,
                  backgroundColor: Color(0xffE9EEFF),
                  child: Icon(
                    Icons.person,
                    size: 36,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Obx(
                        () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userName.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.email.value,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                IconButton(
                  onPressed: controller.editProfile,
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Account",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 12),

          _MenuTile(
            icon: Icons.campaign_outlined,
            title: "My Ads",
            onTap: controller.myAds,
          ),

          _MenuTile(
            icon: Icons.favorite_border,
            title: "Favorites",
            onTap: controller.favourites,
          ),

          _MenuTile(
            icon: Icons.shopping_bag_outlined,
            title: "My Purchases",
            onTap: controller.orders,
          ),

          _MenuTile(
            icon: Icons.sell_outlined,
            title: "Selling History",
            onTap: controller.sellingHistory,
          ),

          const SizedBox(height: 20),

          const Text(
            "General",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 12),

          _MenuTile(
            icon: Icons.notifications_none,
            title: "Notifications",
            onTap: controller.notifications,
          ),

          _MenuTile(
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: controller.helpSupport,
          ),

          _MenuTile(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            onTap: controller.privacyPolicy,
          ),

          _MenuTile(
            icon: Icons.logout,
            title: "Logout",
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: authController.logout,
          ),

          const SizedBox(height: 30),

          Center(
            child: Text(
              "Version 1.0.0",
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor ?? AppColors.primary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class ProfileController extends GetxController {
  final userName = "Kashif".obs;
  final email = "kashif@example.com".obs;
  final profileImage = "".obs;

  void editProfile() {
    // Get.toNamed(Routes.editProfile);
  }

  void myAds() {}

  void favourites() {}

  void orders() {}

  void sellingHistory() {}

  void notifications() {}

  void helpSupport() {}

  void privacyPolicy() {}

  Future<void> logout() async {
  }
}