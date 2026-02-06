import 'package:blablacar/model/ride/ride.dart';

import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/services/rides_service.dart';

void main() {
  Location dijon = Location(country: Country.france, name: "Dijon");

  List<Ride> filteredRide = RidesService.filterBy(seatRequested: 2, departure: dijon);

  for (Ride ride in filteredRide) {
    print(ride);
  }
}
