import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/widgets/custom_widget.dart';
import '../controllers/agent_controller.dart';

class ProfileImagePicker extends GetView<AgentController> {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
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
                width: 126,
                height: 126,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.15),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
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
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.15),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}