import '../models/sub_category_model.dart';

final now = DateTime.now();

final List<SubCategoryModel> subCategories = [

  // ---------------- Cars ----------------

  SubCategoryModel(
    id: "car_1",
    categoryId: "cars",
    name: "Sedan",
    image: "car.png",
    order: 1,
    createdAt: now,
    updatedAt: now,
  ),

  SubCategoryModel(
    id: "car_2",
    categoryId: "cars",
    name: "SUV",
    image: "car.png",
    order: 2,
    createdAt: now,
    updatedAt: now,
  ),

  SubCategoryModel(
    id: "car_3",
    categoryId: "cars",
    name: "Hatchback",
    image: "car.png",
    order: 3,
    createdAt: now,
    updatedAt: now,
  ),

  SubCategoryModel(
    id: "car_4",
    categoryId: "cars",
    name: "Luxury Cars",
    image: "car.png",
    order: 4,
    createdAt: now,
    updatedAt: now,
  ),

  // ---------------- Mobiles ----------------

  SubCategoryModel(
    id: "mobile_1",
    categoryId: "mobiles",
    name: "Smartphones",
    image: "mobile.png",
    order: 1,
    createdAt: now,
    updatedAt: now,
  ),

  SubCategoryModel(
    id: "mobile_2",
    categoryId: "mobiles",
    name: "Tablets",
    image: "mobile.png",
    order: 2,
    createdAt: now,
    updatedAt: now,
  ),

  SubCategoryModel(
    id: "mobile_3",
    categoryId: "mobiles",
    name: "Accessories",
    image: "mobile.png",
    order: 3,
    createdAt: now,
    updatedAt: now,
  ),

  // ---------------- Property ----------------

  SubCategoryModel(
    id: "property_1",
    categoryId: "property",
    name: "Apartments",
    image: "property.png",
    order: 1,
    createdAt: now,
    updatedAt: now,
  ),

  SubCategoryModel(
    id: "property_2",
    categoryId: "property",
    name: "Houses",
    image: "property.png",
    order: 2,
    createdAt: now,
    updatedAt: now,
  ),

  SubCategoryModel(
    id: "property_3",
    categoryId: "property",
    name: "Plots",
    image: "property.png",
    order: 3,
    createdAt: now,
    updatedAt: now,
  ),

  SubCategoryModel(
    id: "property_4",
    categoryId: "property",
    name: "Commercial",
    image: "property.png",
    order: 4,
    createdAt: now,
    updatedAt: now,
  ),

  // ---------------- Fashion ----------------

  SubCategoryModel(id: "fashion_1", categoryId: "fashion", name: "Men", image: "fashion.png", order: 1, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "fashion_2", categoryId: "fashion", name: "Women", image: "fashion.png", order: 2, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "fashion_3", categoryId: "fashion", name: "Kids", image: "fashion.png", order: 3, createdAt: now, updatedAt: now),

  // ---------------- Jobs ----------------

  SubCategoryModel(id: "job_1", categoryId: "jobs", name: "IT Jobs", image: "jobs.png", order: 1, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "job_2", categoryId: "jobs", name: "Sales", image: "jobs.png", order: 2, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "job_3", categoryId: "jobs", name: "Work From Home", image: "jobs.png", order: 3, createdAt: now, updatedAt: now),

  // ---------------- Bikes ----------------

  SubCategoryModel(id: "bike_1", categoryId: "bikes", name: "Motorcycles", image: "bikes.png", order: 1, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "bike_2", categoryId: "bikes", name: "Scooters", image: "bikes.png", order: 2, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "bike_3", categoryId: "bikes", name: "Electric Bikes", image: "bikes.png", order: 3, createdAt: now, updatedAt: now),

  // ---------------- Furniture ----------------

  SubCategoryModel(id: "fur_1", categoryId: "furniture", name: "Sofa", image: "furniture.png", order: 1, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "fur_2", categoryId: "furniture", name: "Bed", image: "furniture.png", order: 2, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "fur_3", categoryId: "furniture", name: "Dining", image: "furniture.png", order: 3, createdAt: now, updatedAt: now),

  // ---------------- Electronics ----------------

  SubCategoryModel(id: "ele_1", categoryId: "electronics", name: "Laptop", image: "electronics.png", order: 1, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "ele_2", categoryId: "electronics", name: "TV", image: "electronics.png", order: 2, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "ele_3", categoryId: "electronics", name: "Refrigerator", image: "electronics.png", order: 3, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "ele_4", categoryId: "electronics", name: "Washing Machine", image: "electronics.png", order: 4, createdAt: now, updatedAt: now),

  // ---------------- Pets ----------------

  SubCategoryModel(id: "pet_1", categoryId: "pets", name: "Dogs", image: "pets.png", order: 1, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "pet_2", categoryId: "pets", name: "Cats", image: "pets.png", order: 2, createdAt: now, updatedAt: now),
  SubCategoryModel(id: "pet_3", categoryId: "pets", name: "Birds", image: "pets.png", order: 3, createdAt: now, updatedAt: now),
];