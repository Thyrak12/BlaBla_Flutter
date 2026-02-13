import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';
import 'package:blablacar/ui/theme/theme.dart';

class RidePrefResultCard extends StatelessWidget {
  final Location departure;
  final Location arrival;
  final DateTime date;
  final int requestedSeats;

  const RidePrefResultCard({
    super.key,
    required this.departure,
    required this.arrival,
    required this.date,
    required this.requestedSeats,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),

        const SizedBox(width: 8),
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text("Ride Preferences", style: BlaTextStyles.body),

                const SizedBox(height: 12),

                // Departure
                Text("From: ${departure.name}", style: BlaTextStyles.body),

                const SizedBox(height: 8),

                // Arrival
                Text("To: ${arrival.name}", style: BlaTextStyles.body),

                const SizedBox(height: 8),

                // Time
                Text("Time: ${date}", style: BlaTextStyles.body),

                const SizedBox(height: 8),

                // Seats
                Text(
                  "Seats Requested: ${requestedSeats}",
                  style: BlaTextStyles.body,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
