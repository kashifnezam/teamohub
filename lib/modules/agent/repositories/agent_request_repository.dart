import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/agent_request_model.dart';

class AgentRequestRepository {
  AgentRequestRepository._();

  static final AgentRequestRepository instance =
  AgentRequestRepository._();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('agent_requests');

  Stream<List<AgentRequestModel>> streamRequests({
    required String status,
  }) {
    return _collection
        .where('agentId', isEqualTo: _auth.currentUser!.uid)
        .where('status', isEqualTo: status)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => AgentRequestModel.fromFirestore(doc),
      )
          .toList(),
    );
  }

  Stream<List<AgentRequestModel>> streamPendingRequests() {
    return streamRequests(status: 'pending');
  }

  Stream<List<AgentRequestModel>> streamAcceptedRequests() {
    return streamRequests(status: 'accepted');
  }

  Stream<List<AgentRequestModel>> streamCompletedRequests() {
    return streamRequests(status: 'completed');
  }

  Future<void> acceptRequest(String requestId) {
    return _collection.doc(requestId).update({
      'status': 'accepted',
      'acceptedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> rejectRequest(String requestId) {
    return _collection.doc(requestId).update({
      'status': 'rejected',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> completeRequest(String requestId) {
    return _collection.doc(requestId).update({
      'status': 'completed',
      'completedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}