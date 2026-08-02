import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamomarket/app/constants/firebase_constants.dart';

class AgentListingShareRepository {
  AgentListingShareRepository._();

  static final AgentListingShareRepository instance = AgentListingShareRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _agentListings => _firestore.collection('agent_listings');
  CollectionReference<Map<String, dynamic>> get _productRef => _firestore.collection(FirebaseConstants.products);

  Future<DocumentSnapshot<Map<String, dynamic>>> getListing(
      String listingId,
      ) {
    return _agentListings.doc(listingId).get();
  }

  Future<void> increaseShareCount(
      String productId,
      ) async {
    await _productRef.doc(productId).update({
      'shares': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> increaseEnquiryCount(
      String productId,
      ) async {
    await _agentListings.doc(productId).update({
      'chats': FieldValue.increment(1),
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