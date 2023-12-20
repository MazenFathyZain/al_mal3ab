import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/club.dart';

class GetAllClubs extends GetxController {
  RxList<Club> clubs = RxList<Club>();
  RxList<Club> searchResults = <Club>[].obs;

  @override
  void onInit() {
    getclubs();
    super.onInit();
  }

  final Dio _dio = Dio();

  Future<List<dynamic>> fetchDataFromApi() async {
    try {
      const apiUrl = 'http://31.220.51.27:8081/api/reservations/clubs';
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

  // Search clubs by name
  void searchClubsByName(String query) {
    searchResults.assignAll(clubs
        .where((club) => club.name!.toLowerCase().contains(query.toLowerCase()))
        .toList());
  }
}
