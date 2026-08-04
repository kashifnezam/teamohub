import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/refer_repository.dart';

class ReferController extends GetxController {
  ReferController({ReferRepository? repository})
      : _repository = repository ?? ReferRepository();

  final ReferRepository _repository;

  final RxBool isLoading = true.obs;

  final RxString referralCode = ''.obs;

  final RxInt rewardBalance = 0.obs;
  final RxInt totalInvitedFriends = 0.obs;
  final RxInt successfulReferrals = 0.obs;
  final RxInt totalRewardEarned = 0.obs;

  final RxList<QueryDocumentSnapshot<Map<String, dynamic>>> referralHistory = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  final TextEditingController referralInputController = TextEditingController();

  final RxBool hasMore = true.obs;

  DocumentSnapshot? _lastDocument;

  StreamSubscription? _userSubscription;
  StreamSubscription? _rewardSubscription;
  StreamSubscription? _historySubscription;

  @override
  void onInit() {
    super.onInit();

    _initialize();
  }

  Future<void> _initialize() async {
    referralCode.value = await _repository.generateReferralCode();

    _listenUser();

    _listenReward();

    _listenHistory();

    isLoading.value = false;
  }

  void _listenUser() {
    _userSubscription?.cancel();

    _userSubscription =
        _repository.getReferralDetails().listen((DocumentSnapshot snapshot) {
          final data = snapshot.data() as Map<String, dynamic>?;

          if (data == null) return;

          referralCode.value = data['referralCode'] ?? '';

          successfulReferrals.value =
          (data['successfulReferrals'] ?? 0) as int;

          totalRewardEarned.value =
          (data['totalRewardEarned'] ?? 0) as int;
        });
  }

  void _listenReward() {
    _rewardSubscription?.cancel();

    _rewardSubscription =
        _repository.streamRewardBalance().listen((points) {
          rewardBalance.value = points;
        });
  }

  void _listenHistory() {
    _historySubscription?.cancel();

    _historySubscription = _repository
        .streamReferralHistory()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      referralHistory.assignAll(snapshot.docs);

      totalInvitedFriends.value = snapshot.docs.length;

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
      }

      hasMore.value = snapshot.docs.length >= ReferRepository.pageSize;
    });
  }

  Future<void> loadMoreHistory() async {
    if (!hasMore.value || _lastDocument == null) {
      return;
    }

    final snapshot = await _repository
        .streamReferralHistory(lastDocument: _lastDocument)
        .first;

    if (snapshot.docs.isEmpty) {
      hasMore.value = false;
      return;
    }

    referralHistory.addAll(snapshot.docs);

    _lastDocument = snapshot.docs.last;

    if (snapshot.docs.length < ReferRepository.pageSize) {
      hasMore.value = false;
    }
  }

  Future<void> copyReferralCode() async {
    if (referralCode.isEmpty) return;

    await _repository.copyReferralCode(referralCode.value);
  }

  Future<void> shareReferral() async {
    if (referralCode.isEmpty) return;

    await _repository.shareReferral(referralCode.value);
  }

  Future<bool> validateReferral(String code) {
    return _repository.validateReferral(code);
  }

  Future<void> applyReferral(String code) {
    return _repository.applyReferral(code);
  }

  @override
  void onClose() {
    _userSubscription?.cancel();
    _rewardSubscription?.cancel();
    _historySubscription?.cancel();
    referralInputController.dispose();
    super.onClose();
  }
}