import 'package:flutter/material.dart';
import 'package:schedule_generator/const.dart';

class AddTaskButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool disabled;
  const AddTaskButton({
    super.key,
    required this.onTap,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add, size: 20),
        label: const Text(
          "Add Task",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimaryColor,
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: disabled ? null : onTap,
      ),
    );
  }
}
