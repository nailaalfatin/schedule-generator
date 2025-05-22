import 'package:flutter/material.dart';
import 'package:schedule_generator/const.dart';
import 'package:schedule_generator/models/task.dart';
import 'package:schedule_generator/ui/all-task/components/summary_card.dart';
import 'package:schedule_generator/ui/all-task/components/task_card.dart';

class AllTasksScreen extends StatefulWidget {
  final List<Task> tasks;

  const AllTasksScreen({super.key, required this.tasks});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  late List<bool> isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = List<bool>.filled(widget.tasks.length, false);
  }

  void toggleCheck(int index) {
    setState(() {
      isChecked[index] = !isChecked[index];
    });
  }

  final styles = [
    {'bg': const Color(0xFF1F4013), 'border': const Color(0xFF9AE77E)},
    {'bg': const Color(0xFF4B3D04), 'border': const Color(0xFFF5D04B)},
    {'bg': const Color(0xFF441320), 'border': const Color(0xFFFF453A)},
  ];

  @override
  Widget build(BuildContext context) {
    int completedCount = isChecked.where((c) => c).length;
    int pendingCount = widget.tasks.length - completedCount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C1117),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          "All Tasks",
          style: TextStyle(
            color: Colors.white, 
            fontSize: 20, 
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0C1117),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: bgDark,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Text(
                  '"Keep pushing forward, one task at a time."',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Summary kecil task Completed & Pending
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SummaryCard(
                    title: 'Completed',
                    count: completedCount,
                    color: primaryColor,
                    backgroundColor: darkPrimaryColor,
                  ),
                  SummaryCard(
                    title: 'Pending',
                    count: pendingCount,
                    color: primaryColor,
                    backgroundColor: darkPrimaryColor,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: widget.tasks.asMap().entries.map((entry) {
                  final i = entry.key;
                  final t = entry.value;
                  final colors = styles[i % styles.length]!;

                  return TaskCard(
                    task: t,
                    isChecked: isChecked[i],
                    colors: colors,
                    onTapCheck: () => toggleCheck(i),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
