import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:teamomarket/app/constants/firebase_constants.dart';

import '../models/banner_model.dart';

class BannerRepository {
  BannerRepository();

  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  CollectionReference<Map<String, dynamic>> get _banners =>
      _firestore.collection(FirebaseConstants.banners);

  Reference _bannerRef(String bannerId) =>
      _storage.ref("${FirebaseConstants.banners}/$bannerId.jpg");

  /// Create Banner
  Future<void> createBanner({
    required BannerModel banner,
    required File image,
  }) async {
    final doc = _banners.doc();

    final imageRef = _bannerRef(doc.id);

    await imageRef.putFile(image);

    final imageUrl = await imageRef.getDownloadURL();

    await doc.set(
      banner.copyWith(
        id: doc.id,
        imageUrl: imageUrl,
      ).toJson(),
    );
  }

  /// Update Banner
  Future<void> updateBanner({
    required BannerModel banner,
    File? image,
  }) async {
    String imageUrl = banner.imageUrl;

    if (image != null) {
      final imageRef = _bannerRef(banner.id);

      await imageRef.putFile(image);

      imageUrl = await imageRef.getDownloadURL();
    }

    await _banners.doc(banner.id).update(
      banner.copyWith(
        imageUrl: imageUrl,
      ).toJson(),
    );
  }

  /// Get Active Banners
  Future<List<BannerModel>> getBanners({bool? isActive}) async {

    Query<Map<String, dynamic>> query = _banners.orderBy("order");
    if (isActive != null) query = query.where("isActive",isEqualTo: isActive);
    final snapshot = await query.get();
    return snapshot.docs.map((e) => BannerModel.fromJson(e.id, e.data())).toList();
  }

  /// Delete Banner
  Future<void> deleteBanner(String bannerId) async {
    await Future.wait([
      _banners.doc(bannerId).delete(),
      _bannerRef(bannerId).delete(),
    ]);
  }
}