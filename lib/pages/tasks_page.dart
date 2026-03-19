import 'package:flutter/material.dart';
import '../widgets/task_card.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar tarefa...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                TaskCard(title: "Matemática", description: "Capítulo 2", done: false),
                TaskCard(title: "História", description: "Revisão", done: true),
              ],
            ),
          )
        ],
      ),
    );
  }
}
