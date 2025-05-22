import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_generator/const.dart';
import 'package:schedule_generator/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final bool isChecked;
  final Map<String, Color> colors;
  final VoidCallback onTapCheck;

  const TaskCard({
    super.key,
    required this.task,
    required this.isChecked,
    required this.colors,
    required this.onTapCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgDark, // bgDark, sesuaikan jika beda
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
                onTap: onTapCheck,
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
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: isChecked
                    ? Icon(
                        Icons.check,
                        key: const ValueKey('checked'),
                        size: 30,
                        color: colors['border'],
                      )
                    : Container(key: const ValueKey('unchecked')),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy').format(task.deadline),
                    style: TextStyle(color: colors['border'], fontSize: 13),
                  ),
                  Text(
                    DateFormat('HH:mm').format(task.deadline),
                    style: TextStyle(color: colors['border'], fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            task.name,
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
            'Duration : ${task.duration} minute',
            style: TextStyle(
              color: colors['border'],
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
