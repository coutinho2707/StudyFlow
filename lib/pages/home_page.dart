import 'package:flutter/material.dart';
import '../widgets/progress_card.dart';
import '../widgets/task_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StudyFlow")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Olá, Gabriel!", style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            ProgressCard(progress: 0.6),
            SizedBox(height: 16),
            Text("Próximas tarefas"),
            TaskCard(title: "Estudar Flutter", description: "UI básica", done: false),
          ],
        ),
      ),
    );
  }
}
