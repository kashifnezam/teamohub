import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProductImage({
    required String productId,
    required String categoryName,
    required File imageFile,
  }) async {
    final ext = extension(imageFile.path).replaceFirst('.', '');

    final ref = FirebaseStorage.instance
        .ref()
        .child('products')
        .child(categoryName)
        .child(productId)
        .child('${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref.putFile(imageFile);

    return ref.getDownloadURL();
  }

  String extensionFromMime(String path) {
    return extension(path).replaceAll(".", "");
  }
}