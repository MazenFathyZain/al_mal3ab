import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reservation extends GetxController {
  final Dio dio = Dio();

  Future<void> reserve(
    int? stadiumId,
    String reservationTime,
    playerName,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    const String apiUrl = 'http://31.220.51.27:8081/api/reservations/create';
    try {
      Map<String, dynamic> data = {
        'stadiumId': stadiumId,
        'reservationTime': reservationTime,
        'playerName': playerName,
      };

      var response = await dio.post(
        apiUrl,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Handle the response as needed
      print('Response: ${response.data}');
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }
}
