import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/widgets/custom_widget.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          // appBar: AppBar(
          //   elevation: 0,
          //   centerTitle: true,
          //   title: const Text("Profile"),
          // ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CustomWidget.buildCircularProgressIndicator(),
              );
            }

            final user = controller.user.value;

            if (user == null) {
              return const Center(
                child: Text("User not found"),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[

                //====================================================
                // Profile Header
                //====================================================

                Container(
                width: double.infinity,
                // padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .06),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                              Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.primary.withValues(alpha: .75),
                                    ],
                                  ),
                                ),
                              ),

                              Transform.translate(
                                offset: const Offset(0, -45),
                                child: Column(
                                  children: [

                                    //------------------------------------------------
                                    // Avatar
                                    //------------------------------------------------

                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [

                                        AnimatedSwitcher(
                                          duration: const Duration(milliseconds: 350),
                                          child: Container(
                                            key: ValueKey(user.photoUrl),
                                            width: 110,
                                            height: 110,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 4,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withValues(alpha: .15),
                                                  blurRadius: 16,
                                                  offset: const Offset(0, 6),
                                                ),

                                              ],
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: user.photoUrl != null &&
                                                user.photoUrl!.isNotEmpty
                                                ? Obx(() {

                                              // Local image has priority
                                              if (controller.selectedProfileImage.value != null) {
                                                return ClipOval(
                                                  child: Image.file(
                                                    controller.selectedProfileImage.value!,
                                                    width: 110,
                                                    height: 110,
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              }

                                              // Network image
                                              if (user.photoUrl != null &&
                                                  user.photoUrl!.isNotEmpty) {
                                                return CustomWidget.getImage(user.photoUrl!, shape: BoxShape.circle);
                                              }

                                              // Placeholder
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius: BorderRadius.circular(50)),
                                                child: Icon(
                                                  Icons.person,
                                                  size: 55,
                                                  color: Colors.grey.shade500,
                                                ),
                                              );
                                            })
                                                : Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                borderRadius: BorderRadius.circular(50)
                                              ),
                                              child: Icon(
                                                Icons.person,
                                                size: 55,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //--------------------------------------------
                                        // Camera Button
                                        //--------------------------------------------

                                        Positioned(
                                          bottom: 2,
                                          right: -2,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(30),
                                              onTap: controller.isUploadingImage.value
                                                  ? null
                                                  : controller.pickProfileImage,
                                              child: Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.primary,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2,
                                                  ),
                                                ),
                                                child:/* controller.isUploadingImage.value
                                                    ? const SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.white,
                                                  ),
                                                )
                                                    : */const Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Obx(() {
                                          if (!controller.isUploadingImage.value) {
                                            return const SizedBox();
                                          }

                                          return Positioned.fill(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black45,
                                              ),
                                              child: const Center(
                                                child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),

                                    const SizedBox(height: 16),

                                    //------------------------------------------------
                                    // Name
                                    //------------------------------------------------

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Flexible(
                                          child: Text(
                                            user.name,
                                            style: const TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                        if (user.isVerified) ...[
                                          const SizedBox(width: 6),
                                          const Icon(
                                            Icons.verified_rounded,
                                            color: Colors.blue,
                                            size: 22,
                                          ),
                                        ]
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      user.email,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 15,
                                      ),
                                    ),

                                    if (user.phone.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      Text(
                                        user.phone,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],

                                    const SizedBox(height: 18),

                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withValues(alpha: .08),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [

                                          Icon(
                                            Icons.workspace_premium_outlined,
                                            size: 18,
                                            color:
                                            Theme.of(context).colorScheme.primary,
                                          ),

                                          const SizedBox(width: 8),

                                          Text(
                                            user.role.toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //====================================================
              // Location Card
              //====================================================

            /*  Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      const Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(width: 8),
                          Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      _locationTile(
                        "Country",
                        user.country,
                      ),

                      _locationTile(
                        "State",
                        user.state,
                      ),

                      _locationTile(
                        "City",
                        user.city,
                      ),

                      _locationTile(
                        "Area",
                        user.area,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),*/
              //====================================================
              // Quick Actions
              //====================================================

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Quick Actions",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),

                    const SizedBox(height: 16),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.35,
                      children: [

                        _actionCard(
                          context: context,
                          icon: Icons.inventory_2_outlined,
                          title: "My Ads",
                          subtitle: "Manage your listings",
                          onTap: controller.openMyAds,
                        ),

                        _actionCard(
                          context: context,
                          icon: Icons.favorite_border_rounded,
                          title: "Favourites",
                          subtitle: "Saved products",
                          onTap: controller.openFavourites,
                        ),

                        _actionCard(
                          context: context,
                          icon: Icons.chat_bubble_outline_rounded,
                          title: "Chats",
                          subtitle: "Buyer & seller chats",
                          onTap: controller.openChats,
                        ),

                        _actionCard(
                          context: context,
                          icon: Icons.notifications_none_rounded,
                          title: "Notifications",
                          subtitle: "Latest updates",
                          onTap: controller.openNotifications,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    //====================================================
                    // Account
                    //====================================================

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Account",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [

                          _accountTile(
                            icon: Icons.edit_outlined,
                            title: "Edit Profile",
                            onTap: controller.editProfile,
                          ),

                          const Divider(height: 1),

                          _accountTile(
                            icon: Icons.location_on_outlined,
                            title: "Change Location",
                            onTap: controller.changeLocation,
                          ),

                          const Divider(height: 1),

                          _accountTile(
                            icon: Icons.privacy_tip_outlined,
                            title: "Privacy Policy",
                            onTap: controller.openPrivacyPolicy,
                          ),

                          const Divider(height: 1),

                          _accountTile(
                            icon: Icons.description_outlined,
                            title: "Terms & Conditions",
                            onTap: controller.openTerms,
                          ),

                          const Divider(height: 1),

                          _accountTile(
                            icon: Icons.help_outline_rounded,
                            title: "Help & Support",
                            onTap: controller.openHelpSupport,
                          ),

                          const Divider(height: 1),

                          _accountTile(
                            icon: Icons.logout_rounded,
                            title: "Logout",
                            textColor: Colors.red,
                            iconColor: Colors.red,
                            onTap: () async {
                              final bool? confirm =
                              await CustomWidget.confirmDialogue(
                                title: "Logout",
                                content:"Are you sure you want to logout?",
                                confirm: "Logout",
                              );

                              if (confirm == true) {
                                AuthController().logout();
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    // const SizedBox(height: 15),
                    // Card(
                    //   elevation: 0,
                    //   color: Colors.red.shade50,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(16),
                    //   ),
                    //   child: ListTile(
                    //     leading: const Icon(
                    //       Icons.delete_outline_rounded,
                    //       color: Colors.red,
                    //     ),
                    //     title: const Text(
                    //       "Delete Account",
                    //       style: TextStyle(
                    //         color: Colors.red,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //     subtitle: const Text(
                    //       "This feature will be available soon.",
                    //     ),
                    //     onTap: controller.deleteAccount,
                    //   ),
                    // ),

                    const SizedBox(height: 12),

                    Text(
                      "TeamoMart v1.0.0",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 44),
                  ],
                ),
              )
                ],
              ),
            );
          }),
      ),
    );
  }

  // Widget _locationTile(String title, String? value) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 14),
  //     child: Row(
  //       children: [
  //         SizedBox(
  //           width: 90,
  //           child: Text(
  //             title,
  //             style: const TextStyle(
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: Text(
  //             (value != null && value.trim().isNotEmpty)
  //                 ? value
  //                 : "-",
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _actionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _accountTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}