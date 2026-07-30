import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:teamomarket/modules/product/controllers/product_controller.dart';

class DeepLinkService {
  DeepLinkService._();

  static final DeepLinkService instance = DeepLinkService._();

  final AppLinks _appLinks = AppLinks();

  StreamSubscription<Uri>? _subscription;

  Future<void> init() async {
    // App opened from terminated state
    final Uri? initialUri = await _appLinks.getInitialLink();

    if (initialUri != null) {
      _handleLink(initialUri);
    }

    // App running in background/foreground
    _subscription = _appLinks.uriLinkStream.listen(
      _handleLink,
      onError: (error) {
        print("Deep Link Error: $error");
      },
    );
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }

  void _handleLink(Uri uri) {
    print("Deep Link: $uri");

    if (uri.pathSegments.isEmpty) {
      return;
    }

    switch (uri.pathSegments.first) {
      case "p":
        if (uri.pathSegments.length < 2) {
          return;
        }

        final productId = uri.pathSegments[1];

        ProductController().getProductDetail(productId);

        break;
    }
  }
}