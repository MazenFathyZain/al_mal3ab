import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteReservation extends GetxController {
  final Dio dio = Dio();

  Future<void> deleteReservation(
    int? reservationId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String apiUrl = 'http://31.220.51.27:8081/api/reservations/$reservationId';
    try {
      var response = await dio.delete(
        apiUrl,
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
