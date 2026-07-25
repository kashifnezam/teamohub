import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/utils/app_colors.dart';
import '../../../app/widgets/custom_widget.dart';
import '../controllers/agent_controller.dart';

class ProfileImagePicker extends GetView<AgentController> {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
            () {
          Widget imageWidget;

          if (controller.profileImage.value != null) {
            imageWidget = ClipOval(
              child: Image.file(
                controller.profileImage.value!,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            );
          } else if (controller.profileImageUrl.value.isNotEmpty) {
            imageWidget = ClipOval(
              child: CustomWidget.getImage(
                controller.profileImageUrl.value,
                width: 110,
                height: 110,
              ),
            );
          } else {
            imageWidget = const Icon(
              Icons.person,
              size: 48,
              color: Colors.grey,
            );
          }

          return InkWell(
            borderRadius: BorderRadius.circular(60),
            onTap: controller.pickProfileImage,
            child: Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: imageWidget,
                ),
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}