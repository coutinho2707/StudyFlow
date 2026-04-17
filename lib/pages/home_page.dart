import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../database/database_helper.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadTasks(); // 🔥 atualiza quando volta pra tela
  }

  void loadTasks() async {
    final data = await DatabaseHelper.instance.getTasks();
    setState(() {
      tasks = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    int total = tasks.length;
    int done = tasks.where((t) => t.done).length;
    int pending = tasks.where((t) => !t.done).length;

    double progress = total == 0 ? 0 : done / total;

    final nextTasks =
    tasks.where((t) => !t.done).take(3).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 👋 HEADER
              const Text(
                "Olá, Gabriel",
                style: TextStyle(
                  fontSize: 24,
                  color: AppTheme.textPrimary,
                ),
              ),

              const SizedBox(height: 20),

              /// 📊 PROGRESSO
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Progresso de estudos",
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                    const SizedBox(height: 10),

                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "${(progress * 100).toInt()}%",
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 📈 CARDS RESUMO
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      title: "Matérias ativas",
                      value: "$total",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statCard(
                      title: "Tarefas feitas",
                      value: "$done",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 📋 PRÓXIMAS TAREFAS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Próximas tarefas",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              if (nextTasks.isEmpty)
                const Text(
                  "Nenhuma tarefa pendente 🎉",
                  style: TextStyle(color: AppTheme.textSecondary),
                ),

              ...nextTasks.map((t) => TaskCard(
                task: t,
                onTap: () async {
                  final updated = Task(
                    id: t.id,
                    title: t.title,
                    description: t.description,
                    done: !t.done,
                    tag: t.tag,
                    tagType: t.tagType,
                  );

                  await DatabaseHelper.instance.updateTask(updated);
                  loadTasks();
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}