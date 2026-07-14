import 'package:flutter/material.dart';

class LocationTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool showChevron;

  const LocationTile({
    super.key,
    required this.title,
    required this.onTap,
    this.icon = Icons.location_on_outlined,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ListTile(

          leading: Icon(icon),

          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          trailing: showChevron
              ? const Icon(
            Icons.chevron_right,
          )
              : null,

          onTap: onTap,

        ),

        const Divider(
          height: 1,
        ),

      ],
    );
  }
}