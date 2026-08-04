import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../../../app/constants/firebase_constants.dart';
import '../../../app/utils/offline_data.dart';
import '../../auth/models/user_model.dart';
import '../services/profile_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';


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



  Future<void> contactSupport() async {
    final package = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();

    String device = "Unknown";

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      device = "${info.brand} ${info.model} (Android ${info.version.release})";
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      device = "${info.name} ${info.model} (iOS ${info.systemVersion})";
    }

    final body = '''
Hi TeamoMart Team,

Feedback / Issue:


----------------------------------------
User Details
----------------------------------------

Name: ${userInfo?['name'] ?? ''}

Email: ${userInfo?['email'] ?? ''}

App Version: ${package.version} (${package.buildNumber})

Device: $device

Regards,
${userInfo?['name'] ?? ''}
''';

    final uri = Uri.parse(
      'mailto:contact.teamomart@gmail.com'
          '?subject=${Uri.encodeComponent("Feedback | TeamoMart")}'
          '&body=${Uri.encodeComponent(body)}',
    );

    await launchUrl(uri);
  }
}