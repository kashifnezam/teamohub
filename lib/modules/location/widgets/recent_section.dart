import 'package:flutter/material.dart';

import '../models/location_result.dart';
import 'location_tile.dart';
import 'section_header.dart';

class RecentSection extends StatelessWidget {
  final List<LocationResult> locations;
  final ValueChanged<LocationResult> onTap;

  const RecentSection({
    super.key,
    required this.locations,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: "Recently Used",
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: locations.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, index) {
            final location = locations[index];

            return LocationTile(
              title: location.displayName,
              icon: Icons.history,
              showChevron: false,
              onTap: () => onTap(location),
            );
          },
        )
      ],
    );
  }
}