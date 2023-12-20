import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Follow extends GetxController {
  final Dio dio = Dio();

  Future<void> follow(int? stadiumId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String apiUrl = 'http://31.220.51.27:8081/api/user-club/follow?clubId=$stadiumId';
    try {
      var response = await dio.post(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      // final prefs = await SharedPreferences.getInstance();

      // await prefs.setString('token', token);

      // Handle the response as needed
      print('Response: ${response.data}');
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }
    
    Future<void> unFollow(int? stadiumId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String apiUrl = 'http://31.220.51.27:8081/api/user-club/unfollow?clubId=$stadiumId';
    try {
      var response = await dio.delete(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      // final prefs = await SharedPreferences.getInstance();

      // await prefs.setString('token', token);

      // Handle the response as needed
      print('Response: ${response.data}');
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

}
