import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/signupcontroller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

SignupController signupController = Get.put(SignupController());
TextEditingController signupUsernameController = TextEditingController();
TextEditingController signupEmailController = TextEditingController();
TextEditingController signupPasswordController = TextEditingController();

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
              Image.asset('assets/logo.png', height: 150, width: 150),
              SizedBox(height: 10),
              Text(
                "Create Account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: signupUsernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Username",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: signupEmailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 15),
              Obx(
                () => TextField(
                  controller: signupPasswordController,
                  obscureText: !signupController.isPasswordVisible.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        signupController.isPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onTap: () => signupController.togglePassword(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Obx(
                () => GestureDetector(
                  onTap: signupController.isLoading.value
                      ? null
                      : () {
                          signupController.signup(
                            signupUsernameController.text,
                            signupEmailController.text,
                            signupPasswordController.text,
                          );
                        },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: signupController.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: Text("Login", style: TextStyle(color: primaryColor)),
                    onTap: () => Get.toNamed("/"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
