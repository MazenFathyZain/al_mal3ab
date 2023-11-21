import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/club.dart';

class ClubWebServices extends GetxController {
  RxList<Club> clubs = RxList<Club>();

  @override
  void onInit() {
    getclubs();
    super.onInit();
  }

  final Dio _dio = Dio();

  Future<List<dynamic>> fetchDataFromApi() async {
    try {
      // const apiUrl = 'https://kora-api.onrender.com/api/user/near-clubs';
      const apiUrl = 'http://localhost:8000/api/user/near-clubs';
      final response = await _dio.post(apiUrl);
      if (response.statusCode == 200) {
        var data = response.data["result"];
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
}