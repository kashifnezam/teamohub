import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgentPromotionRepository {
  AgentPromotionRepository._();

  static final AgentPromotionRepository instance =
  AgentPromotionRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _promotions =>
      _firestore.collection('promotion_requests');

  Stream<QuerySnapshot<Map<String, dynamic>>> pendingPromotions() {
    return _promotions
        .where('agentId', isEqualTo: _uid)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> activePromotions() {
    return _promotions
        .where('agentId', isEqualTo: _uid)
        .where(
      'status',
      whereIn: const [
        'accepted',
        'active',
      ],
    )
        .orderBy('updatedAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> completedPromotions() {
    return _promotions
        .where('agentId', isEqualTo: _uid)
        .where('status', isEqualTo: 'completed')
        .orderBy('updatedAt', descending: true)
        .snapshots();
  }

  Future<void> acceptPromotion(String id) async {
    await _promotions.doc(id).update({
      'status': 'accepted',
      'acceptedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> rejectPromotion(
      String id, {
        String? reason,
      }) async {
    await _promotions.doc(id).update({
      'status': 'rejected',
      'rejectedReason': reason ?? '',
      'rejectedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> markCompleted(String id) async {
    await _promotions.doc(id).update({
      'status': 'completed',
      'completedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}