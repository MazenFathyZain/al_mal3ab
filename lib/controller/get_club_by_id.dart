import 'package:get/get.dart';
import 'package:dio/dio.dart';

class GetClubById extends GetxController {
  final Dio _dio = Dio();

  // Define your Rx variables to hold the club data
  final RxMap club = {}.obs;
  final RxList<dynamic> followers = <dynamic>[].obs;
  

  Future<void> getClubById(int id) async {
    try {
      // Make a GET request to fetch the club by ID
      final response =
          await _dio.get('http://31.220.51.27:8081/api/reservations/clubs/$id');

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Update the club Rx variable with the received data
        club.assignAll(response.data);
        followers.assignAll(response.data['followers']);
      } else {
        // If the request was not successful, handle the error
        print('Failed to get club. Status code: ${response.statusCode}');
        // You can also show a snackbar or alert to inform the user about the error
      }
    } catch (error) {
      // Handle Dio errors or other exceptions
      print('Error getting club: $error');
      // You can also show a snackbar or alert to inform the user about the error
    }
  }
}
