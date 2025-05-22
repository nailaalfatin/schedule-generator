import 'package:flutter/material.dart';
import 'package:schedule_generator/const.dart';

class ProgressSection extends StatelessWidget {
  final int completed;
  final double progress;
  final int total;

  const ProgressSection({
    super.key,
    required this.completed,
    required this.progress,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 14),
      decoration: BoxDecoration(
        color: bgDark,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Task Progress :',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                '$completed/$total',
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Animated Progress
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progress),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: Colors.grey.shade800, // Background beda warna
                valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
