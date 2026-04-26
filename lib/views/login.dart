import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/logincontroller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

LoginController loginController = Get.put(LoginController());
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80),
              Image.asset('assets/logo.png', height: 200, width: 200),
              SizedBox(height: 10),
              Text("Enter username"),
              SizedBox(height: 10),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Use email or phone number",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Enter password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () => TextField(
                  obscureText: !loginController.isPasswordVisible.value,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Pin or password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        loginController.isPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onTap: () {
                        loginController.togglePassword();
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Obx(
                () => GestureDetector(
                  onTap: loginController.isLoading.value
                      ? null
                      : () {
                          loginController.login(
                            usernameController.text,
                            passwordController.text,
                          );
                        },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: loginController.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Row(
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      child: Text(
                        "Signup",
                        style: TextStyle(color: primaryColor),
                      ),
                      onTap: () {
                        Get.toNamed("/signup");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
