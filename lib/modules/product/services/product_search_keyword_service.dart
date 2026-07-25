class ProductSearchKeywordService {
  const ProductSearchKeywordService._();

  static List<String> generate({
    required String title,
    String? categoryName,
    String? subCategoryName,
    String? brandName,
  }) {
    final Set<String> keywords = {};

    void addText(String? value) {
      if (value == null) return;

      final normalized = value
          .toLowerCase()
          .replaceAll(RegExp(r'[^\w\s]'), ' ')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();

      if (normalized.isEmpty) return;

      for (final word in normalized.split(' ')) {
        if (word.isEmpty) continue;

        for (int i = 1; i <= word.length; i++) {
          keywords.add(word.substring(0, i));
        }
      }
    }

    addText(title);
    addText(categoryName);
    addText(subCategoryName);
    addText(brandName);

    return keywords.toList()..sort();
  }
}