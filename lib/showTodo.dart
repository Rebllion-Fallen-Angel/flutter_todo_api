import 'package:flutter/material.dart';
import 'todo.dart';

class ShowTodoScreen extends StatefulWidget {
  final Map todo;
  const ShowTodoScreen({super.key, required this.todo});

  @override
  State<ShowTodoScreen> createState() => _ShowTodoScreenState();
}

class _ShowTodoScreenState extends State<ShowTodoScreen> {

    @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title: ${widget.todo['title']}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Description: ${widget.todo['description']}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text("Date: ${widget.todo['date']}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(
              "Priority: ${widget.todo['priority']}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TodoScreen()),
          );
        },
      ),
    );
  }
}
