import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/habitcontroller.dart';
import 'package:get/get.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final HabitController habitController = Get.find();
  final TextEditingController customController = TextEditingController();

  String? selectedHabit;

  final List<Map<String, String>> presetHabits = [
    {'name': 'Eat Healthy', 'image': 'assets/eat.png'},
    {'name': 'Exercise', 'image': 'assets/exercise.png'},
    {'name': 'Meditate', 'image': 'assets/meditate.png'},
    {'name': 'Read a Book', 'image': 'assets/read.png'},
    {'name': 'Sleep Early', 'image': 'assets/sleep.png'},
    {'name': 'Study', 'image': 'assets/studying.png'},
    {'name': 'Go for a Walk', 'image': 'assets/walking.png'},
    {'name': 'Drink Water', 'image': 'assets/water.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Add Habit',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _presetGrid(),
            _customSection(),
            _addButton(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What habit do you want',
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          Text(
            'to build today?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Pick from the list or create your own',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _presetGrid() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: presetHabits.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          final habit = presetHabits[index];
          final isSelected = selectedHabit == habit['name'];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedHabit = habit['name'];
                customController.clear();
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withOpacity(0.08)
                    : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.grey.shade200,
                  width: isSelected ? 2.5 : 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? primaryColor.withOpacity(0.15)
                        : Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    habit['image']!,
                    height: 70,
                    width: 70,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 50,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    habit['name']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? primaryColor : Colors.black87,
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  if (isSelected)
                    Icon(Icons.check_circle, color: primaryColor, size: 16)
                  else
                    SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _customSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 28, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'or type your own',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey.shade300)),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            controller: customController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() => selectedHabit = null);
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'e.g. Journaling, Cold shower...',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              prefixIcon: Icon(Icons.edit_note, color: primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: GestureDetector(
        onTap: () async {
          final name = customController.text.trim().isNotEmpty
              ? customController.text.trim()
              : selectedHabit ?? '';
          if (name.isEmpty) {
            Get.snackbar(
              'Nothing selected',
              'Please pick a habit or type your own',
              backgroundColor: Colors.red.shade100,
              colorText: Colors.red.shade800,
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }
          await habitController.addHabit(name);
          customController.clear();
          setState(() => selectedHabit = null);
          habitController.currentIndex.value = 0;
        },
        child: Container(
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.4),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Add Habit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
