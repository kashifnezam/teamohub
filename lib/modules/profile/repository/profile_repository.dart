import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../app/constants/firebase_constants.dart';
import '../../auth/models/user_model.dart';
import '../services/profile_service.dart';

class ProfileRepository {
  ProfileRepository._();

  static final ProfileRepository instance = ProfileRepository._();

  final ProfileService _service = ProfileService.instance;

  Stream<UserModel> streamUser(String uid) {
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.users)
        .doc(uid)
        .snapshots()
        .map((doc) => UserModel.fromFirestore(doc));
  }

  Future<String> uploadProfileImage({
    required String uid,
    required File image,
  }) {
    return _service.uploadProfileImage(
      uid: uid,
      image: image,
    );
  }

  Future<void> updatePhoto({
    required String uid,
    required String photoUrl,
  }) {
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.users)
        .doc(uid)
        .update({
      "photoUrl": photoUrl,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateProfile({required UserModel user}) async {
    final data = user.copyWith(
      updatedAt: DateTime.now(),
    ).toFirestore();

    await FirebaseFirestore.instance
        .collection(FirebaseConstants.users)
        .doc(user.id)
        .update(data);
  }

  Future<bool> isVerifiedAgent(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection(FirebaseConstants.agents)
        .doc(uid)
        .get();

    if (!doc.exists) {
      return false;
    }

    final data = doc.data();

    if (data == null) {
      return false;
    }

    return data["agentStatus"] == "verified";
  }
}