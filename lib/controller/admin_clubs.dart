import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kora/model/club.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminClubs extends GetxController {
  RxList<Club> clubs = <Club>[].obs;
  @override
  void onInit() {
    // if (clubs.isEmpty) {
      getClubs();
    super.onInit();
  }

  // void updateItem(
  //     int clubId, int stadIndex, int reservationIndex, String newValue) {
  //   var targetClub = clubs.firstWhere((club) => club.id == clubId);
  //   targetClub.stadiums![0].reservations![reservationIndex].status = newValue;
  //   update(); // This will update the UI
  // }

  final Dio _dio = Dio();

  getClubs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      const apiUrl = 'http://31.220.51.27:8081/api/reservations/admin-clubs';
      final response = await _dio.get(
        apiUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<Club> newClubs =
            data.map((json) => Club.fromJson(json)).toList();
        clubs.assignAll(newClubs);
        return newClubs;
      } else {
        throw Exception('Failed to load clubs');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
