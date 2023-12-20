import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/club.dart';

class GetNearClubs extends GetxController {
  RxList<Club> clubs = RxList<Club>();
  RxString mail = "".obs;

  @override
  void onInit() {
    getLocation();
    getUserEmail();
    super.onInit();
  }

  final Dio _dio = Dio();

  Future<List<dynamic>> fetchDataFromApi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double? lat = prefs.getDouble('lat');
      double? long = prefs.getDouble('long');
      var apiUrl =
          'http://31.220.51.27:8081/api/reservations/near-clubs?lat=${lat}&long=${long}&dist=10000';
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
     
        var data = response.data;
        return data;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Failed to fetch data from API: $e');
    }
  }

  Future<void> getclubs() async {
    try {
      final data = await fetchDataFromApi();
      final result = data.map((club) => Club.fromJson(club)).toList();
      clubs.value = result;
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('lat', position.latitude);
      await prefs.setDouble('long', position.longitude);
    } catch (e) {
      print('Error getting location: $e');
    }
  }

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
    await _getCurrentLocation();
    getclubs();
  }

  getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email') ?? '';
    mail.value = email;
  }
}
