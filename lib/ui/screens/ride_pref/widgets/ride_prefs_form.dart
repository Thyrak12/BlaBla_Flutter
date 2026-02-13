import 'package:blablacar/data/dummy_data.dart';
import 'package:blablacar/ui/screens/ride_pref/widgets/form/location_search.dart';
import 'package:blablacar/ui/screens/ride_pref/widgets/form/seat_picker.dart';
import 'package:blablacar/ui/widgets/actions/bla_button.dart';
import 'package:blablacar/ui/widgets/actions/bla_input.dart';
import 'package:blablacar/ui/widgets/display/bla_divider.dart';
import 'package:blablacar/ui/widgets/display/ride_result.dart';
import 'package:blablacar/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void onLocationSwap() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
      print('Swapp');
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Leaving from
        BlaInput(
          icon: Icons.circle_outlined,
          text: departure?.name ?? "Leaving from",
          onTap: () async {
            final selected = await Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) => const LocationSearch()),
            );

            if (selected != null) {
              setState(() {
                departure = selected;
              });
            }
          },
          trailing: IconButton(
            onPressed: onLocationSwap,
            icon: const Icon(Icons.swap_vert, color: Colors.lightBlue),
          ),
        ),

        BlaDivider(),

        // Going to
        BlaInput(
          icon: Icons.circle_outlined,
          text: arrival?.name ?? "Going to",
          onTap: () async {
            final selected = await Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) => const LocationSearch()),
            );

            if (selected != null) {
              setState(() {
                arrival = selected;
              });
            }
          },
        ),

        BlaDivider(),

        // Date picker
        BlaInput(
          icon: Icons.calendar_month_outlined,
          text: DateTimeUtils.formatDateTime(departureDate),
          onTap: () {},
        ),

        BlaDivider(),

        // Seats picker
        BlaInput(
          icon: Icons.person_outline,
          text: "$requestedSeats",
          onTap: () async {
            final selected = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeatPicker(initialSeats: requestedSeats),
              ),
            );
            if (selected != null) {
              setState(() {
                requestedSeats = selected;
              });
            }
          },
        ),

        const SizedBox(height: 16),

        // Search button
        BlaButton(
          title: "Search",
          bgColor: Colors.lightBlueAccent,
          icon: Icons.search,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RidePrefResultCard(
                  departure: departure!,
                  arrival: arrival!,
                  date: departureDate,
                  requestedSeats: requestedSeats,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
