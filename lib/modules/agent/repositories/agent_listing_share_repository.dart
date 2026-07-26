import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgentListingShareRepository {
  AgentListingShareRepository._();

  static final AgentListingShareRepository instance =
  AgentListingShareRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _agentListings =>
      _firestore.collection('agent_listings');

  Future<DocumentSnapshot<Map<String, dynamic>>> getListing(
      String listingId,
      ) {
    return _agentListings.doc(listingId).get();
  }

  Future<void> increaseShareCount(
      String listingId,
      ) async {
    await _agentListings.doc(listingId).update({
      'shareCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> increaseViewCount(
      String listingId,
      ) async {
    await _agentListings.doc(listingId).update({
      'viewCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> increaseEnquiryCount(
      String listingId,
      ) async {
    await _agentListings.doc(listingId).update({
      'enquiryCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> increaseChatCount(
      String listingId,
      ) async {
    await _agentListings.doc(listingId).update({
      'chatCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateLastShared() async {
    await _firestore
        .collection('agents')
        .doc(_uid)
        .set(
      {
        'lastSharedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }
}