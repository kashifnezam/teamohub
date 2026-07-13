import 'package:flutter/material.dart';
import '../models/product_model.dart';

class DescriptionCard extends StatelessWidget {
  final ProductModel post;

  const DescriptionCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //------------------------------------------------
            // Heading
            //------------------------------------------------

            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Text(
              post.description,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 22),

            const Divider(),

            const SizedBox(height: 18),

            const Text(
              "Product Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            _detailTile(
              "Category",
              post.categoryId,
            ),

            _detailTile(
              "Sub Category",
              post.subCategoryId.toString(),
            ),

            _detailTile(
              "Condition",
              post.condition.name,
            ),

            _detailTile(
              "Price Type",
              post.isNegotiable
                  ? "Negotiable"
                  : "Fixed Price",
            ),

            _detailTile(
              "Listing Type",
              post.type.name.toUpperCase(),
            ),

            _detailTile(
              "Status",
              post.status.name.toUpperCase(),
            ),

            const SizedBox(height: 10),

            if (post.isVerified)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green.shade300,
                  ),
                ),
                child: const Row(
                  children: [

                    Icon(
                      Icons.verified,
                      color: Colors.green,
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "This listing has been verified by TeamoMart.",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  ],
                ),
              ),

          ],
        ),
      ),
    );
  }

  Widget _detailTile(
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [

          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),

        ],
      ),
    );
  }
}