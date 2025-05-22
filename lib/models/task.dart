class Task {
  final String name;
  final int duration;
  final DateTime deadline;
  String? scheduleResult; // untuk menyimpan hasil generate

  Task({
    required this.name,
    required this.duration,
    required this.deadline,
    this.scheduleResult,
  });

  @override
  String toString() {
    return "Task{name: $name, duration: $duration, deadline: $deadline, scheduleResult: $scheduleResult}";
  }
}