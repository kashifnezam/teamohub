import '../models/field_option_model.dart';

extension StringOption on String {
  FieldOption get option => FieldOption(
    id: toLowerCase().replaceAll(' ', '_'),
    label: this,
  );
}

/// Convert a list of strings into FieldOptions
List<FieldOption> options(List<String> values) =>
    values.map((e) => e.option).toList();

/// Common Options

final yesNoOptions = options([
  'Yes',
  'No',
]);

final genderOptions = options([
  'Male',
  'Female',
]);

final conditionOptions = options([
  'New',
  'Like New',
  'Good',
  'Fair',
  'Poor',
]);

final transmissionOptions = options([
  'Manual',
  'Automatic',
]);

final fuelOptions = options([
  'Petrol',
  'Diesel',
  'CNG',
  'Electric',
  'Hybrid',
]);

final ownerOptions = options([
  '1st',
  '2nd',
  '3rd',
  '4+',
]);

/// Common Data Sets

final mobileBrands = options([
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
]);

final carBrands = options([
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
]);

final ramOptions = options([
  '4 GB',
  '6 GB',
  '8 GB',
  '12 GB',
  '16 GB',
]);

final storageOptions = options([
  '64 GB',
  '128 GB',
  '256 GB',
  '512 GB',
  '1 TB',
]);

final bedroomOptions = options([
  '1',
  '2',
  '3',
  '4',
  '5+',
]);

final bathroomOptions = options([
  '1',
  '2',
  '3',
  '4',
  '5+',
]);

final furnishingOptions = options([
  'Furnished',
  'Semi Furnished',
  'Unfurnished',
]);

final fashionSizeOptions = options([
  'XS',
  'S',
  'M',
  'L',
  'XL',
  'XXL',
]);

final experienceOptions = options([
  'Fresher',
  '1+ Years',
  '3+ Years',
  '5+ Years',
]);