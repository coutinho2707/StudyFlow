import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfil")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: const [
            CircleAvatar(radius: 40),
            SizedBox(height: 10),
            Text("Gabriel Couto"),
            SizedBox(height: 20),
            StatCard(title: "Horas de estudo", value: "20h"),
            StatCard(title: "Matérias", value: "5"),
          ],
        ),
      ),
    );
  }
}
