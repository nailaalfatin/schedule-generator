import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_generator/const.dart';
import 'package:schedule_generator/controllers/home_controller.dart';
import 'package:schedule_generator/models/task.dart';
import 'package:schedule_generator/ui/all-task/all_tasks_screen.dart';
import 'package:schedule_generator/ui/result/result_screen.dart';

class TaskGrid extends StatelessWidget {
  final HomeController ctrl;
  const TaskGrid({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final tasks = ctrl.visibleTasks;
    final checked = ctrl.isChecked;

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true, // supaya GridView mengikuti konten, tidak infinite height
      physics: const NeverScrollableScrollPhysics(), // non-scrollable
      children: [
        for (var i = 0; i < tasks.length; i++)
          _buildTaskCard(context, i, tasks[i], checked[i]),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AllTasksScreen(
                tasks: tasks,
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: bgDark,
              borderRadius: BorderRadius.circular(16),
              // border: Border.all(color: primaryColor, width: 2)
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_outward, color: primaryColor, size: 30),
                  const SizedBox(height: 6),
                  Text(
                    'View all tasks (${ctrl.tasks.length})',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(
      BuildContext context, int i, Task t, bool isChecked) {
    final styles = [
      {'bg': const Color(0xFF1F4013), 'border': const Color(0xFF9AE77E)},
      {'bg': const Color(0xFF4B3D04), 'border': const Color(0xFFF5D04B)},
      {'bg': const Color(0xFF441320), 'border': const Color(0xFFFF453A)},
    ];
    final colors = styles[i % styles.length]!;

    return GestureDetector(
      onTap: () {
        if (t.scheduleResult != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ResultScreen(result: t.scheduleResult!, taskTitle: t.name),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgDark,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => ctrl.toggleCheck(i),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors['bg'],
                      border: Border.all(color: colors['border']!, width: 3),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: isChecked
                          ? Icon(
                              Icons.check,
                              key: const ValueKey('checked'),
                              size: 30,
                              color: colors['border'],
                            )
                          : Container(
                              key: const ValueKey('unchecked'),
                            ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy').format(t.deadline),
                      style: TextStyle(color: colors['border'], fontSize: 13),
                    ),
                    Text(
                      DateFormat('HH:mm').format(t.deadline),
                      style: TextStyle(color: colors['border'], fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(
              t.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Text(
              'Duration : ${t.duration} minute',
              style: TextStyle(
                color: colors['border'],
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}