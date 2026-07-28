import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/constants/firebase_constants.dart';
import '../models/agent_model.dart';
import '../models/agent_request_model.dart';

class AgentDashboardRepository {
  AgentDashboardRepository._();

  static final AgentDashboardRepository instance =
  AgentDashboardRepository._();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _agents =>
      _firestore.collection(FirebaseConstants.agents);

  CollectionReference<Map<String, dynamic>> get _agentRequests =>
      _firestore.collection('agent_requests');

  CollectionReference<Map<String, dynamic>> get _promotionRequests =>
      _firestore.collection('promotion_requests');

  CollectionReference<Map<String, dynamic>> get _agentListings =>
      _firestore.collection('agent_listings');

  CollectionReference<Map<String, dynamic>> get _activities =>
      _firestore.collection('agent_activities');

  Future<AgentModel?> getAgent() async {
    final doc = await _agents.doc(_uid).get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    return AgentModel.fromMap(doc.data()!, doc.id);
  }

  Stream<int> pendingRequestCount() {
    return _agentRequests
        .where('agentId', isEqualTo: _uid)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  Stream<int> activePromotionCount() {
    return _promotionRequests
        .where('agentId', isEqualTo: _uid)
        .where(
      'status',
      whereIn: const [
        'accepted',
        'active',
      ],
    )
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  Stream<int> clientRequestCount() {
    return _agentRequests
        .where('agentId', isEqualTo: _uid)
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  Stream<double> commissionEarned() {
    return _agentListings
        .where('agentId', isEqualTo: _uid)
        .where('dealStatus', isEqualTo: 'completed')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.fold<double>(
        0,
            (total, doc) {
          final value = doc.data()['commissionEarned'];

          if (value == null) return total;

          return total + (value as num).toDouble();
        },
      ),
    );
  }

  /// -------------------------------
  /// Recent Client Requests
  /// -------------------------------

  Stream<List<AgentRequestModel>> recentClientRequests() {
    return _agentRequests
        .where('agentId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .limit(5)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => AgentRequestModel.fromFirestore(doc),
      )
          .toList(),
    );
  }

  /// -------------------------------
  /// Recent Promotion Requests
  /// -------------------------------

  Stream<QuerySnapshot<Map<String, dynamic>>> recentPromotionRequests() {
    return _promotionRequests
        .where('agentId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .limit(5)
        .snapshots();
  }

  /// -------------------------------
  /// Recent Activities
  /// -------------------------------

  Stream<QuerySnapshot<Map<String, dynamic>>> recentActivities() {
    return _activities
        .where('agentId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots();
  }
}