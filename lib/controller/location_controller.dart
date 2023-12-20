import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationController extends GetxController {
  // Your other controller code...

  // Method to open Google Maps with the club's location
  Future<void> openGoogleMaps(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    await canLaunchUrlString(url) ? await launchUrlString(url) : throw 'ERROR';
  }

  void launchMap() async {
    const mapUrl = 'geo:37.7749,-122.4194';

    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Could not launch $mapUrl';
    }
  }
}








// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocationController extends GetxController {
//   var latitude = 0.0.obs;
//   var longitude = 0.0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     getLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       latitude.value = position.latitude;
//       longitude.value = position.longitude;

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setDouble('lat', position.latitude);
//       await prefs.setDouble('long', position.longitude);
//     } catch (e) {
//       print('Error getting location: $e');
//     }
//   }

//   Future getLocation() async {
//     bool servicees;
//     LocationPermission permission;
//     servicees = await Geolocator.isLocationServiceEnabled();

//     if (servicees == false) {}
//     permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     if (permission != LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     _getCurrentLocation();
//   }
// }
