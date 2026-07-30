import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamomarket/app/utils/offline_data.dart';
import 'package:teamomarket/modules/product/repositories/product_repository.dart';

import '../../../app/constants/firebase_constants.dart';
import '../../product/models/product_model.dart';
import '../models/agent_listing_model.dart';
import '../models/agent_product_listing_model.dart';

class AgentListingRepository {
  AgentListingRepository._();

  static final AgentListingRepository instance =
  AgentListingRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>>  get _collection => _firestore.collection("agent_listings");
  CollectionReference<Map<String, dynamic>> get _products => _firestore.collection(FirebaseConstants.products);


  CollectionReference<Map<String, dynamic>>  get _requests => _firestore.collection("agent_requests");

  ///------------------------------------------------
  /// Create Product
  ///------------------------------------------------

  Future<String> createAgentProduct({
    required ProductModel product,
    required String title,
    required String description,
    required double price,
  }) async {
    final doc = _products.doc();

    await doc.set(
      product.copyWith(
        id: doc.id,
        title: title,
        description: description,
        price: price,
        status: ProductStatus.active,
        sellerPhoto: userInfo?['photoUrl'],
        sellerName: userInfo?['name'],
        sellerId: userInfo?['id'],
        searchKeywords: ProductRepository().generateSearchKeywords(
          title: product.title,
          category: product.categoryName,
          subCategory: product.subCategoryName,
        ),
        createdAt: DateTime.now(),
        publishedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson(),

    );

    return doc.id;
  }

  Future<String> createListing({
    required String requestId, required String agentProductId, required String originalProductId, required String sellingNotes}) async {
    final doc = _collection.doc();
    final listing = AgentListingModel(
      agentProductId: agentProductId,
      id: doc.id,
      agentId: userInfo?['id'],
      requestId: requestId,
      dealStatus: 'available',
      originalProductId: originalProductId,
      sellingNotes: sellingNotes,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final data = listing.toFirestore();
    data["createdAt"] = FieldValue.serverTimestamp();
    data["updatedAt"] = FieldValue.serverTimestamp();
    await doc.set(data);

    await _requests.doc(requestId).update({
      "listingId": doc.id,
      "status": "accepted",
      "acceptedAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    });

    return doc.id;
  }
  Stream<List<AgentProductListingModel>> myListings() {
    return FirebaseFirestore.instance
        .collection("agent_listings")
        .where("agentId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .asyncMap((listingSnapshot) async {
      final listings = listingSnapshot.docs
          .map(AgentListingModel.fromFirestore)
          .toList();

      if (listings.isEmpty) {
        return [];
      }

      final ids = listings
          .map((e) => e.agentProductId)
          .toList();

      final products = <ProductModel>[];

      for (int i = 0; i < ids.length; i += 10) {
        final batch = ids.skip(i).take(10).toList();

        final snapshot = await FirebaseFirestore.instance
            .collection("products")
            .where(
          FieldPath.documentId,
          whereIn: batch,
        )
            .get();

        products.addAll(
          snapshot.docs.map(
                (e) => ProductModel.fromJson(e.data()),
          ),
        );
      }

      final productMap = {
        for (final p in products)
          p.id: p,
      };

      return listings
          .where(
            (e) => productMap.containsKey(e.agentProductId),
      )
          .map(
            (e) => AgentProductListingModel(
          listing: e,
          product: productMap[e.agentProductId]!,
        ),
      )
          .toList();
    });
  }

  Future<AgentListingModel?> getListing(String listingId,) async {
    final doc = await _collection.doc(listingId).get();
    if (!doc.exists) {
      return null;
    }
    return AgentListingModel.fromFirestore(doc);
  }

  Future<void> markSold(
      String listingId,
      ) async {
    await _collection.doc(listingId).update({
      "dealStatus": "completed",
      "completedAt":
      FieldValue.serverTimestamp(),
      "updatedAt":
      FieldValue.serverTimestamp(),
    });
  }

  Future<void> deactivate(
      String listingId,
      ) async {
    await _collection.doc(listingId).update({
      "status": "inactive",
      "updatedAt":
      FieldValue.serverTimestamp(),
    });
  }

  Future<void> activate(
      String listingId,
      ) async {
    await _collection.doc(listingId).update({
      "status": "active",
      "updatedAt":
      FieldValue.serverTimestamp(),
    });
  }

  Future<void> increaseShare(
      String listingId,
      ) async {
    await _collection.doc(listingId).update({
      "shareCount":
      FieldValue.increment(1),
    });
  }

  Future<void> increaseView(
      String listingId,
      ) async {
    await _collection.doc(listingId).update({
      "viewCount":
      FieldValue.increment(1),
    });
  }

  Future<void> increaseChat(
      String listingId,
      ) async {
    await _collection.doc(listingId).update({
      "chatCount":
      FieldValue.increment(1),
    });
  }

  Future<void> increaseEnquiry(
      String listingId,
      ) async {
    await _collection.doc(listingId).update({
      "enquiryCount":
      FieldValue.increment(1),
    });
  }
}