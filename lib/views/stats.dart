import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/habitcontroller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final HabitController habitController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Stats', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Obx(() {
        int total = habitController.habits.length;
        int completed = habitController.completedCount;
        int pending = total - completed;

        return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 20),
              _statCard(
                'Total Habits',
                total.toString(),
                Icons.list,
                Colors.blue,
              ),
              SizedBox(height: 15),
              _statCard(
                'Completed',
                completed.toString(),
                Icons.check_circle,
                Colors.green,
              ),
              SizedBox(height: 15),
              _statCard(
                'Pending',
                pending.toString(),
                Icons.pending,
                Colors.orange,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 36),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: Colors.grey, fontSize: 14)),
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
