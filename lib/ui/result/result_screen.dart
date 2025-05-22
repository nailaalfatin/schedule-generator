import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ResultScreen extends StatelessWidget {
  final String result;
  final String taskTitle;

  const ResultScreen({
    super.key,
    required this.result,
    required this.taskTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1117),
      appBar: AppBar(
        title: const Text(
          "Generated Schedule",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
        backgroundColor: const Color(0xFF0C1117),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " 📌  $taskTitle",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              MarkdownBody(
                data: result,
                selectable: true,
                styleSheet: MarkdownStyleSheet(
                  p: const TextStyle(fontSize: 15, height: 1.6, color: Colors.white),
                  h1: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  h2: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                  h3: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  listBullet: const TextStyle(fontSize: 15, color: Colors.white),
                  blockquote: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white70,
                    backgroundColor: Colors.white10,
                  ),
                  code: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 14,
                    backgroundColor: Colors.grey[900],
                    color: Colors.greenAccent,
                  ),
                  listIndent: 24,
                  blockSpacing: 16,
                  horizontalRuleDecoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey.shade700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
