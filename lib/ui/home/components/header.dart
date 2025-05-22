import 'package:flutter/material.dart';
import 'package:schedule_generator/const.dart';

class Header extends StatelessWidget {
  const Header({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFF4CA1F8), // contoh bg, bisa pakai darkPrimaryColor juga
          child: ClipOval(
            child: Image.asset(
              'assets/images/avatar.png',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hai, Ramma 👋🏻',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Let's be productive!",
              style: TextStyle(
                color: primaryColor, 
                fontSize: 15,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ],
    );
  }
}
