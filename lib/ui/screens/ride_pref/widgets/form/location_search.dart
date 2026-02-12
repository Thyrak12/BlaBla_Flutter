import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/ui/widgets/actions/location_tile.dart';
import 'package:blablacar/ui/widgets/actions/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:blablacar/data/dummy_data.dart';
import 'package:blablacar/ui/theme/theme.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({super.key});

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  String query = "";
  final TextEditingController _controller = TextEditingController();

  // Filter locations based on search query
  List<Location> get filteredLocations {
    if (query.isEmpty) return fakeLocations;

    return fakeLocations
        .where((loc) => loc.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void onChanged(String value) {
    setState(() {
      query = value;
    });
  }

  void onClear() {
    setState(() {
      query = "";
      _controller.clear();
    });
  }

  // -------------------------------
  // Widgets
  // -------------------------------

  Widget _buildLocationsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredLocations.length,
        itemBuilder: (ctx, index) => LocationTile(
          location: filteredLocations[index],
          onTap: () => Navigator.pop(context, filteredLocations[index]),
        ),
      ),
    );
  }

  // -------------------------------
  // Main Build
  // -------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  ),

                  const SizedBox(width: 8),

                  LocationSearchBar(
                    controller: _controller,
                    query: query,
                    onChanged: onChanged,
                    onClear: onClear,
                  ),
                ],
              ),
            ),

            // Locations List
            _buildLocationsList(),
          ],
        ),
      ),
    );
  }
}
