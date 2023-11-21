import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kora/model/user.dart';
import 'package:kora/view/admin_screen.dart';
import 'package:kora/view/home_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginWebServices extends GetxController {
  RxList<OwnedClubs> users = RxList<OwnedClubs>();

  @override
  void onInit() {
    updateComment(Comment(id: 123, body: 'mazen'));
    super.onInit();
  }

  // Variable to store the user's role
  final role = ''.obs;

  final isLoading = false.obs;

  Future<void> login(String password, String email) async {
    isLoading.value = true;
    try {
      final uData = {"email": email, "password": password};
      final dio = Dio();
      final response = await dio.post(
        'http://localhost:8000/api/signin',
        data: uData,
      );

      final prefs = await SharedPreferences.getInstance();
      final token = response.data['token'];
      await prefs.setString('token', token);

      // Get the user's role
      final userData = response.data['user'];

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['user']['ownedClubs'];
        final result = data.map((club) => OwnedClubs.fromJson(club)).toList();
        users.value = result;
        if (userData['role'] == 1) {
          Get.offAll(AdminScreen(ownClubs: userData['ownedClubs']));
        } else {
          Get.offAll(HomeScreen());
        }
        // Login successful
      } else {
        isLoading.value = false;
        print('Sign-in failed');
        final responseData = response.data as Map<String, dynamic>;
        final errorMessage = responseData['message'] as String;
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        // Return null or an error code/message
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'An error occurred during sign-in.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black45,
        colorText: Colors.white,
      );
      // Return null or an error code/message
    }
  }

  final Dio _dio = Dio();
  final String apiEndpoint = 'https://gorest.co.in/public/v2/comments';
  Future<bool> updateComment(Comment comment) async {
    try {
      final response = await _dio
          .patch('$apiEndpoint/${comment.id}', data: {'body': comment.body});

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating comment: $e');
    }

    return false;
  }
}


