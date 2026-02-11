import 'package:blablacar/model/ride/locations.dart';
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

  // -------------------------------
  // Widgets
  // -------------------------------

  Widget _buildSearchBar() {
    return Expanded(
      child: TextField(
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Search location...",
          prefixIcon: Icon(Icons.search, color: BlaColors.iconLight),

          filled: true,
          fillColor: Colors.grey.shade100,

          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          suffixIcon: query.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _controller.clear();
                    setState(() {
                      query = "";
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          setState(() {
            query = value;
          });
        },
      ),
    );
  }

  Widget _buildLocationTile(Location location) {
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

      onTap: () {
        Navigator.pop(context, location);
      },
    );
  }

  Widget _buildLocationsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredLocations.length,
        itemBuilder: (ctx, index) =>
            _buildLocationTile(filteredLocations[index]),
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
            // Top Bar
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  ),

                  const SizedBox(width: 8),

                  _buildSearchBar(),
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
