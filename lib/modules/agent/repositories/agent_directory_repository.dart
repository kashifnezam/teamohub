import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../app/constants/firebase_constants.dart';
import '../models/agent_model.dart';

class AgentDirectoryRepository {
  AgentDirectoryRepository._();

  static final AgentDirectoryRepository instance =
  AgentDirectoryRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _agents => _firestore.collection(FirebaseConstants.agents);

  Stream<List<AgentModel>> streamVerifiedAgents() {
    return _agents
        .where("isAgent", isEqualTo: true)
        .where(
      "verificationStatus",
      isEqualTo: "verified",
    )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (e) => AgentModel.fromMap(
          e.data(),
          e.id,
        ),
      )
          .toList(),
    );
  }
}