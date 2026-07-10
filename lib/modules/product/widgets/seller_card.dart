import 'package:flutter/material.dart';

import '../../../app/utils/app_colors.dart';

class SellerCard extends StatelessWidget {
  final String userId;

  const SellerCard({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with Firebase UserModel
    const sellerName = "Kashif";
    const sellerImage =
        "https://i.pravatar.cc/150?img=3";

    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      elevation: .5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            //------------------------------------------
            // Heading
            //------------------------------------------

            Row(
              children: [

                const Text(
                  "Seller Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                TextButton(
                  onPressed: () {
                    // View seller profile
                  },
                  child: const Text("View Profile"),
                )

              ],
            ),

            const SizedBox(height: 12),

            //------------------------------------------
            // Seller
            //------------------------------------------

            Row(
              children: [

                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    sellerImage,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [

                          const Expanded(
                            child: Text(
                              sellerName,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green
                                  .withOpacity(.1),
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize:
                              MainAxisSize.min,
                              children: [

                                Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                  size: 14,
                                ),

                                SizedBox(width: 4),

                                Text(
                                  "Verified",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 11,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [

                          Icon(
                            Icons.star,
                            color: Colors.amber.shade700,
                            size: 18,
                          ),

                          const SizedBox(width: 4),

                          const Text(
                            "4.8",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),

                          const SizedBox(width: 4),

                          Text(
                            "(128 Reviews)",
                            style: TextStyle(
                              color:
                              Colors.grey.shade600,
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Member since January 2025",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),

            const SizedBox(height: 18),

            //------------------------------------------
            // Statistics
            //------------------------------------------

            Row(
              children: [

                Expanded(
                  child: _statCard(
                    Icons.inventory_2_outlined,
                    "32",
                    "Ads",
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    Icons.sell_outlined,
                    "24",
                    "Sold",
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    Icons.visibility_outlined,
                    "18K",
                    "Views",
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _statCard(
      IconData icon,
      String value,
      String label,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [

          Icon(
            icon,
            color: AppColors.primary,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

        ],
      ),
    );
  }
}