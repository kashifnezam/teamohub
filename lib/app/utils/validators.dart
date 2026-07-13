class AppValidator {
  AppValidator._();

  static String? productTitle(String? value) {
    final title = value?.trim() ?? '';

    if (title.isEmpty) {
      return "Please enter an ad title.";
    }

    if (title.length < 10) {
      return "Title should be at least 10 characters.";
    }

    if (title.length > 100) {
      return "Title cannot exceed 100 characters.";
    }

    if (RegExp(r'^\d+$').hasMatch(title)) {
      return "Enter a meaningful product title.";
    }

    return null;
  }

  static String? price(String? value) {
    final price = value?.trim() ?? '';

    if (price.isEmpty) {
      return "Please enter the price.";
    }

    final amount = double.tryParse(price);

    if (amount == null) {
      return "Enter a valid price.";
    }

    if (amount <= 0) {
      return "Price must be greater than ₹0.";
    }

    return null;
  }

  static String? description(String? value) {
    final description = value?.trim() ?? '';

    if (description.isEmpty) {
      return "Please enter a description.";
    }

    if (description.length < 20) {
      return "Description should be at least 20 characters.";
    }

    if (description.length > 1000) {
      return "Description cannot exceed 1000 characters.";
    }

    return null;
  }
}