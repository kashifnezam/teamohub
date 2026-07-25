import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamomarket/app/utils/custom_alert.dart';

class ImageHelper {
  ImageHelper._();

  static final ImagePicker _picker = ImagePicker();

  /// Pick a single image
  static Future<File?> imagePickFrom({ImageSource? source}) async {
    try {
      source ??= await _showSourcePicker();

      if (source == null) return null;

      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 90,
      );

      if (file == null) return null;

      return File(file.path);
    } catch (e) {
      CustomAlert.errorAlert(
        title: "Something went wrong",
        e.toString(),
      );
      return null;
    }
  }

  /// Pick one or multiple images
  static Future<List<File>?> imagesPickFrom() async {
    try {
      final source = await _showSourcePicker(
        title: "Upload Product Photos",
        subtitle: "Choose how you'd like to add your product photos.",
        gallerySubtitle: "Select Multiple",
      );

      if (source == null) return null;

      if (source == ImageSource.camera) {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 90,
        );

        if (image == null) return null;

        return [File(image.path)];
      }

      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 90,
      );

      return images.map((e) => File(e.path)).toList();
    } catch (e) {
      CustomAlert.errorAlert(
        title: "Something went wrong",
        e.toString(),
      );
      return null;
    }
  }

  static Future<ImageSource?> _showSourcePicker({
    String title = "Upload Product Image",
    String subtitle = "Choose where you'd like to pick your image.",
    String cameraTitle = "Camera",
    String cameraSubtitle = "Take Photo",
    String galleryTitle = "Gallery",
    String gallerySubtitle = "Choose Existing",
  }) {
    return showModalBottomSheet<ImageSource>(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ImageSourceSheet(
        title: title,
        subtitle: subtitle,
        cameraTitle: cameraTitle,
        cameraSubtitle: cameraSubtitle,
        galleryTitle: galleryTitle,
        gallerySubtitle: gallerySubtitle,
      ),
    );
  }
}

class _ImageSourceSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final String cameraTitle;
  final String cameraSubtitle;
  final String galleryTitle;
  final String gallerySubtitle;

  const _ImageSourceSheet({
    required this.title,
    required this.subtitle,
    required this.cameraTitle,
    required this.cameraSubtitle,
    required this.galleryTitle,
    required this.gallerySubtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 22),

              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child: _OptionCard(
                      icon: Icons.photo_camera_rounded,
                      title: cameraTitle,
                      subtitle: cameraSubtitle,
                      onTap: () => Navigator.pop(
                        context,
                        ImageSource.camera,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _OptionCard(
                      icon: Icons.photo_library_rounded,
                      title: galleryTitle,
                      subtitle: gallerySubtitle,
                      onTap: () => Navigator.pop(
                        context,
                        ImageSource.gallery,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: .15),
            ),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: theme.colorScheme.primary.withValues(alpha: .12),
                child: Icon(
                  icon,
                  size: 30,
                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}