// services/auth_service.dart
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:teamomarket/app/constants/app_constants.dart';

import '../../../app/services/device_info.dart';
import '../../../app/utils/custom_alert.dart';
import '../../../app/utils/offline_data.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference members =
      FirebaseFirestore.instance.collection('members');

  /// Check if username exists in any member document
  Future<bool> isUsernameAvailable(String username) async {
    try {
      // Query members where 'username' equals the input (case-sensitive)
      final query = await members
          .where('username', isEqualTo: username.toLowerCase())
          .limit(1)
          .get();
      return query.docs.isEmpty; // Available if no documents found
    } catch (e) {
      CustomAlert.errorAlert('Error checking username: $e');
      return false; // Assume unavailable if error occurs
    }
  }


  /// Register with username (instead of email)
  Future<UserCredential> registerWithUsername({
    required String username,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    try {
      // Create email-like string using username
      final authEmail = '$username@${AppConstants.authDomain}';
      // Define this constant in your AppConstants

      // Create auth user
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: authEmail,
        password: password,
      );
      await _firestore.collection('members').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'usr': username,
        "cBy": DeviceInfo.userUID,
        'createdAt': FieldValue.serverTimestamp(),
      });
      // Store user data
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userData);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Login with username
  Future<UserCredential> loginWithUsername({
    required String username,
    required String password,
  }) async {
    try {
      final authEmail = '$username@${AppConstants.authDomain}';
      return await _auth.signInWithEmailAndPassword(
        email: authEmail,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

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
        uid: user.uid,
        name: fullName.trim(),
        email: email.trim().toLowerCase(),
        phone: mobile.trim(),
        photo: null,

        // Every user can buy & sell
        role: "user",

        // Can be updated later from profile
        country: "",
        state: "",
        city: "",
        area: null,
        address: null,
        pincode: null,

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
    return await getUserData(userCredential.user!.uid);
  }

  Future<UserModel> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();

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
              .collection("user")
              .doc(uid)
              .update({"fcmTokenWeb": FieldValue.delete()});
        }
        else{
          await FirebaseFirestore.instance
              .collection("user")
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
