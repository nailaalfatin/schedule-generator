/* 
  File yang ada di dalam folder model, biasanya disebut dengan Data Class.
  
  Biasanya Data Class di presentasikan dengan bundling, dengan mengimport
  library Parcelize(Android Native)
*/
class Task {
  final String name;
  final int duration;
  final DateTime deadline;

  Task({required this.name, required this.duration, required this.deadline});

  // override itu untuk membentuk suatu turunan dari sebuah object
  // salah satu contohnya adalah adanya function didalam funciton
  @override
  String toString() {
    return "Task{name: $name, duration: $duration, deadline: $deadline}";
  }

}