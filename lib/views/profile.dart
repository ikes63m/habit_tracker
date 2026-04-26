import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/logincontroller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              CircleAvatar(
                radius: 50,
                backgroundColor: primaryColor.withOpacity(0.15),
                child: Text(
                  loginController.loggedInUsername.value.isNotEmpty
                      ? loginController.loggedInUsername.value[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                loginController.loggedInUsername.value,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                loginController.loggedInEmail.value,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () => loginController.logout(),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
