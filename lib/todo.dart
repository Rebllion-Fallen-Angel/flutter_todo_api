import 'package:flutter/material.dart';
import 'api.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List todos = [];

  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  void loadTodos() async {
    todos = await ApiService.getTodos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Todos")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: "Title")),
                TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "Description")),
                ElevatedButton(
                  child: const Text("Add Todo"),
                  onPressed: () async {
                    await ApiService.addTodo(
                      title: titleCtrl.text,
                      description: descCtrl.text,
                      date: "2026-01-15",
                      priority: "medium",
                    );
                    titleCtrl.clear();
                    descCtrl.clear();
                    loadTodos();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(todos[i]["title"]),
                subtitle: Text(todos[i]["priority"]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await ApiService.deleteTodo(todos[i]["id"]);
                    loadTodos();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
