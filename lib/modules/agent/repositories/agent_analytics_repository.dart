import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgentAnalyticsRepository {
  AgentAnalyticsRepository._();

  static final AgentAnalyticsRepository instance =
  AgentAnalyticsRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _listings =>
      _firestore.collection('agent_listings');

  Stream<QuerySnapshot<Map<String, dynamic>>> myListings() {
    return _listings
        .where(
      'agentId',
      isEqualTo: _uid,
    )
        .snapshots();
  }
}