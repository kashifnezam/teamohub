import 'package:flutter/material.dart';

class RecommendedProductCard extends StatelessWidget {

  final String image;
  final String title;
  final String location;
  final String price;

  const RecommendedProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            child: Image.network(
              image,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [

                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),

                    const SizedBox(width: 4),

                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}