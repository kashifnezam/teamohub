import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      CategoryItem("Cars", "assets/categories/car.png"),
      CategoryItem("Properties", "assets/categories/property.png"),
      CategoryItem("Mobiles", "assets/categories/mobile.png"),
      CategoryItem("Jobs", "assets/categories/jobs.png"),
      CategoryItem("Bikes", "assets/categories/bikes.png"),
      CategoryItem("Electronics", "assets/categories/electronics.png"),
      CategoryItem("Commercial", "assets/categories/truck.png"),
      CategoryItem("Furniture", "assets/categories/furniture.png"),
      CategoryItem("Fashion", "assets/categories/fashion.png"),
      CategoryItem("Books, Sports & Hobbies", "assets/categories/books&sports.png"),
      CategoryItem("Pets", "assets/categories/pets.png"),
      CategoryItem("Services", "assets/categories/service.png"),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [

         /* Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search category",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),*/

          const SizedBox(height: 16),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 18,
                childAspectRatio: .82,
              ),
              itemBuilder: (_, index) {
                final item = categories[index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: 64,
                        width: 64,

                        child: Image.asset(item.image),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem {
  final String title;
  final String image;

  CategoryItem(this.title, this.image);
}