import 'package:flutter/material.dart';

class LoadingLocation extends StatelessWidget {
  const LoadingLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}