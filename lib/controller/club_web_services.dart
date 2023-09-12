import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../constants.dart';
import '../model/club.dart';

class ClubWebServices extends GetxController {
  late Dio dio;
  RxList<dynamic> dataList = <dynamic>[].obs;

  ClubWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<void> getAllClubs() async {
    try {
      Response response = await dio.get('user/near-clubs');
      var data = response.data;

      List<Club> club = await data.map((club) => Club.fromJson(club)).toList();
      dataList.value = club;
      print(data);
    } catch (e) {
      print(e.toString());
    }
  }
}
