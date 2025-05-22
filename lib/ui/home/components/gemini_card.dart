import 'package:flutter/material.dart';
import 'package:schedule_generator/const.dart';

class GeminiCard extends StatelessWidget {
  final bool isLoading;
  const GeminiCard({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main Card
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          decoration: BoxDecoration(
            color: darkPrimaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: primaryColor,
              width: 1.5,
            ),
          ),
          child: Text(
            "Just add your tasks, free time, and deadlines — Gemini AI will help build a schedule so you can get everything done right on time.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),

        // Gemini Badge - Nempel di tengah garis
        Positioned(
          bottom: -18,
          right: 20,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 11),
            decoration: BoxDecoration(
              color: darkPrimaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: primaryColor,
                width: 1.2,
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/logos/gemini-logo.png',
                height: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
