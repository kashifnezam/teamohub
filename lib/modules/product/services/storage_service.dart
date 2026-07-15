import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProductImage({
    required String productId,
    required String imagePath,
    required String catogaryName,
  }) async {
    final file = File(imagePath);

    final extension = extensionFromMime(file.path);

    final ref = _storage
        .ref()
        .child("products")
        .child(catogaryName)
        .child(productId)
        .child("${DateTime.now().millisecondsSinceEpoch}.$extension");

    final task = await ref.putFile(file);

    return await task.ref.getDownloadURL();
  }

  String extensionFromMime(String path) {
    return extension(path).replaceAll(".", "");
  }
}