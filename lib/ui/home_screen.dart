import 'package:flutter/material.dart';
import 'package:schedule_generator/models/task.dart';
import 'package:schedule_generator/services/gemini_service.dart';
import 'package:schedule_generator/ui/home-components/generate_button.dart';
import 'package:schedule_generator/ui/home-components/task_input.dart';
import 'package:schedule_generator/ui/home-components/task_list.dart';
import 'package:schedule_generator/ui/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> tasks = [];
  final GeminiService geminiService = GeminiService();
  bool isLoading = false;
  String? generatedResult;

  // code handlng untuk action penambahan/penginputan task
  void addTask(Task task) {
    setState(() => tasks.add(task));
  }

  // code handling untuk action penghapusan task yang sudah di input
  void removeTask(int index) {
    setState(() => tasks.removeAt(index));
  }

  // code handlung untuk melakukan generate schedule berdasarkan input user
  Future<void> generateSchedule() async {
    setState(() => isLoading = true);
    try {
      final result = await geminiService.generateSchedule(tasks);
      generatedResult = result;
      if (context.mounted) _showSuccessDialog();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to generate: $e")),
        );
      }
    }
    setState(() => isLoading = false);
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Congrats!"),
        content: Text("Schedule generated successfully"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => ResultScreen(
                  result: generatedResult ?? "There's no result, please generate another task")
                )
              );
            }, 
            child: Text("View Result")
          )
        ],
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final sectionColor = Colors.grey[100];
    final sectionTitleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Generator"),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: sectionColor,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  Text(
                    "Task Input", 
                    style: sectionTitleStyle
                  ),
                  SizedBox(height: 12),
                  TaskInputSection(onTaskAdded: addTask)
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: sectionColor,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Task List", style: sectionTitleStyle,),
                    SizedBox(height: 12),
                    Expanded(
                      child: TaskList(
                        tasks: tasks, 
                        onRemove: removeTask
                      ),
                    ),
                    SizedBox(height: 20),
                    GenerateButton(
                      isLoading: isLoading,
                      onPressed: generateSchedule
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}