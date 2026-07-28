import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/constants/firebase_constants.dart';
import '../../favourite/controllers/favourite_controller.dart';
import '../../product/models/product_model.dart';
import '../../product/widgets/product_card.dart';

class FavouritePage extends GetView<FavouriteController> {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
        centerTitle: true,
      ),
      body: Obx(() {
        final ids = controller.favouriteIds.toList();

        if (ids.isEmpty) {
          return const _EmptyFavouriteView();
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: ids.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, index) {
            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseConstants.products)
                  .doc(ids[index])
                  .snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return const _FavouriteShimmerCard();
                }

                if (!snapshot.data!.exists) {
                  return const SizedBox.shrink();
                }

                final product = ProductModel.fromMap(snapshot.data!.data()!);

                return ProductCard(
                  product: product,
                );
              },
            );
          },
        );
      }),
    );
  }
}

class _EmptyFavouriteView extends StatelessWidget {
  const _EmptyFavouriteView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_rounded,
              size: 90,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              "No favourites yet",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "Tap the heart icon on any product to save it here.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _FavouriteShimmerCard extends StatelessWidget {
  const _FavouriteShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}