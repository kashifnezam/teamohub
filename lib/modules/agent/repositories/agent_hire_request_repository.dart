import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamomarket/app/utils/offline_data.dart';

class AgentHireRequestRepository {
  AgentHireRequestRepository._();

  static final AgentHireRequestRepository instance =
  AgentHireRequestRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> submitRequest({
    required String agentId,
    required String productId,
  }) async {

    await _firestore.collection("agent_requests").add({
      "agentId": agentId,

      "userId": userInfo?['id'],

      "userName": userInfo?['name'] ?? "",

      "userImage": userInfo?['photoUrl'] ?? "",

      "productId": productId,

      "status": "pending",

      "chatId": "",

      "createdAt": FieldValue.serverTimestamp(),

      "updatedAt": FieldValue.serverTimestamp(),

      "acceptedAt": null,

      "rejectedAt": null,

      "completedAt": null,

      "rejectedReason": "",
    });
  }
}