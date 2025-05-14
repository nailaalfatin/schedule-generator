import 'package:flutter/material.dart';
import 'package:schedule_generator/models/task.dart';


//IMPORTANT : untuk mendefinisikan sebuah variable yang bersifat public ataupun privat ,
//wajib untuk di deslripsikan di dalam blok kode.
// ini bersifat publik
class TaskInputSection extends StatefulWidget {
  final void Function(Task) onTaskAdded;

  const TaskInputSection({super.key, required this.onTaskAdded});

  @override
  State<TaskInputSection> createState() => _TaskInputSectionState();
}
//ini bersifat privat
class _TaskInputSectionState extends State<TaskInputSection> {
  final taskController = TextEditingController();
  final durationController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void _addTask() {
    // perkondisian apabila seluruh/beberapa input area masih kosong 
    if (taskController.text.isEmpty || 
        durationController.text.isEmpty ||
        selectedDate == null ||
        // keyword return untuk memberitahukan mau apapun hasilnya yang penting ada salah satu value yang true deh, kalau isi satu maka masih bisa mereturn hasil dan ya ga mandatory
        selectedTime == null) return; 

    // kalau semua sudah terisi maka akan diarahkan ke halaman berikutnya
    final deadline = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    widget.onTaskAdded(Task(
      name: taskController.text,
      duration: int.tryParse(durationController.text) ?? 5,
      deadline: deadline
    ));
    //statement ini akan di jalankan ketika satu buah task lengkap sudah berhasil dibuat
    //dan di masukkan ke dalam container list tasks
    taskController.clear();
    durationController.clear();
    setState(() {
      selectedDate = null;
      selectedTime = null;
    });
  }

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030)
    );
    if (date != null) setState(() => selectedDate = date);
  }

  void _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
    );
    if (time != null) setState(() => selectedTime = time);
  }
  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Task',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Duration (minutes)"),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickDate, 
                    child: Text( selectedDate == null
                    ? "Pick Date"
                    : "${selectedDate!.toLocal()}".split(' ')[0]
                    )
                    )
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _pickTime, 
                      child: Text( selectedTime == null
                      ? "Pick Time"
                      : selectedTime!.format(context)
                      )
                      )
                    )
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTask, 
              child: Text("Add Task")
              )
          ],
        ),
        ),
    );
  }
}