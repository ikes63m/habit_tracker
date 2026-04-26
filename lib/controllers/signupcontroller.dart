import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  final String baseUrl = 'http://localhost/flutter_application_1/api';

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signup(String username, String email, String password) async {
    if (username.trim().isEmpty ||
        email.trim().isEmpty ||
        password.trim().isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        Get.snackbar('Success', 'Account created!');
        Get.offAllNamed('/');
      } else {
        Get.snackbar(
          'Signup Failed',
          data['message'] ?? 'Something went wrong',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not connect to server');
    } finally {
      isLoading.value = false;
    }
  }
}
