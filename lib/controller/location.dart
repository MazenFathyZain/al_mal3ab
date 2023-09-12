import 'package:geolocator/geolocator.dart';

class Location {
  Position? cl;

  Future getLocation() async {
    bool servicees;
    LocationPermission permission;
    servicees = await Geolocator.isLocationServiceEnabled();

    if (servicees == false) {}
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission != LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    getLatAndLong();
  }

  Future<Position> getLatAndLong() async {
    return await Geolocator.getCurrentPosition();
  }
}
