import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/utils/app_colors.dart';
import '../../../app/widgets/custom_widget.dart';
import '../controllers/banner_controller.dart';

class BannerFormPage extends GetView<BannerController> {
  const BannerFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title:  Text(
          controller.isEdit ? "Edit Banner" : "Add Banner",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Banner Image",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 10),

              Obx(() {
                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: controller.pickImage,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: controller.image.value != null
                        ? Stack(
                      fit: StackFit.expand,
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.file(
                            controller.image.value!,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Positioned(
                          right: 10,
                          top: 10,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                              onPressed: controller.removeImage,
                            ),
                          ),
                        ),
                      ],
                    )
                        : controller.isEdit
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: CustomWidget.getImage(
                        controller.banner!.imageUrl,
                        shape: BoxShape.rectangle,
                      ),
                    )
                        : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 48,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 10),

                        Text(
                          "Tap to select banner",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "JPG, PNG",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 24),

              TextFormField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: controller.subtitleController,
                decoration: const InputDecoration(
                  labelText: "Subtitle",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              Obx(
                    () => DropdownButtonFormField<String>(
                  initialValue: controller.actionType.value,
                  decoration: const InputDecoration(
                    labelText: "Action Type",
                    border: OutlineInputBorder(),
                  ),
                  items: const [

                    DropdownMenuItem(
                      value: "none",
                      child: Text("None"),
                    ),

                    DropdownMenuItem(
                      value: "category",
                      child: Text("Category"),
                    ),

                    DropdownMenuItem(
                      value: "product",
                      child: Text("Product"),
                    ),

                    DropdownMenuItem(
                      value: "url",
                      child: Text("External URL"),
                    ),
                  ],
                  onChanged: (value) {
                    controller.actionType.value = value!;
                  },
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: controller.actionValueController,
                decoration: const InputDecoration(
                  labelText: "Action Value",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: controller.orderController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Display Order",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 8),

              Obx(
                    () => SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeThumbColor: AppColors.primary,
                  title: const Text("Active Banner"),
                  value: controller.isActive.value,
                  onChanged: (value) {
                    controller.isActive.value = value;
                  },
                ),
              ),

              const SizedBox(height: 28),

              Obx(
                    () => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: controller.isSaving.value
                        ? null
                        : controller.saveBanner,
                    child: controller.isSaving.value
                        ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      controller.isEdit
                          ? "Update Banner"
                          : "Save Banner",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}