import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/habitcontroller.dart';
import 'package:flutter_application_1/views/home.dart';
import 'package:flutter_application_1/views/addhabit.dart';
import 'package:flutter_application_1/views/stats.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

HabitController habitController = Get.put(HabitController());

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    AddHabitScreen(),
    StatsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: backgroundColor,
        body: screens[habitController.currentIndex.value],
        bottomNavigationBar: CurvedNavigationBar(
          index: habitController.currentIndex.value,
          backgroundColor: backgroundColor,
          color: primaryColor,
          buttonBackgroundColor: secondaryColor,
          height: 60,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) => habitController.currentIndex.value = index,
          items: [
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.add, color: Colors.white),
            Icon(Icons.bar_chart, color: Colors.white),
            Icon(Icons.person, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
