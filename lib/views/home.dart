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

  Widget _habitImage(String habitName) {
    Map<String, String> images = {
      'exercise': 'assets/exercise.png',
      'workout': 'assets/exercise.png',
      'gym': 'assets/exercise.png',
      'water': 'assets/water.png',
      'drink': 'assets/water.png',
      'sleep': 'assets/sleep.png',
      'rest': 'assets/sleep.png',
      'read': 'assets/read.png',
      'book': 'assets/read.png',
      'meditat': 'assets/meditate.png',
      'walk': 'assets/walking.png',
      'run': 'assets/walking.png',
      'eat': 'assets/eat.png',
      'food': 'assets/eat.png',
      'study': 'assets/studying.png',
      'learn': 'assets/studying.png',
    };

    String name = habitName.toLowerCase();
    String? imagePath;

    for (var entry in images.entries) {
      if (name.contains(entry.key)) {
        imagePath = entry.value;
        break;
      }
    }

    if (imagePath != null) {
      return Image.asset(
        imagePath,
        height: 48,
        width: 48,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.self_improvement, color: primaryColor, size: 40),
      );
    }
    return Icon(Icons.self_improvement, color: primaryColor, size: 40);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'My Habits',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Obx(() {
        int total = habitController.habits.length;
        int completed = habitController.completedCount;

        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    total == 0
                        ? 'No habits yet'
                        : '$completed of $total completed today',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  if (total > 0)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: completed / total,
                        minHeight: 6,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: habitController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                  : habitController.habits.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list_alt,
                            size: 70,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(height: 14),
                          Text(
                            'No habits yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Tap + to add your first habit',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                      itemCount: habitController.habits.length,
                      itemBuilder: (context, index) {
                        final habit = habitController.habits[index];
                        final isDone = habit['done'] == 1;
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDone
                                  ? primaryColor.withOpacity(0.4)
                                  : Colors.grey.shade200,
                              width: isDone ? 1.5 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isDone
                                        ? primaryColor.withOpacity(0.08)
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: _habitImage(habit['name']),
                                ),
                                SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        habit['name'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          decoration: isDone
                                              ? TextDecoration.lineThrough
                                              : null,
                                          color: isDone
                                              ? Colors.grey
                                              : Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        isDone
                                            ? 'Completed ✓'
                                            : 'Tap to complete',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isDone
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => habitController.toggleHabit(
                                    habit['id'],
                                    habit['done'],
                                  ),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: isDone
                                          ? primaryColor
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isDone
                                            ? primaryColor
                                            : Colors.grey.shade400,
                                        width: 2,
                                      ),
                                    ),
                                    child: isDone
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 18,
                                          )
                                        : null,
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () =>
                                      habitController.deleteHabit(habit['id']),
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Colors.red.shade300,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}
