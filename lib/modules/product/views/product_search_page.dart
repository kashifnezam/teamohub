import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/modules/product/views/product_details_page.dart';

import '../controllers/product_search_controller.dart';
import '../models/product_model.dart';
import '../widgets/product_search_bar.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final ProductSearchController controller =
  Get.put(ProductSearchController());

  final TextEditingController searchController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (!scrollController.hasClients) return;

      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300) {
        controller.loadMore();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 45,
          child: ProductSearchBar(
            autofocus: true,
            showBackButton: true,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errorMessage.value != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.errorMessage.value!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.retryLoading,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        if (controller.products.isEmpty) {
          return RefreshIndicator(
            onRefresh: controller.refreshProducts,
            child: ListView(
              children: [
                SizedBox(height: 150),
                Center(
                  child: Text("No Products Found"),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshProducts,
          child: ListView.builder(
            controller: scrollController,
            itemCount: controller.products.length +
                (controller.loadingMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= controller.products.length) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final ProductModel product = controller.products[index];

              return ListTile(
                leading: product.images.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.images.first,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                )
                    : const SizedBox(
                  width: 70,
                  height: 70,
                  child: ColoredBox(
                    color: Colors.grey,
                  ),
                ),
                title: Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  "₹${product.price}",
                ),
                onTap: () {
                  Get.to(()=> ProductDetailsPage(product: product));
                },
              );
            },
          ),
        );
      }),
    );
  }
}