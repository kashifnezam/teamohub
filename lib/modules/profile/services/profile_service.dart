import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ProfileService {
  ProfileService._();

  static final ProfileService instance = ProfileService._();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfileImage({
    required String uid,
    required File image,
  }) async {
    final Reference ref =
    _storage.ref().child("users/$uid/profile.jpg");

    final UploadTask task = ref.putFile(
      image,
      SettableMetadata(
        contentType: "image/jpeg",
      ),
    );

    await task;

    return await ref.getDownloadURL();
  }
}