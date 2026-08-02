import 'package:cloud_firestore/cloud_firestore.dart';

enum ProductPaginationStage {
  city,
  state,
  global,
  completed,
}

class ProductPagination {
  final ProductPaginationStage stage;

  final DocumentSnapshot? cityLastDocument;
  final DocumentSnapshot? stateLastDocument;
  final DocumentSnapshot? globalLastDocument;

  const ProductPagination({
    this.stage = ProductPaginationStage.city,
    this.cityLastDocument,
    this.stateLastDocument,
    this.globalLastDocument,
  });

  ProductPagination copyWith({
    ProductPaginationStage? stage,
    DocumentSnapshot? cityLastDocument,
    DocumentSnapshot? stateLastDocument,
    DocumentSnapshot? globalLastDocument,
  }) {
    return ProductPagination(
      stage: stage ?? this.stage,
      cityLastDocument: cityLastDocument ?? this.cityLastDocument,
      stateLastDocument: stateLastDocument ?? this.stateLastDocument,
      globalLastDocument:
      globalLastDocument ?? this.globalLastDocument,
    );
  }

  bool get isCompleted => stage == ProductPaginationStage.completed;
}