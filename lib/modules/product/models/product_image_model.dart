import 'dart:io';

import 'package:flutter/cupertino.dart';

class ProductImageModel {
  /// Local image while creating/editing product
  final File? file;

  /// Firebase URL after upload
  final String? url;

  /// Cover image
  final bool isCover;

  /// Display order
  final int order;

  const ProductImageModel({
    this.file,
    this.url,
    this.isCover = false,
    this.order = 0,
  });

  bool get isLocal => file != null;

  bool get isNetwork => url != null;

  ProductImageModel copyWith({
    File? file,
    String? url,
    bool? isCover,
    int? order,
  }) {
    return ProductImageModel(
      file: file ?? this.file,
      url: url ?? this.url,
      isCover: isCover ?? this.isCover,
      order: order ?? this.order,
    );
  }

  ImageProvider get imageProvider {
    if (file != null) {
      return FileImage(file!);
    }

    return NetworkImage(url!);
  }
}