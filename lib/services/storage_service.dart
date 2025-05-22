import 'package:shared_preferences/shared_preferences.dart';
import 'package:schedule_generator/models/task.dart';

class StorageService {
  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < tasks.length; i++) {
      final key = 'schedule_${tasks[i].name}_$i';
      final res = tasks[i].scheduleResult;
      if (res != null) await prefs.setString(key, res);
    }
  }

  Future<void> loadTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < tasks.length; i++) {
      final key = 'schedule_${tasks[i].name}_$i';
      final saved = prefs.getString(key);
      if (saved != null) tasks[i].scheduleResult = saved;
    }
  }
}
