import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgentRequestRepository {
  AgentRequestRepository._();

  static final AgentRequestRepository instance =
  AgentRequestRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _requests =>
      _firestore.collection('agent_requests');

  Stream<QuerySnapshot<Map<String, dynamic>>> pendingRequests() {
    return _requests
        .where('agentId', isEqualTo: _uid)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> activeRequests() {
    return _requests
        .where('agentId', isEqualTo: _uid)
        .where('status', whereIn: const [
      'accepted',
      'in_progress',
    ])
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> completedRequests() {
    return _requests
        .where('agentId', isEqualTo: _uid)
        .where('status', isEqualTo: 'completed')
        .orderBy('updatedAt', descending: true)
        .snapshots();
  }

  Future<void> acceptRequest(String requestId) async {
    await _requests.doc(requestId).update({
      'status': 'accepted',
      'acceptedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> rejectRequest({
    required String requestId,
    String? reason,
  }) async {
    await _requests.doc(requestId).update({
      'status': 'rejected',
      'rejectedReason': reason ?? '',
      'rejectedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> markCompleted(String requestId) async {
    await _requests.doc(requestId).update({
      'status': 'completed',
      'completedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}