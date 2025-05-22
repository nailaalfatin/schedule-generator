import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_generator/controllers/home_controller.dart';
import 'package:schedule_generator/ui/home/components/add_task_button.dart';
import 'package:schedule_generator/ui/home/components/gemini_card.dart';
import 'package:schedule_generator/ui/home/components/header.dart';
import 'package:schedule_generator/ui/home/components/loading_overlay.dart';
import 'package:schedule_generator/ui/home/components/progress_section.dart';
import 'package:schedule_generator/ui/home/components/task_grid.dart';
import 'package:schedule_generator/ui/home/components/task_input.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: Consumer<HomeController>(
        builder: (_, ctrl, __) {
          return Scaffold(
            backgroundColor: const Color(0xFF0C1117),
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(  // Ini yang diganti
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Header(),
                          const SizedBox(height: 30),
                          GeminiCard(isLoading: ctrl.isLoading),
                          const SizedBox(height: 40),
                          ProgressSection(
                            completed: ctrl.completedCount,
                            progress: ctrl.progress,
                            total: ctrl.tasks.length,
                          ),
                          const SizedBox(height: 35),
                          const Text(
                            'Your Tasks :',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TaskGrid(ctrl: ctrl),  // langsung tanpa Expanded
                          const SizedBox(height: 80), // space supaya floating button tidak nabrak
                        ],
                      ),
                    ),
                  ),
                  if (ctrl.isLoading) const LoadingOverlay(),
                ],
              ),
            ),
            floatingActionButton: AddTaskButton(
              disabled: ctrl.isLoading,
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (ctx) => Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(16),
                    child: TaskInputSection(
                      onTaskAdded: ctrl.addTask,
                      onGenerate: () {
                        Navigator.of(ctx).pop();
                        ctrl.generateSchedule(context);
                      },
                    ),
                  ),
                );
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        },
      ),
    );
  }
}
