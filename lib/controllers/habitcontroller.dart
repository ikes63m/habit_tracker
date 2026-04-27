import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HabitController extends GetxController {
  var currentIndex = 0.obs;
  var habits = [].obs;
  var isLoading = false.obs;
  var streak = 0.obs;

  final String baseUrl = 'http://localhost/flutter_application_1/api';

  @override
  void onInit() {
    super.onInit();
    fetchHabits();
  }

  Future<void> fetchHabits() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_habits.php'));
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        habits.value = List<Map>.from(
          data['habits'].map(
            (h) => {
              'id': int.parse(h['id'].toString()),
              'name': h['name'].toString(),
              'done': int.parse(h['done'].toString()),
            },
          ),
        );
        _updateStreak();
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not load habits');
    } finally {
      isLoading.value = false;
    }
  }

  void _updateStreak() {
    if (completedCount > 0) {
      streak.value = streak.value + 1;
    }
  }

  Future<void> addHabit(String name) async {
    if (name.trim().isEmpty) {
      Get.snackbar('Error', 'Habit name cannot be empty');
      return;
    }
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add_habit.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name.trim()}),
      );
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        fetchHabits();
        Get.snackbar('Success', 'Habit added!');
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not add habit');
    }
  }

  Future<void> toggleHabit(int id, int currentStatus) async {
    int newStatus = currentStatus == 1 ? 0 : 1;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/toggle_habit.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id, 'done': newStatus}),
      );
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        fetchHabits();
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not update habit');
    }
  }

  Future<void> deleteHabit(int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/delete_habit.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        fetchHabits();
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not delete habit');
    }
  }

  int get completedCount => habits.where((h) => h['done'] == 1).length;
  int get totalCount => habits.length;
  int get currentStreak => streak.value;
  double get consistencyRatio =>
      totalCount == 0 ? 0.0 : completedCount / totalCount;
  double get powerScore => currentStreak * consistencyRatio;
}
