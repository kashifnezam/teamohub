import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CustomWidget {
  static Widget buildCircularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Future<bool> confirmDialogue(
      {required String title,
      required String content,
      String cancel = "Cancel",
      String confirm = "Confirm",
      bool isCancel = true}) async {
    return await Get.dialog(
          AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              if (isCancel)
                TextButton(
                  child: Text(cancel),
                  onPressed: () {
                    Get.back(result: false); // Close the dialog, return false
                  },
                ),
              TextButton(
                child: Text(confirm),
                onPressed: () {
                  Get.back(result: true); // Close the dialog, return true
                },
              ),
            ],
          ),
        ) ??
        false; // Return false if the dialog is dismissed without a choice.
  }

  static Future<File?> imagePickFrom({String source = "gallery"}) async {
    try {
      final picker = ImagePicker();

      final XFile? file = await picker.pickImage(
        source: source == "camera"
            ? ImageSource.camera
            : ImageSource.gallery,
      );

      if (file == null) return null;

      return File(file.path);
    } catch (e) {
      confirmDialogue(
        title: "Something went wrong",
        content: e.toString(),
      );
      return null;
    }
  }

  static Widget getImage(
      String imageUrl, {
        double width = 60,
        double height = 60,
        BoxShape shape = BoxShape.circle,
      }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (_, __) => SizedBox(
        width: width,
        height: height,
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (_, __, ___) => SizedBox(
        width: width,
        height: height,
        child: const Icon(Icons.error),
      ),
    );
  }
  static Future<File> compressImage(String path) async {
    final dir = await getTemporaryDirectory();

    final target =
        "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

    final XFile? result =
    await FlutterImageCompress.compressAndGetFile(
      path,
      target,
      quality: 70,
      minWidth: 1080,
      minHeight: 1080,
    );

    return File(result?.path ?? path);
  }
}
