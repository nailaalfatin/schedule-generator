import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final Color backgroundColor;

  const SummaryCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    this.backgroundColor = const Color(0xFF1A1A1A),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 6),
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: count),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Text(
                '$value',
                style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold),
              );
            },
          ),
        ],
      ),
    );
  }
}
