import 'package:flutter/material.dart';
import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/ui/theme/theme.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;

  const LocationTile({super.key, required this.location, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(location.name, style: BlaTextStyles.body),

      subtitle: Text(
        location.country.name,
        style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
      ),

      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: 16,
      ),

      onTap: onTap,
    );
  }
}
