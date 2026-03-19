import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: const [
            StatCard(title: "Tempo estudado", value: "5h"),
            StatCard(title: "Tarefas concluídas", value: "12"),
          ],
        ),
      ),
    );
  }
}
