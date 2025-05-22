import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:schedule_generator/models/task.dart';
import 'package:schedule_generator/services/gemini_service.dart';
import 'package:schedule_generator/services/storage_service.dart';
import 'package:schedule_generator/ui/result/result_screen.dart';

class HomeController extends ChangeNotifier {
  final GeminiService _gemini = GeminiService();
  final StorageService _storage = StorageService();

  final List<Task> tasks = [];
  final List<bool> isChecked = [];
  bool isLoading = false;

  int get completedCount => isChecked.where((c) => c).length;

  double get progress {
    if (tasks.isEmpty) return 0;
    return (completedCount / tasks.length).clamp(0.0, 1.0);
  }

  List<Task> get visibleTasks =>
      tasks.length > 3 ? tasks.sublist(0, 3) : tasks;

  HomeController() {
    loadSavedResults();
  }

  void addTask(Task task) {
    tasks.add(task);
    isChecked.add(false);
    notifyListeners();
  }

  void toggleCheck(int i) {
    isChecked[i] = !isChecked[i];
    notifyListeners();
  }

  Future<void> generateSchedule(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _gemini.generateSchedule(tasks);

      for (var t in tasks) {
        t.scheduleResult = result;
      }

      await _storage.saveTasks(tasks);

      // TAMPILKAN SNACKBAR SUCCESS
      showSuccessBanner(context, tasks);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed: $e')));
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveResults() => _storage.saveTasks(tasks);
  Future<void> loadSavedResults() async {
    await _storage.loadTasks(tasks);
    notifyListeners();
  }

  void showSuccessBanner(BuildContext context, List<Task> tasks) {
    if (tasks.isEmpty) return;
    final last = tasks.last;

    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: const Color(0xFF1E1E2C),
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      icon: const Icon(Icons.check_circle, color: Color(0xFF4CA1F8)),
      messageText: const Text(
        'Schedule generated successfully!',
        style: TextStyle(color: Colors.white),
      ),
      mainButton: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ResultScreen(
                result: last.scheduleResult ?? '',
                taskTitle: last.name,
              ),
            ),
          );
        },
        child: const Text(
          'View',
          style: TextStyle(
            color: Color(0xFF4CA1F8),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
