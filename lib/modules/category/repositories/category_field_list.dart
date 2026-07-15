import '../models/category_field_model.dart';
import 'field_options.dart';

final List<CategoryFieldModel> categoryFields = [

  // ==========================================================
  // Cars
  // ==========================================================

  CategoryFieldModel(
    id: 'car_brand',
    categoryId: 'cars',
    key: 'brand',
    label: 'Brand',
    type: 'dropdown',
    options: carBrands,
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
    options: fuelOptions,
    order: 4,
  ),

  CategoryFieldModel(
    id: 'car_transmission',
    categoryId: 'cars',
    key: 'transmission',
    label: 'Transmission',
    type: 'dropdown',
    options: transmissionOptions,
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
    options: ownerOptions,
    order: 7,
  ),

  CategoryFieldModel(
    id: 'car_condition',
    categoryId: 'cars',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: conditionOptions,
    order: 8,
  ),

  // ==========================================================
  // Bikes
  // ==========================================================

  CategoryFieldModel(
    id: 'bike_brand',
    categoryId: 'bikes',
    key: 'brand',
    label: 'Brand',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'bike_model',
    categoryId: 'bikes',
    key: 'model',
    label: 'Model',
    type: 'text',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'bike_year',
    categoryId: 'bikes',
    key: 'year',
    label: 'Manufacturing Year',
    type: 'number',
    order: 3,
  ),

  CategoryFieldModel(
    id: 'bike_km',
    categoryId: 'bikes',
    key: 'kmDriven',
    label: 'KM Driven',
    type: 'number',
    order: 4,
  ),

  CategoryFieldModel(
    id: 'bike_condition',
    categoryId: 'bikes',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: conditionOptions,
    order: 5,
  ),

  // ==========================================================
  // Mobiles
  // ==========================================================

  CategoryFieldModel(
    id: 'mobile_brand',
    categoryId: 'mobiles',
    key: 'brand',
    label: 'Brand',
    type: 'dropdown',
    options: mobileBrands,
    order: 1,
  ),

  CategoryFieldModel(
    id: 'mobile_storage',
    categoryId: 'mobiles',
    key: 'storage',
    label: 'Storage',
    type: 'dropdown',
    options: storageOptions,
    order: 2,
  ),

  CategoryFieldModel(
    id: 'mobile_ram',
    categoryId: 'mobiles',
    key: 'ram',
    label: 'RAM',
    type: 'dropdown',
    options: ramOptions,
    order: 3,
  ),

  CategoryFieldModel(
    id: 'mobile_condition',
    categoryId: 'mobiles',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: conditionOptions,
    order: 4,
  ),

  CategoryFieldModel(
    id: 'mobile_warranty',
    categoryId: 'mobiles',
    key: 'warranty',
    label: 'Warranty',
    type: 'dropdown',
    options: yesNoOptions,
    order: 5,
  ),

  // ==========================================================
  // Electronics
  // ==========================================================

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
    options: conditionOptions,
    order: 2,
  ),

  CategoryFieldModel(
    id: 'electronics_warranty',
    categoryId: 'electronics',
    key: 'warranty',
    label: 'Warranty',
    type: 'dropdown',
    options: yesNoOptions,
    order: 3,
  ),

  // ==========================================================
  // Fashion
  // ==========================================================

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
    options: fashionSizeOptions,
    order: 2,
  ),

  CategoryFieldModel(
    id: 'fashion_color',
    categoryId: 'fashion',
    key: 'color',
    label: 'Color',
    type: 'text',
    order: 3,
  ),

  CategoryFieldModel(
    id: 'fashion_condition',
    categoryId: 'fashion',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: conditionOptions,
    order: 4,
  ),

  // ==========================================================
  // Property
  // ==========================================================

  CategoryFieldModel(
    id: 'property_type',
    categoryId: 'property',
    key: 'propertyType',
    label: 'Property Type',
    type: 'dropdown',
    options: options([
      'Apartment',
      'House',
      'Villa',
      'Plot',
      'Commercial',
    ]),
    order: 1,
  ),

  CategoryFieldModel(
    id: 'property_bedrooms',
    categoryId: 'property',
    key: 'bedrooms',
    label: 'Bedrooms',
    type: 'dropdown',
    options: bedroomOptions,
    order: 2,
  ),

  CategoryFieldModel(
    id: 'property_bathrooms',
    categoryId: 'property',
    key: 'bathrooms',
    label: 'Bathrooms',
    type: 'dropdown',
    options: bathroomOptions,
    order: 3,
  ),

  CategoryFieldModel(
    id: 'property_area',
    categoryId: 'property',
    key: 'area',
    label: 'Area (sq.ft.)',
    type: 'number',
    order: 4,
  ),

  CategoryFieldModel(
    id: 'property_furnished',
    categoryId: 'property',
    key: 'furnished',
    label: 'Furnishing',
    type: 'dropdown',
    options: furnishingOptions,
    order: 5,
  ),

  CategoryFieldModel(
    id: 'property_condition',
    categoryId: 'property',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: conditionOptions,
    order: 6,
  ),

  // ==========================================================
  // Furniture
  // ==========================================================

  CategoryFieldModel(
    id: 'furniture_type',
    categoryId: 'furniture',
    key: 'type',
    label: 'Furniture Type',
    type: 'dropdown',
    options: options([
      'Sofa',
      'Chair',
      'Table',
      'Bed',
      'Wardrobe',
      'Dining Set',
      'TV Unit',
      'Other',
    ]),
    order: 1,
  ),

  CategoryFieldModel(
    id: 'furniture_material',
    categoryId: 'furniture',
    key: 'material',
    label: 'Material',
    type: 'text',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'furniture_condition',
    categoryId: 'furniture',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: conditionOptions,
    order: 3,
  ),

  // ==========================================================
  // Pets
  // ==========================================================

  CategoryFieldModel(
    id: 'pet_type',
    categoryId: 'pets',
    key: 'petType',
    label: 'Pet Type',
    type: 'dropdown',
    options: options([
      'Dog',
      'Cat',
      'Bird',
      'Rabbit',
      'Fish',
      'Other',
    ]),
    order: 1,
  ),

  CategoryFieldModel(
    id: 'pet_breed',
    categoryId: 'pets',
    key: 'breed',
    label: 'Breed',
    type: 'text',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'pet_age',
    categoryId: 'pets',
    key: 'age',
    label: 'Age (Months)',
    type: 'number',
    order: 3,
  ),

  CategoryFieldModel(
    id: 'pet_gender',
    categoryId: 'pets',
    key: 'gender',
    label: 'Gender',
    type: 'dropdown',
    options: genderOptions,
    order: 4,
  ),

  CategoryFieldModel(
    id: 'pet_vaccinated',
    categoryId: 'pets',
    key: 'vaccinated',
    label: 'Vaccinated',
    type: 'dropdown',
    options: yesNoOptions,
    order: 5,
  ),

  // ==========================================================
  // Jobs
  // ==========================================================

  CategoryFieldModel(
    id: 'job_company',
    categoryId: 'jobs',
    key: 'company',
    label: 'Company',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'job_position',
    categoryId: 'jobs',
    key: 'position',
    label: 'Position',
    type: 'text',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'job_salary',
    categoryId: 'jobs',
    key: 'salary',
    label: 'Monthly Salary',
    type: 'number',
    order: 3,
  ),

  CategoryFieldModel(
    id: 'job_experience',
    categoryId: 'jobs',
    key: 'experience',
    label: 'Experience',
    type: 'dropdown',
    options: experienceOptions,
    order: 4,
  ),

  CategoryFieldModel(
    id: 'job_job_type',
    categoryId: 'jobs',
    key: 'jobType',
    label: 'Job Type',
    type: 'dropdown',
    options: options([
      'Full Time',
      'Part Time',
      'Contract',
      'Internship',
      'Remote',
    ]),
    order: 5,
  ),

  // ==========================================================
  // Services
  // ==========================================================

  CategoryFieldModel(
    id: 'service_name',
    categoryId: 'services',
    key: 'serviceName',
    label: 'Service Name',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'service_category',
    categoryId: 'services',
    key: 'serviceCategory',
    label: 'Service Category',
    type: 'dropdown',
    options: options([
      'Cleaning',
      'Repair',
      'Beauty',
      'Education',
      'Health',
      'IT',
      'Home Service',
      'Other',
    ]),
    order: 2,
  ),

  CategoryFieldModel(
    id: 'service_experience',
    categoryId: 'services',
    key: 'experience',
    label: 'Experience (Years)',
    type: 'number',
    order: 3,
  ),

  CategoryFieldModel(
    id: 'service_home_visit',
    categoryId: 'services',
    key: 'homeVisit',
    label: 'Home Visit Available',
    type: 'dropdown',
    options: yesNoOptions,
    order: 4,
  ),
  // ==========================================================
  // Books
  // ==========================================================

  CategoryFieldModel(
    id: 'book_title',
    categoryId: 'books',
    key: 'title',
    label: 'Book Title',
    type: 'text',
    isRequired: true,
    order: 1,
  ),

  CategoryFieldModel(
    id: 'book_author',
    categoryId: 'books',
    key: 'author',
    label: 'Author',
    type: 'text',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'book_language',
    categoryId: 'books',
    key: 'language',
    label: 'Language',
    type: 'dropdown',
    options: options([
      'English',
      'Hindi',
      'Urdu',
      'Bengali',
      'Tamil',
      'Telugu',
      'Other',
    ]),
    order: 3,
  ),

  CategoryFieldModel(
    id: 'book_condition',
    categoryId: 'books',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: conditionOptions,
    order: 4,
  ),

  // ==========================================================
  // Sports
  // ==========================================================

  CategoryFieldModel(
    id: 'sports_category',
    categoryId: 'sports',
    key: 'sport',
    label: 'Sport',
    type: 'dropdown',
    options: options([
      'Cricket',
      'Football',
      'Badminton',
      'Gym',
      'Cycling',
      'Swimming',
      'Other',
    ]),
    order: 1,
  ),

  CategoryFieldModel(
    id: 'sports_brand',
    categoryId: 'sports',
    key: 'brand',
    label: 'Brand',
    type: 'text',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'sports_condition',
    categoryId: 'sports',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: conditionOptions,
    order: 3,
  ),

  // ==========================================================
  // Beauty
  // ==========================================================

  CategoryFieldModel(
    id: 'beauty_brand',
    categoryId: 'beauty',
    key: 'brand',
    label: 'Brand',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'beauty_expiry',
    categoryId: 'beauty',
    key: 'expiry',
    label: 'Expiry Date',
    type: 'date',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'beauty_sealed',
    categoryId: 'beauty',
    key: 'sealed',
    label: 'Factory Sealed',
    type: 'dropdown',
    options: yesNoOptions,
    order: 3,
  ),

  // ==========================================================
  // Kids
  // ==========================================================

  CategoryFieldModel(
    id: 'kids_category',
    categoryId: 'kids',
    key: 'category',
    label: 'Category',
    type: 'dropdown',
    options: options([
      'Toys',
      'Clothing',
      'Baby Gear',
      'Books',
      'School Items',
    ]),
    order: 1,
  ),

  CategoryFieldModel(
    id: 'kids_age',
    categoryId: 'kids',
    key: 'ageGroup',
    label: 'Age Group',
    type: 'dropdown',
    options: options([
      '0-1 Years',
      '1-3 Years',
      '3-5 Years',
      '5-10 Years',
      '10+ Years',
    ]),
    order: 2,
  ),

  CategoryFieldModel(
    id: 'kids_condition',
    categoryId: 'kids',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: conditionOptions,
    order: 3,
  ),

  // ==========================================================
  // Agriculture
  // ==========================================================

  CategoryFieldModel(
    id: 'agri_type',
    categoryId: 'agriculture',
    key: 'type',
    label: 'Category',
    type: 'dropdown',
    options: options([
      'Tractor',
      'Equipment',
      'Seeds',
      'Fertilizer',
      'Livestock',
    ]),
    order: 1,
  ),

  CategoryFieldModel(
    id: 'agri_brand',
    categoryId: 'agriculture',
    key: 'brand',
    label: 'Brand',
    type: 'text',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'agri_condition',
    categoryId: 'agriculture',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: conditionOptions,
    order: 3,
  ),

  // ==========================================================
  // Business
  // ==========================================================

  CategoryFieldModel(
    id: 'business_name',
    categoryId: 'business',
    key: 'businessName',
    label: 'Business Name',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'business_type',
    categoryId: 'business',
    key: 'businessType',
    label: 'Business Type',
    type: 'dropdown',
    options: options([
      'Retail',
      'Wholesale',
      'Manufacturing',
      'Franchise',
      'Startup',
    ]),
    order: 2,
  ),

  // ==========================================================
  // Education
  // ==========================================================

  CategoryFieldModel(
    id: 'education_course',
    categoryId: 'education',
    key: 'course',
    label: 'Course Name',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'education_mode',
    categoryId: 'education',
    key: 'mode',
    label: 'Mode',
    type: 'dropdown',
    options: options([
      'Online',
      'Offline',
      'Hybrid',
    ]),
    order: 2,
  ),

  // ==========================================================
  // Food
  // ==========================================================

  CategoryFieldModel(
    id: 'food_type',
    categoryId: 'food',
    key: 'foodType',
    label: 'Food Type',
    type: 'dropdown',
    options: options([
      'Veg',
      'Non Veg',
      'Bakery',
      'Beverages',
    ]),
    order: 1,
  ),

  CategoryFieldModel(
    id: 'food_delivery',
    categoryId: 'food',
    key: 'delivery',
    label: 'Home Delivery',
    type: 'dropdown',
    options: yesNoOptions,
    order: 2,
  ),

  // ==========================================================
  // Events
  // ==========================================================

  CategoryFieldModel(
    id: 'event_name',
    categoryId: 'events',
    key: 'eventName',
    label: 'Event Name',
    type: 'text',
    order: 1,
  ),

  CategoryFieldModel(
    id: 'event_date',
    categoryId: 'events',
    key: 'eventDate',
    label: 'Event Date',
    type: 'date',
    order: 2,
  ),

  CategoryFieldModel(
    id: 'event_ticket',
    categoryId: 'events',
    key: 'ticketRequired',
    label: 'Ticket Required',
    type: 'dropdown',
    options: yesNoOptions,
    order: 3,
  ),

  // ==========================================================
  // Others
  // ==========================================================

  CategoryFieldModel(
    id: 'other_condition',
    categoryId: 'others',
    key: 'condition',
    label: 'Condition',
    type: 'dropdown',
    options: conditionOptions,
    order: 1,
  ),

  CategoryFieldModel(
    id: 'other_brand',
    categoryId: 'others',
    key: 'brand',
    label: 'Brand',
    type: 'text',
    order: 2,
  ),
];