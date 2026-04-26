import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  var loggedInUsername = ''.obs;
  var loggedInEmail = ''.obs;
  var loggedInId = 0.obs;

  final String baseUrl = 'http://localhost/flutter_application_1/api';

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login(String username, String password) async {
    if (username.trim().isEmpty || password.trim().isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        loggedInUsername.value = data['user']['username'];
        loggedInEmail.value = data['user']['email'];
        loggedInId.value = data['user']['id'];
        Get.offAllNamed('/mainscreen');
      } else {
        Get.snackbar('Login Failed', data['message'] ?? 'Invalid credentials');
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not connect to server');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    loggedInUsername.value = '';
    loggedInEmail.value = '';
    loggedInId.value = 0;
    Get.offAllNamed('/');
  }
}
