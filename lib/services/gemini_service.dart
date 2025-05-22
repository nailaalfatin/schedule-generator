import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:schedule_generator/models/task.dart';

class GeminiService {
  // Untuk gerbang komuniaksi awal antara client dan server
  // Client = orang yang nge-consume (kode project kita)/kode project atau aplikasi yang telah di deploy
  // Server = Gemini API
  static const String _baseUrl =  "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";
  
  final String apiKey;

  // Ini adalah sebuah ternary operator untuk memastikan apakan nilai dari API KEY tersedia atau kosong
  GeminiService() : apiKey = dotenv.env["GEMINI_API_KEY"] ?? "" {
    if (apiKey.isEmpty) {
      throw ArgumentError( "Please input your API KEY");
    }
  }
  
  // Logika untuk generating result dari input yang diberikan yang akan diotomasi oleh AI API
  Future<String> generateSchedule(List<Task> tasks) async {
    _validateTasks(tasks);
    // variable yang digunakan untuk menampung prompt request yang akan di eksekusi oleh AI
    final prompt = _buildPrompt(tasks);

    // sebagai percobaan pengiriman request ke AI
    try {
      print("Prompt: \n$prompt");

      // variable yang diguakan untuk menampung response dari request ke API AI
      final response = await http.post(
        // ini adalah starting point untuk penggunaan endpoint dari API
        Uri.parse("$_baseUrl?key=$apiKey"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "contents": [
            {
              "role": "user", // role disini maksudnya adalah seseorang yang memberikan instruksi kepada AI melalui promt
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        })
      );

      return _handleResponse(response);
    } catch (e) {
      throw ArgumentError("Failed to generate schedule: $e");
    }
  }

  String _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);
    /*
      switch adalah salahsatu cabang dari perkondisian yang berisi statement general yang dapat
      dieksekusi oleh berbagai macam action (case yang itu yang ungu ungu), tanpa harus bergantung pada single-statement yang
      dimiliki oleh setiap action yang ada pada parameter "case"
    */
    switch (response.statusCode) { // yang biru" itu statement general
      case 200:
        return data["candidates"][0]["content"]["parts"][0]["text"];
      case 404:
        throw ArgumentError("Server not found");
      case 500:
        throw ArgumentError("Internal server error");
      default:
        throw ArgumentError("Unknown Error: ${response.statusCode}");
    }
  }

  String _buildPrompt(List<Task> tasks) {
    // berfungsi untuk men-setting format tanggal dan waktu lokal (indonesian)
    initializeDateFormatting();
    final dateFormatter = DateFormat("dd MM yyyy 'pukul' hh:mm, 'id_ID'");
    final taskList = tasks.map((task) {
      final formatDeadline = dateFormatter.format(task.deadline);
      return "- ${task.name} (Duration: ${task.duration} minutes, Deadline: $formatDeadline)";    
    });

    //menggunakan framework R-T-A (Role-Task-Action) untuk prompting
    return '''
    Saya adalah seorang siswa, dan saya memiliki daftar sebagai berikut:

    $taskList

    Tolong susun jadwal yang optimal dan efisien berdasarkan daftar tersebut.
    Tolong tentukan prioritasnya berdasarkan *deadline yang paling dekat* dan *durasi tugas*.
    Tolong buat jadwal yang sistematis dari pagi hari, sampai malam hari.
    Tolong pastikan semua tugas dapat selesai sebelum deadline.
    Gunakan **emoji** untuk membedakan header, tapi jangan terlalu banyak menggunakan emoji.
    Tolong buatkan output jadwal dalam format list per jam, misalnya:
    - 08:00-09:00: Melaksanakan piket kamar

    Dan tolong buat dengan format yang rapi dan mudah dibaca untuk gen Z (tidak usah mention ini di output nanti).
    ''';
  }

  void _validateTasks(List<Task> tasks) {
    // ini merupakan bentuk dari single statement dari if-else condition
    if (tasks.isEmpty) throw ArgumentError("Please input your task before generating");  
  }

}