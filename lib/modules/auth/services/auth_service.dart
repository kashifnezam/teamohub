// services/auth_service.dart
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:teamomarket/app/constants/app_constants.dart';
import 'package:teamomarket/app/constants/firebase_constants.dart';

import '../../../app/services/device_info.dart';
import '../../../app/utils/custom_alert.dart';
import '../../../app/utils/offline_data.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference members =
      FirebaseFirestore.instance.collection('members');

  Future<void> signUp({
    required String fullName,
    required String mobile,
    required String email,
    required String password,
  }) async {
    try {
      final auth = FirebaseAuth.instance;
      final firestore = FirebaseFirestore.instance;

      // 1️⃣ Create user
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user!;
      final now = DateTime.now();

      // 2️⃣ Send verification email
      unawaited(user.sendEmailVerification());

      // 3️⃣ Create UserModel
      final userModel = UserModel(
        id: user.uid,
        name: fullName.trim(),
        email: email.trim().toLowerCase(),
        phone: mobile.trim(),
        photoUrl: null,

        // Every user can buy & sell
        role: "user",

        isVerified: false,
        isBlocked: false,

        createdAt: now,
        updatedAt: now,
      );

      // 4️⃣ Save to Firestore
      await firestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());

      // 5️⃣ Sign out until email is verified
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      debugPrint("Signup Error: $e");
      throw "Account creation failed. Please try again.";
    }
  }

  Future<UserModel> login(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // await userCredential.user!.reload();
    //
    // final firebaseUser = FirebaseAuth.instance.currentUser!;
    //
    // if (!firebaseUser.emailVerified) {
    //   await FirebaseAuth.instance.signOut();
    //
    //   throw "Please verify your email before logging in.";
    // }

    return await getUserData(userCredential.user!.uid);
  }


  Future<UserModel> getUserData(String uid) async {
    final doc = await _firestore.collection(FirebaseConstants.users).doc(uid).get();

    if (!doc.exists || doc.data() == null) {
      throw Exception('User not found');
    }

    return UserModel.fromMap({
      'id': doc.id,
      ...doc.data()!,
    });
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password too weak';
      case 'user-not-found':
      case 'wrong-password':
        return 'Invalid credentials';
      case 'user-disabled':
        return 'Account disabled';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }

  /// Password Reset Method
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  static Future<void> logout() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    // Remove FCM token from backend
    if (uid != null) {
      try {
        if(kIsWeb){
          await FirebaseFirestore.instance
              .collection(FirebaseConstants.users)
              .doc(uid)
              .update({"fcmTokenWeb": FieldValue.delete()});
        }
        else{
          await FirebaseFirestore.instance
              .collection(FirebaseConstants.users)
              .doc(uid)
              .update({"fcmToken": FieldValue.delete()});
        }
      } catch (_) {}
    }

    // Delete FCM token locally
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (_) {}

    // Stop background location (mobile only)
    if (!kIsWeb) {
      try {
        const platform = MethodChannel('com.kashif.location_service');
        await platform.invokeMethod('stopLocationUpdates');
      } catch (_) {}
    }

    // Clear local storage
    try {
      await OfflineData.clearAll();
    } catch (_) {}

    // Firebase logout
    await FirebaseAuth.instance.signOut();
  }
}
