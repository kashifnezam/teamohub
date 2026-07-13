import '../models/category_field_model.dart';

final List<CategoryFieldModel> categoryFields = [

  // ===========================
  // Cars
  // ===========================

  CategoryFieldModel(
    id: 'car_brand',
    categoryId: 'cars',
    key: 'brand',
    label: 'Brand',
    type: 'dropdown',
    options: [
      'Maruti Suzuki',
      'Hyundai',
      'Honda',
      'Toyota',
      'Mahindra',
      'Tata',
      'Kia',
      'MG',
      'BMW',
      'Mercedes',
      'Audi',
    ],
    isRequired: true,
    order: 1,
  ),

  CategoryFieldModel(
    id: 'car_model',
    categoryId: 'cars',
    key: 'model',
    label: 'Model',
    type: 'text',
    isRequired: true,
    order: 2,
  ),

  CategoryFieldModel(
    id: 'car_year',
    categoryId: 'cars',
    key: 'year',
    label: 'Manufacturing Year',
    type: 'number',
    order: 3,
  ),

  CategoryFieldModel(
    id: 'car_fuel',
    categoryId: 'cars',
    key: 'fuel',
    label: 'Fuel Type',
    type: 'dropdown',
    options: ['Petrol', 'Diesel', 'CNG', 'Electric', 'Hybrid'],
    order: 4,
  ),

  CategoryFieldModel(
    id: 'car_transmission',
    categoryId: 'cars',
    key: 'transmission',
    label: 'Transmission',
    type: 'dropdown',
    options: ['Manual', 'Automatic'],
    order: 5,
  ),

  CategoryFieldModel(
    id: 'car_km',
    categoryId: 'cars',
    key: 'kmDriven',
    label: 'KM Driven',
    type: 'number',
    order: 6,
  ),

  CategoryFieldModel(
    id: 'car_owner',
    categoryId: 'cars',
    key: 'owner',
    label: 'Owner',
    type: 'dropdown',
    options: ['1st', '2nd', '3rd', '4+'],
    order: 7,
  ),

  // ===========================
  // Mobiles
  // ===========================

  CategoryFieldModel(
    id: 'mobile_brand',
    categoryId: 'mobiles',
    key: 'brand',
    label: 'Brand',
    type: 'dropdown',
    options: [
      'Apple',
      'Samsung',
      'OnePlus',
      'Google',
      'Xiaomi',
      'Nothing',
      'Motorola',
      'Realme',
      'Vivo',
      'Oppo',
    ],
    order: 1,
  ),

  CategoryFieldModel(
    id: 'mobile_storage',
    categoryId: 'mobiles',
    key: 'storage',
    label: 'Storage',
    type: 'dropdown',
    options: ['64 GB', '128 GB', '256 GB', '512 GB', '1 TB'],
    order: 2,
  ),

  CategoryFieldModel(
    id: 'mobile_ram',
    categoryId: 'mobiles',
    key: 'ram',
    label: 'RAM',
    type: 'dropdown',
    options: ['4 GB', '6 GB', '8 GB', '12 GB', '16 GB'],
    order: 3,
  ),

  CategoryFieldModel(
    id: 'mobile_condition',
    categoryId: 'mobiles',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: ['New', 'Like New', 'Good', 'Fair'],
    order: 4,
  ),

  // ===========================
  // Property
  // ===========================

  CategoryFieldModel(
    id: 'property_bedrooms',
    categoryId: 'property',
    key: 'bedrooms',
    label: 'Bedrooms',
    type: 'dropdown',
    options: ['1', '2', '3', '4', '5+'],
    order: 1,
  ),

  CategoryFieldModel(
    id: 'property_bathrooms',
    categoryId: 'property',
    key: 'bathrooms',
    label: 'Bathrooms',
    type: 'dropdown',
    options: ['1', '2', '3', '4', '5+'],
    order: 2,
  ),

  CategoryFieldModel(
    id: 'property_area',
    categoryId: 'property',
    key: 'area',
    label: 'Area (sq.ft.)',
    type: 'number',
    order: 3,
  ),

  CategoryFieldModel(
    id: 'property_furnished',
    categoryId: 'property',
    key: 'furnished',
    label: 'Furnishing',
    type: 'dropdown',
    options: ['Furnished', 'Semi Furnished', 'Unfurnished'],
    order: 4,
  ),

  // ===========================
  // Fashion
  // ===========================

  CategoryFieldModel(
    id: 'fashion_brand',
    categoryId: 'fashion',
    key: 'brand',
    label: 'Brand',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'fashion_size',
    categoryId: 'fashion',
    key: 'size',
    label: 'Size',
    type: 'dropdown',
    options: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    order: 2,
  ),

  CategoryFieldModel(
    id: 'fashion_condition',
    categoryId: 'fashion',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: ['New', 'Used'],
    order: 3,
  ),

  // ===========================
  // Jobs
  // ===========================

  CategoryFieldModel(
    id: 'job_company',
    categoryId: 'jobs',
    key: 'company',
    label: 'Company',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'job_salary',
    categoryId: 'jobs',
    key: 'salary',
    label: 'Monthly Salary',
    type: 'number',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'job_experience',
    categoryId: 'jobs',
    key: 'experience',
    label: 'Experience',
    type: 'dropdown',
    options: ['Fresher', '1+ Years', '3+ Years', '5+ Years'],
    order: 3,
  ),

  // ===========================
  // Bikes
  // ===========================

  CategoryFieldModel(
    id: 'bike_brand',
    categoryId: 'bikes',
    key: 'brand',
    label: 'Brand',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'bike_year',
    categoryId: 'bikes',
    key: 'year',
    label: 'Year',
    type: 'number',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'bike_km',
    categoryId: 'bikes',
    key: 'kmDriven',
    label: 'KM Driven',
    type: 'number',
    order: 3,
  ),

  // ===========================
  // Furniture
  // ===========================

  CategoryFieldModel(
    id: 'furniture_material',
    categoryId: 'furniture',
    key: 'material',
    label: 'Material',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'furniture_condition',
    categoryId: 'furniture',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: ['New', 'Used'],
    order: 2,
  ),

  // ===========================
  // Services
  // ===========================

  CategoryFieldModel(
    id: 'service_name',
    categoryId: 'services',
    key: 'serviceName',
    label: 'Service Name',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'service_experience',
    categoryId: 'services',
    key: 'experience',
    label: 'Experience',
    type: 'number',
    order: 2,
  ),

  // ===========================
  // Electronics
  // ===========================

  CategoryFieldModel(
    id: 'electronics_brand',
    categoryId: 'electronics',
    key: 'brand',
    label: 'Brand',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'electronics_condition',
    categoryId: 'electronics',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: ['New', 'Used'],
    order: 2,
  ),

  CategoryFieldModel(
    id: 'electronics_warranty',
    categoryId: 'electronics',
    key: 'warranty',
    label: 'Warranty',
    type: 'dropdown',
    options: ['Yes', 'No'],
    order: 3,
  ),

  // ===========================
  // Pets
  // ===========================

  CategoryFieldModel(
    id: 'pet_breed',
    categoryId: 'pets',
    key: 'breed',
    label: 'Breed',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'pet_age',
    categoryId: 'pets',
    key: 'age',
    label: 'Age (Months)',
    type: 'number',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'pet_gender',
    categoryId: 'pets',
    key: 'gender',
    label: 'Gender',
    type: 'dropdown',
    options: ['Male', 'Female'],
    order: 3,
  ),

  CategoryFieldModel(
    id: 'pet_vaccinated',
    categoryId: 'pets',
    key: 'vaccinated',
    label: 'Vaccinated',
    type: 'dropdown',
    options: ['Yes', 'No'],
    order: 4,
  ),
];