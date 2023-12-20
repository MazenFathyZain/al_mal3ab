import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kora/view/admin_screens/admin_screen.dart';
import 'package:kora/view/home_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthServices extends GetxController {
  final isLoading = false.obs;
  RxString mail = "".obs;

  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email') ?? '';
    mail.value = email;
    super.onInit();
  }

  Future<void> login(String password, String email) async {
    isLoading.value = true;
    try {
      final uData = {"email": email, "password": password};
      final dio = Dio();
      final response = await dio.post(
        'http://31.220.51.27:8081/api/v1/auth/authenticate',
        data: uData,
      );

      final prefs = await SharedPreferences.getInstance();
      // Save token
      final token = response.data['token'];
      await prefs.setString('token', token);
      // Save role
      final role = response.data['role'];
      await prefs.setString('role', role);
      // Save user email
      final userEmail = response.data['email'];
      await prefs.setString('email', userEmail);

      if (response.statusCode == 200) {
        isLoading.value = false;
        String? email = prefs.getString('email') ?? '';
        mail.value = email;
        Get.offAll(role == 'ADMIN' ? AdminScreen() : HomeScreen());
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
        backgroundColor: Colors.red[600],
        colorText: Colors.white,
      );
      // Return null or an error code/message
    }
  }

  Future<void> signUp(
      String firstName, String lastName, String email, String password) async {
    isLoading.value = true;
    try {
      final uData = {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
      };
      final dio = Dio();
      final response = await dio.post(
        'http://31.220.51.27:8081/api/v1/auth/register',
        data: uData,
      );

      if (response.statusCode == 200) {
        login(password, email);
        isLoading.value = false;
        Get.offAll(HomeScreen());
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
}
