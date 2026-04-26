import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/habitcontroller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HabitController habitController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('My Habits', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Obx(() {
        if (habitController.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: primaryColor));
        }
        if (habitController.habits.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list_alt, size: 60, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  'No habits yet. Add one!',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: habitController.habits.length,
          itemBuilder: (context, index) {
            final habit = habitController.habits[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: habit['done'] == 1
                    ? Colors.deepPurple.shade50
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: habit['done'] == 1
                      ? primaryColor
                      : Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () =>
                        habitController.toggleHabit(habit['id'], habit['done']),
                    child: Icon(
                      habit['done'] == 1
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: habit['done'] == 1 ? primaryColor : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      habit['name'],
                      style: TextStyle(
                        fontSize: 16,
                        decoration: habit['done'] == 1
                            ? TextDecoration.lineThrough
                            : null,
                        color: habit['done'] == 1 ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => habitController.deleteHabit(habit['id']),
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade300,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
