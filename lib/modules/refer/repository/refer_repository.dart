import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ReferRepository {
  ReferRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _functions = functions ??
            FirebaseFunctions.instanceFor(
              region: 'asia-south1',
            );
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  static const int rewardPoints = 10;
  static const int pageSize = 20;

  String get _uid => _auth.currentUser!.uid;

  DocumentReference<Map<String, dynamic>> get _userRef =>
      _firestore.collection('users').doc(_uid);

  Future<String> generateReferralCode() async {
    final snapshot = await _userRef.get();

    final existing = snapshot.data()?['referralCode'];

    if (existing is String && existing.isNotEmpty) {
      return existing;
    }

    final result = await _functions
        .httpsCallable('generateReferralCode')
        .call();

    return result.data['referralCode'] as String;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getReferralDetails() {
    return _userRef.snapshots();
  }

  Future<void> copyReferralCode(String code) async {
    await Clipboard.setData(
      ClipboardData(text: code),
    );
  }

  Future<void> shareReferral(String code) async {
    const downloadUrl = 'https://teamomart.web.app/';

    final message =
    '''
    Join me on TeamoMart and earn $rewardPoints Reward Points.
    Use my referral code: $code
    Download now: $downloadUrl 
    ''';

    await SharePlus.instance.share(
      ShareParams(
        text: message,
      ),
    );
  }

  Future<bool> validateReferral(String code) async {
    final result = await _functions
        .httpsCallable('validateReferral')
        .call({
      'referralCode': code.trim().toUpperCase(),
    });

    return result.data['valid'] == true;
  }

  Future<void> applyReferral(String code) async {
    await _functions
        .httpsCallable('applyReferral')
        .call({
      'referralCode': code.trim().toUpperCase(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamReferralHistory({DocumentSnapshot? lastDocument}) {
    Query<Map<String, dynamic>> query = _firestore
        .collection('referrals')
        .where('referrerId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .limit(pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.snapshots();
  }

  Stream<int> streamRewardBalance() {
    return _userRef.snapshots().map(
          (doc) => (doc.data()?['rewardPoints'] ?? 0) as int,
    );
  }
}