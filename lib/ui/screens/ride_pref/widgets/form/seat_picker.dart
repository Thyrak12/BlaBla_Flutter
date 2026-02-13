import 'package:flutter/material.dart';
import 'package:blablacar/ui/theme/theme.dart';

class SeatPicker extends StatefulWidget {
  final int initialSeats;

  const SeatPicker({super.key, this.initialSeats = 1});

  @override
  State<SeatPicker> createState() => _SeatPickerState();
}

class _SeatPickerState extends State<SeatPicker> {
  late int seats;

  @override
  void initState() {
    super.initState();
    seats = widget.initialSeats;
  }

  void increment() {
    if (seats < 9) {
      setState(() {
        seats++;
      });
    }
  }

  void decrement() {
    if (seats > 1) {
      setState(() {
        seats--;
      });
    }
  }

  void confirm() {
    Navigator.pop(context, seats);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: confirm,
        backgroundColor: BlaColors.primary,
        child: Icon(Icons.arrow_forward, color: BlaColors.white),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.close, size: 28,),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(height: 30),

            // Title
            Text(
              "Number of seats to book",
              style: BlaTextStyles.heading,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 80),

            // Seat selector row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Minus button
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                    size: 40,
                    color: seats > 1 ? BlaColors.primary : Colors.grey.shade300,
                  ),
                  onPressed: seats > 1 ? decrement : null,
                ),

                const SizedBox(width: 50),
                Text(
                  "$seats",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                    color: BlaColors.primary,
                  ),
                ),

                const SizedBox(width: 50),

                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 40,
                    color: seats < 9 ? BlaColors.primary : Colors.grey.shade300,
                  ),
                  onPressed: seats < 9 ? increment : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
