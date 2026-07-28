import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../app/constants/firebase_constants.dart';
import '../models/agent_model.dart';

class AgentProfileRepository {
  AgentProfileRepository._();

  static final AgentProfileRepository instance =
  AgentProfileRepository._();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _agents =>
      _firestore.collection(FirebaseConstants.agents);

  Future<AgentModel> getAgent(
      String agentId,
      ) async {
    final doc = await _agents.doc(agentId).get();

    return AgentModel.fromMap(
      doc.data()!,
      doc.id,
    );
  }
}