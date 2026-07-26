import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgentListingRepository {
  AgentListingRepository._();

  static final AgentListingRepository instance =
  AgentListingRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _agentListings =>
      _firestore.collection('agent_listings');

  Future<String> createAgentListing({
    required String originalProductId,
    required String sellerId,
    required String promotionRequestId,
    required String title,
    required String description,
    required List<String> images,
    required String sellingNotes,
  }) async {
    final doc = _agentListings.doc();

    await doc.set({
      'id': doc.id,

      // Relationships
      'originalProductId': originalProductId,
      'promotionRequestId': promotionRequestId,
      'sellerId': sellerId,
      'agentId': _uid,

      // Agent Listing
      'title': title,
      'description': description,
      'images': images,
      'sellingNotes': sellingNotes,

      // Status
      'status': 'active',
      'dealStatus': 'available',

      // Sharing
      'shareUrl': '',
      'shareCount': 0,
      'viewCount': 0,

      // Analytics
      'chatCount': 0,
      'enquiryCount': 0,

      // Timestamps
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return doc.id;
  }

  Future<void> updateShareUrl({
    required String listingId,
    required String url,
  }) async {
    await _agentListings.doc(listingId).update({
      'shareUrl': url,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> myListings() {
    return _agentListings
        .where('agentId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> markSold(String listingId) async {
    await _agentListings.doc(listingId).update({
      'dealStatus': 'completed',
      'completedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deactivateListing(String listingId) async {
    await _agentListings.doc(listingId).update({
      'status': 'inactive',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}